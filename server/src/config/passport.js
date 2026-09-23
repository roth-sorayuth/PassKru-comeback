import passport from "passport";
import { Strategy as GoogleStrategy } from "passport-google-oauth20";
import { prisma } from "./prisma.js";

passport.use(
  new GoogleStrategy(
    {
      clientID: process.env.GOOGLE_CLIENT_ID || "dummy_client_id",
      clientSecret: process.env.GOOGLE_CLIENT_SECRET || "dummy_client_secret",
      callbackURL: process.env.GOOGLE_CALLBACK_URL || "/api/auth/google/callback",
    },
    async (accessToken, refreshToken, profile, done) => {
      try {
        const googleId = profile.id;
        const rawEmail = profile.emails?.[0]?.value;
        const email = rawEmail ? rawEmail.trim().toLowerCase() : null;
        const firstName = profile.name?.givenName || profile.displayName || "User";
        const lastName = profile.name?.familyName || "";
        const avatarUrl = profile.photos?.[0]?.value || null;

        if (!email && !googleId) {
          return done(new Error("No email or google_id provided by Google"), null);
        }

        // 1. Look up user by google_id
        let user = await prisma.user.findFirst({
          where: { googleId },
        });

        // 2. If not found by google_id, look up by normalized email
        if (!user && email) {
          user = await prisma.user.findUnique({
            where: { email },
          });

          // 3. If found by email but google_id is null, backfill google_id and avatar_url
          if (user) {
            user = await prisma.user.update({
              where: { userId: user.userId },
              data: {
                googleId,
                avatarUrl: user.avatarUrl || avatarUrl,
              },
            });
          }
        }

        // 4. If not found at all, INSERT a new user (handling race condition P2002 on concurrent callback)
        if (!user) {
          try {
            user = await prisma.user.create({
              data: {
                firstName,
                lastName,
                email: email || `${googleId}@google.local`,
                googleId,
                avatarUrl,
                role: "candidate",
                passwordHash: "managed-by-google",
                isEmailVerified: true,
              },
            });
          } catch (createError) {
            if (createError?.code === "P2002") {
              // Parallel request created the user concurrently, fetch existing user
              user = await prisma.user.findFirst({
                where: {
                  OR: [
                    { googleId },
                    ...(email ? [{ email }] : []),
                  ],
                },
              });
              if (user && !user.googleId && googleId) {
                user = await prisma.user.update({
                  where: { userId: user.userId },
                  data: {
                    googleId,
                    avatarUrl: user.avatarUrl || avatarUrl,
                  },
                });
              }
            } else {
              throw createError;
            }
          }
        }

        if (!user) {
          return done(new Error("Failed to retrieve or create user from Google profile"), null);
        }

        return done(null, user);
      } catch (error) {
        return done(error, null);
      }
    }
  )
);

export default passport;
