import type { Diagnostic } from "@azure-tools/specs-shared/rule-result";
import { readdir, readFile } from "node:fs/promises";
import { posix, resolve } from "pathe";
import type { PrContext } from "./context.ts";
import { hasTypeSpecGeneratedSwagger, isTypeSpecGenerated } from "./migration.ts";
import { ruleSuppressions } from "./suppressions.ts";

interface FileToCheck {
  fullPath: string;
  path: string;
  previousPath?: string;
}

export interface RequirementResult {
  readonly diagnostics: Diagnostic[];
  readonly brownfield: boolean | undefined;
  readonly checked: number;
}

export type CheckUpstream = (url: string) => Promise<number>;

const excludedSwaggerPaths = /\/(examples|scenarios|restler|common|common-types)\//i;
const swaggerPath =
  /^specification\/[^/]+\/(data-plane|resource-manager).*?\/(preview|stable)\/[^/]+\/[^/]+\.json$/i;

async function findFilesNamed(directory: string, fileName: string): Promise<string[]> {
  const files: string[] = [];
  for (const entry of await readdir(directory, { withFileTypes: true })) {
    const path = resolve(directory, entry.name);
    if (entry.isDirectory()) {
      files.push(...(await findFilesNamed(path, fileName)));
    } else if (entry.isFile() && entry.name.toLowerCase() === fileName.toLowerCase()) {
      files.push(path);
    }
  }
  return files;
}

function getFilesToCheck(context: PrContext): FileToCheck[] {
  const { changes, root } = context;
  const previousPaths = new Map(changes.renames.map(({ from, to }) => [to, from]));
  return [...changes.additions, ...changes.modifications, ...previousPaths.keys()]
    .sort()
    .filter(
      (file) =>
        file.startsWith("specification/") &&
        file.endsWith(".json") &&
        !file.includes("ChangedFiles-Functions") &&
        !excludedSwaggerPaths.test(file) &&
        swaggerPath.test(file),
    )
    .map((path) => ({
      path,
      fullPath: resolve(root, path),
      previousPath: previousPaths.get(path),
    }));
}

function getApiVersion(file: string): string | undefined {
  return /^specification\/((?:[^/]+\/)(?:data-plane|resource-manager).*?\/(?:preview|stable)\/[^/]+)\/[^/]+\.json$/i.exec(
    file,
  )?.[1];
}

function getRelocatedApiVersionDirectories(files: FileToCheck[]): Set<string> {
  const directories = new Set<string>();
  for (const { path, previousPath } of files) {
    if (!previousPath || excludedSwaggerPaths.test(previousPath)) continue;
    const previousVersion = getApiVersion(previousPath);
    const version = getApiVersion(path);
    if (
      previousVersion &&
      version &&
      previousVersion !== version &&
      posix.basename(previousVersion) === posix.basename(version) &&
      previousVersion.split("/").slice(0, 2).join("/").toLowerCase() ===
        version.split("/").slice(0, 2).join("/").toLowerCase()
    ) {
      directories.add(posix.dirname(path));
    }
  }
  return directories;
}

export async function checkRequirements(
  context: PrContext,
  checkUpstream: CheckUpstream = async (url) => (await fetch(url, { method: "HEAD" })).status,
): Promise<RequirementResult> {
  const diagnostics: Diagnostic[] = [];
  const serviceTypeSpecCache = new Map<string, boolean>();
  const responseCache = new Map<string, number>();
  let brownfield = false;
  let complete = true;
  const files = getFilesToCheck(context);
  const relocatedApiVersions = getRelocatedApiVersionDirectories(files);
  const logInfo = (message: string) => context.logger.debug(message);

  if (files.length === 0) logInfo("No OpenAPI files found to check");

  for (const { fullPath, path: file } of files) {
    logInfo(`Checking ${file}`);
    const logWarning = (message: string) =>
      diagnostics.push({ severity: "warning", code: "typespec-requirement", message, path: file });
    const logError = (message: string) =>
      diagnostics.push({ severity: "error", code: "typespec-requirement", message, path: file });

    try {
      const generated = isTypeSpecGenerated(await readFile(fullPath, "utf8"), file, logWarning);
      const suppression = (await ruleSuppressions(context, fullPath, "TypeSpecRequirement"))[0];
      let serviceHasTypeSpecGeneratedSwagger = false;
      if (suppression) {
        const invalidPath = suppression.paths.find(
          (path) => !/\/(preview|stable)\/[A-Za-z0-9._-]+\//i.test(path),
        );
        if (invalidPath) {
          complete = false;
          logError(
            `Invalid path '${invalidPath}'.  Path must only include one version per suppression.`,
          );
          continue;
        }
        if (relocatedApiVersions.has(posix.dirname(file))) {
          logInfo(`  Suppressed: ${suppression.reason} (existing API version relocated)`);
          continue;
        }
        if (!generated) {
          const serviceDirectory = resolve(fullPath, "../../..");
          const cached = serviceTypeSpecCache.get(serviceDirectory);
          if (cached === undefined) {
            serviceHasTypeSpecGeneratedSwagger = await hasTypeSpecGeneratedSwagger(
              serviceDirectory,
              logWarning,
            );
            serviceTypeSpecCache.set(serviceDirectory, serviceHasTypeSpecGeneratedSwagger);
          } else {
            serviceHasTypeSpecGeneratedSwagger = cached;
          }
        }
        if (!serviceHasTypeSpecGeneratedSwagger) {
          logInfo(`  Suppressed: ${suppression.reason}`);
          continue;
        }
      }

      if (generated) {
        logInfo("  OpenAPI was generated from TypeSpec (contains '/info/x-typespec-generated')");
        const rpFolder = /^specification\/[^/]+\//.exec(file)?.[0];
        if (!rpFolder) throw new Error(`Unable to extract specification service area: ${file}`);
        const tspConfigs = await findFilesNamed(resolve(context.root, rpFolder), "tspconfig.yaml");
        if (tspConfigs.length === 0) {
          logError(
            `OpenAPI was generated from TypeSpec, but folder '${rpFolder}' contains no files named 'tspconfig.yaml'.  The TypeSpec used to generate OpenAPI must be added to this folder.`,
          );
        } else {
          logInfo(
            `  Folder '${rpFolder}' contains ${tspConfigs.length} file(s) named 'tspconfig.yaml'`,
          );
        }
        continue;
      }

      logInfo("  OpenAPI was not generated from TypeSpec (missing '/info/x-typespec-generated')");
      const apiVersion = getApiVersion(file);
      if (!apiVersion) throw new Error(`Unable to extract API-version directory: ${file}`);
      const url = `https://github.com/Azure/azure-rest-api-specs/tree/main/specification/${apiVersion}`;
      logInfo(`  Checking ${url.replace(/^https:\/\//, "")}`);
      let status = responseCache.get(url);
      if (status === undefined) {
        status = await checkUpstream(url);
        responseCache.set(url, status);
      }
      logInfo(`    Status: ${status}`);
      if (status === 200) {
        if (suppression) {
          logInfo(`  Suppressed: ${suppression.reason}`);
          continue;
        }
        logInfo(
          `  Branch 'main' contains path '${apiVersion}', so API version already exists and is not required to use TypeSpec`,
        );
        logWarning(
          "WARNING: This PR uses OpenAPI / Swagger. All Azure services are required to convert to TypeSpec by March 30, 2026. PRs not using TypeSpec will be blocked after that date. Starting July 1, 2026, all SDKs will be generated from TypeSpec as the autorest toolchain is being retired. Please reach out to tspconversion@service.microsoft.com with any questions and see http://aka.ms/azsdk/typespec for more details on TypeSpec.",
        );
        brownfield = true;
      } else if (status === 404) {
        logInfo(
          `  Branch 'main' does not contain path '${apiVersion}', so API version is new and must use TypeSpec`,
        );
        if (serviceHasTypeSpecGeneratedSwagger) {
          logInfo(
            "  TypeSpecRequirement suppressions cannot permit new handwritten API versions because this service contains TypeSpec-generated Swagger.",
          );
        }
        logError("OpenAPI was not generated from TypeSpec, and API version appears to be new");
      } else {
        complete = false;
        logError(`Unexpected response from ${url}: ${status}`);
      }
    } catch (error) {
      complete = false;
      context.logger.debug(error instanceof Error ? (error.stack ?? error.message) : String(error));
      logError(`TypeSpec Requirement failed: ${String(error)}`);
    }
  }

  return {
    diagnostics,
    brownfield: complete || brownfield ? brownfield : undefined,
    checked: files.length,
  };
}
