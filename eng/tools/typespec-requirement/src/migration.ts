import { execFile } from "@azure-tools/specs-shared/exec";
import { readdir, readFile } from "node:fs/promises";
import { join, relative, sep } from "node:path";

type LogWarning = (message: string) => void;

export function isTypeSpecGenerated(
  content: string,
  file: string,
  logWarning: LogWarning,
): boolean {
  let json: unknown;
  try {
    json = JSON.parse(content);
  } catch (error) {
    if (!(error instanceof SyntaxError)) throw error;
    logWarning(
      `OpenAPI '${file}' cannot be parsed as JSON, so assuming not generated from TypeSpec`,
    );
    logWarning(`  ${error.message}`);
    return false;
  }
  return (
    json !== null &&
    typeof json === "object" &&
    "info" in json &&
    json.info !== null &&
    typeof json.info === "object" &&
    "x-typespec-generated" in json.info &&
    json.info["x-typespec-generated"] !== null &&
    json.info["x-typespec-generated"] !== undefined
  );
}

async function getServiceSwaggers(directory: string): Promise<string[]> {
  const files: string[] = [];
  for (const stage of await readdir(directory, { withFileTypes: true })) {
    if (!stage.isDirectory() || !/^(preview|stable)$/i.test(stage.name)) continue;
    const stageDirectory = join(directory, stage.name);
    for (const version of await readdir(stageDirectory, { withFileTypes: true })) {
      if (!version.isDirectory()) continue;
      const versionDirectory = join(stageDirectory, version.name);
      for (const file of await readdir(versionDirectory, { withFileTypes: true })) {
        if (file.isFile() && /\.json$/i.test(file.name)) {
          files.push(`${stage.name}/${version.name}/${file.name}`);
        }
      }
    }
  }
  return files;
}

export async function findTypeSpecSwagger(
  directory: string,
  logWarning: LogWarning,
  base?: { repoRoot: string; commitish: string },
): Promise<string | undefined> {
  const currentFiles = await getServiceSwaggers(directory);
  for (const file of currentFiles) {
    if (isTypeSpecGenerated(await readFile(join(directory, file), "utf8"), file, logWarning)) {
      return file;
    }
  }

  if (base) {
    // Recognize migrated services even when a PR deletes or rewrites the last generated Swagger.
    const servicePath = relative(base.repoRoot, directory).split(sep).join("/");
    const { stdout } = await execFile(
      "git",
      ["ls-tree", "-r", "--name-only", "-z", base.commitish, "--", servicePath],
      { cwd: base.repoRoot },
    );
    for (const path of stdout.split("\0")) {
      if (!path.startsWith(`${servicePath}/`)) continue;
      const match = /^(preview|stable)\/([^/]+)\/[^/]+\.json$/i.exec(
        path.slice(servicePath.length + 1),
      );
      if (!match) continue;
      const { stdout: content } = await execFile("git", ["show", `${base.commitish}:${path}`], {
        cwd: base.repoRoot,
        maxBuffer: 64 * 1024 * 1024,
      });
      if (isTypeSpecGenerated(content, `${base.commitish}:${path}`, logWarning)) {
        return `${base.commitish}:${path}`;
      }
    }
  }
  return undefined;
}
