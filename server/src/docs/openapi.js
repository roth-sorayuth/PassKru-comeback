import { parse } from "yaml";
import { readFileSync } from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Load the clean openapi.yaml specification
export const openApiSpec = parse(readFileSync(path.join(__dirname, "openapi.yaml"), "utf8"));
