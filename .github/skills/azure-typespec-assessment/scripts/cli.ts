import fs from "node:fs";
import path from "node:path";
import { pathToFileURL } from "node:url";

let resolvedEntryPath: string | undefined;

let resolvedEntryUrl: string | undefined;

type ParseArgsOptions = {
  defaults?: Record<string, CliArgumentValue>;
  booleans?: string[];
  arrays?: string[];
  required?: string[];
};
type CliArgumentValue = string | boolean | string[] | undefined;

export function parseArgs(
  argv: string[],
  options: ParseArgsOptions = {},
): Record<string, CliArgumentValue> & {
  _?: string[];
} {
  const result: Record<string, CliArgumentValue> & {
    _?: string[];
  } = { ...options.defaults };
  for (let index = 0; index < argv.length; index += 1) {
    const token = argv[index];
    if (!token.startsWith("--")) {
      const positional = result._ ?? [];
      positional.push(token);
      result._ = positional;
      continue;
    }
    const [rawName, inlineValue] = token.slice(2).split("=", 2);
    const name = rawName.replaceAll("-", "_");
    if (options.booleans?.includes(rawName)) {
      result[name] = inlineValue === undefined ? true : inlineValue !== "false";
      continue;
    }
    const value = inlineValue ?? argv[++index];
    if (value === undefined || value.startsWith("--")) {
      throw new Error(`Missing value for --${rawName}.`);
    }
    if (options.arrays?.includes(rawName)) {
      const values = Array.isArray(result[name]) ? result[name] : [];
      values.push(value);
      result[name] = values;
    } else {
      result[name] = value;
    }
  }
  for (const required of options.required ?? []) {
    if (result[required.replaceAll("-", "_")] === undefined) {
      throw new Error(`Missing required argument --${required}.`);
    }
  }
  return result;
}

export function readJson(file: string): unknown {
  return JSON.parse(fs.readFileSync(file, "utf8")) as unknown;
}

export function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

export function readJsonObject(file: string): Record<string, unknown> {
  const value = readJson(file);
  if (!isRecord(value)) {
    throw new TypeError(`Expected a JSON object in ${file}.`);
  }
  return value;
}

export function writeJson(file: string, value: unknown) {
  fs.mkdirSync(path.dirname(file), { recursive: true });
  fs.writeFileSync(file, `${JSON.stringify(value, null, 2)}\n`);
}

export function isMain(metaUrl: string): boolean {
  if (!process.argv[1]) return false;
  const entryPath = path.resolve(process.argv[1]);
  if (metaUrl === pathToFileURL(entryPath).href) return true;
  // Node resolves linked entrypoints, while argv retains the junction/symlink path.
  if (resolvedEntryPath !== entryPath) {
    resolvedEntryPath = entryPath;
    resolvedEntryUrl = fs.existsSync(entryPath)
      ? pathToFileURL(fs.realpathSync(entryPath)).href
      : undefined;
  }
  return metaUrl === resolvedEntryUrl;
}

export async function runMain(action: () => void | Promise<void>): Promise<void> {
  try {
    await action();
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    process.exitCode = 1;
  }
}
