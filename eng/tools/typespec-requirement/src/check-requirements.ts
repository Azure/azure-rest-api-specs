import { readdir, readFile } from "node:fs/promises";
import { posix, relative, resolve, sep } from "node:path";
import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import { getSuppressions } from "@azure-tools/suppressions";
import { hasTypeSpecGeneratedSwagger, isTypeSpecGenerated } from "./migration.ts";

export type SpecType = "data-plane" | "resource-manager";

export interface RequirementOptions {
  repoRoot: string;
  baseCommitish: string;
  checkAllUnder?: string;
  headCommitish: string;
  responseCache: Record<string, number>;
  specType?: SpecType;
}

export interface RequirementReporter {
  info: (message: string) => void;
  warning: (message: string) => void;
  warningForFile: (file: string, message: string) => void;
  error: (message: string) => void;
  errorForFile: (file: string, message: string) => void;
  jobFailure: () => void;
  /** Preserve incremental legacy output if a later file throws. */
  brownfield?: () => Promise<void>;
}

export interface RequirementResult {
  brownfield: boolean;
  exitCode: number;
}

interface FileToCheck {
  fullPath: string;
  path: string;
  previousPath?: string;
}

const excludedSwaggerPaths = /\/(examples|scenarios|restler|common|common-types)\//i;

async function getFilesUnder(directory: string): Promise<string[]> {
  const files: string[] = [];
  for (const entry of await readdir(directory, { withFileTypes: true })) {
    const path = resolve(directory, entry.name);
    if (entry.isDirectory()) {
      files.push(...(await getFilesUnder(path)));
    } else if (entry.isFile()) {
      files.push(path);
    }
  }
  return files;
}

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

async function getFilesToCheck(options: RequirementOptions): Promise<FileToCheck[]> {
  const { repoRoot } = options;
  let files: FileToCheck[];
  if (options.checkAllUnder) {
    const directory = resolve(repoRoot, options.checkAllUnder);
    files = (await getFilesUnder(directory)).map((fullPath) => {
      const pathSegments = fullPath.split(sep);
      const specificationIndex = pathSegments.lastIndexOf("specification");
      return {
        fullPath,
        path:
          specificationIndex >= 0
            ? pathSegments.slice(specificationIndex).join("/")
            : relative(repoRoot, fullPath).split(sep).join("/"),
      };
    });
  } else {
    const changes = await getChangedFilesStatuses({
      cwd: repoRoot,
      baseCommitish: options.baseCommitish,
      headCommitish: options.headCommitish,
      gitOptions: ["--find-renames"],
    });
    const previousPaths = new Map(changes.renames.map(({ from, to }) => [to, from]));
    files = [...changes.additions, ...changes.modifications, ...previousPaths.keys()]
      .sort()
      .filter(
        (file) =>
          file.startsWith("specification/") &&
          file.endsWith(".json") &&
          !file.includes("ChangedFiles-Functions"),
      )
      .map((path) => ({
        path,
        fullPath: resolve(repoRoot, path),
        previousPath: previousPaths.get(path),
      }));
  }

  const specTypePattern =
    options.specType === "data-plane"
      ? /^specification\/[^/]+\/(data-plane).*?\/(preview|stable)\/[^/]+\/[^/]+\.json$/i
      : options.specType === "resource-manager"
        ? /^specification\/[^/]+\/(resource-manager).*?\/(preview|stable)\/[^/]+\/[^/]+\.json$/i
        : /^specification\/[^/]+\/(data-plane|resource-manager).*?\/(preview|stable)\/[^/]+\/[^/]+\.json$/i;
  return files.filter(({ path }) => !excludedSwaggerPaths.test(path) && specTypePattern.test(path));
}

function getApiVersion(file: string, specType?: SpecType): string | undefined {
  const pattern =
    specType === "data-plane"
      ? /^specification\/((?:[^/]+\/)(?:data-plane).*?\/(?:preview|stable)\/[^/]+)\/[^/]+\.json$/i
      : specType === "resource-manager"
        ? /^specification\/((?:[^/]+\/)(?:resource-manager).*?\/(?:preview|stable)\/[^/]+)\/[^/]+\.json$/i
        : /^specification\/((?:[^/]+\/)(?:data-plane|resource-manager).*?\/(?:preview|stable)\/[^/]+)\/[^/]+\.json$/i;
  const match = pattern.exec(file);
  return match?.[1];
}

function getRelocatedApiVersionDirectories(files: FileToCheck[], specType?: SpecType): Set<string> {
  const directories = new Set<string>();
  for (const { path, previousPath } of files) {
    if (!previousPath || excludedSwaggerPaths.test(previousPath)) continue;
    const previousVersion = getApiVersion(previousPath, specType);
    const version = getApiVersion(path, specType);
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

function getServiceDirectory(fullPath: string, servicePath: string): string | undefined {
  const serviceName = /^specification\/([^/]+)\//.exec(servicePath)?.[1];
  if (!serviceName) {
    return undefined;
  }

  const normalizedPath = fullPath.split(sep).join("/");
  const serviceMarker = `/specification/${serviceName}/`;
  const serviceIndex = normalizedPath.lastIndexOf(serviceMarker);
  if (serviceIndex < 0) {
    return undefined;
  }
  return normalizedPath.slice(0, serviceIndex + serviceMarker.length - 1);
}

export async function checkRequirements(
  options: RequirementOptions,
  reporter: RequirementReporter,
): Promise<RequirementResult> {
  const {
    info: logInfo,
    warning: logWarning,
    warningForFile: logWarningForFile,
    error: logError,
    errorForFile: logErrorForFile,
    jobFailure: logJobFailure,
  } = reporter;
  const pathsWithErrors: string[] = [];
  const serviceTypeSpecCache = new Map<string, boolean>();
  let brownfield = false;
  const filesToCheck = await getFilesToCheck(options);
  const relocatedApiVersions = getRelocatedApiVersionDirectories(filesToCheck, options.specType);

  if (filesToCheck.length === 0) {
    logInfo("No OpenAPI files found to check");
  }

  for (const { fullPath, path: file } of filesToCheck) {
    logInfo(`Checking ${file}`);

    const generated = isTypeSpecGenerated(await readFile(fullPath, "utf8"), file, logWarning);
    const suppressions = await getSuppressions("TypeSpecRequirement", fullPath);
    const suppression = suppressions[0];
    let serviceHasTypeSpecGeneratedSwagger = false;
    if (suppression) {
      const singleVersionPattern = /\/(preview|stable)\/[A-Za-z0-9._-]+\//i;
      for (const path of suppression.paths) {
        const suppressionPath = String(path);
        if (!singleVersionPattern.test(suppressionPath)) {
          logError(
            `Invalid path '${suppressionPath}'.  Path must only include one version per suppression.`,
          );
          logJobFailure();
          return { brownfield, exitCode: 1 };
        }
      }
      if (relocatedApiVersions.has(posix.dirname(file))) {
        logInfo(
          `  Suppressed: ${String(suppression.reason ?? "<no reason specified>")} (existing API version relocated)`,
        );
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
        logInfo(`  Suppressed: ${String(suppression.reason ?? "<no reason specified>")}`);
        continue;
      }
    }

    if (generated) {
      logInfo("  OpenAPI was generated from TypeSpec (contains '/info/x-typespec-generated')");
      const rpFolder = /^specification\/[^/]+\//.exec(file)?.[0];
      if (!rpFolder) {
        logError("Path to OpenAPI did not match expected regex.  Unable to extract RP folder.");
        logJobFailure();
        return { brownfield, exitCode: 1 };
      }

      const serviceDirectory = getServiceDirectory(fullPath, file);
      if (!serviceDirectory) {
        logError("Path to OpenAPI did not match expected regex.  Unable to extract RP folder.");
        logJobFailure();
        return { brownfield, exitCode: 1 };
      }
      const tspConfigs = await findFilesNamed(serviceDirectory, "tspconfig.yaml");
      if (tspConfigs.length > 0) {
        logInfo(
          `  Folder '${rpFolder}' contains ${tspConfigs.length} file(s) named 'tspconfig.yaml'`,
        );
      } else {
        logError(
          `OpenAPI was generated from TypeSpec, but folder '${rpFolder}' contains no files named 'tspconfig.yaml'.  The TypeSpec used to generate OpenAPI must be added to this folder.`,
        );
        logJobFailure();
        return { brownfield, exitCode: 1 };
      }
      continue;
    }

    logInfo("  OpenAPI was not generated from TypeSpec (missing '/info/x-typespec-generated')");
    const apiVersion = getApiVersion(file, options.specType);
    if (!apiVersion) {
      logError("Path to OpenAPI did not match expected regex.  Unable to extract service path.");
      logJobFailure();
      return { brownfield, exitCode: 1 };
    }

    const url = `https://github.com/Azure/azure-rest-api-specs/tree/main/specification/${apiVersion}`;
    const logUrl = url.replace(/^https:\/\//, "");
    logInfo(`  Checking ${logUrl}`);

    let responseStatus = options.responseCache[url];
    if (responseStatus !== undefined) {
      logInfo("    Found in cache");
    } else {
      logInfo("    Not found in cache, making web request");
      try {
        responseStatus = (await fetch(url, { method: "HEAD" })).status;
        options.responseCache[url] = responseStatus;
      } catch (error) {
        logError(`Exception making web request to ${logUrl}: ${String(error)}`);
        logJobFailure();
        return { brownfield, exitCode: 1 };
      }
    }

    logInfo(`    Status: ${responseStatus}`);
    if (responseStatus === 200) {
      if (suppression) {
        logInfo(`  Suppressed: ${String(suppression.reason ?? "<no reason specified>")}`);
        continue;
      }
      logInfo(
        `  Branch 'main' contains path '${apiVersion}', so API version already exists and is not required to use TypeSpec`,
      );
      const warning =
        "WARNING: This PR uses OpenAPI / Swagger. All Azure services are required to convert to TypeSpec by March 30, 2026. PRs not using TypeSpec will be blocked after that date. Starting July 1, 2026, all SDKs will be generated from TypeSpec as the autorest toolchain is being retired. Please reach out to tspconversion@service.microsoft.com with any questions and see http://aka.ms/azsdk/typespec for more details on TypeSpec.";
      logWarningForFile(file, warning);
      brownfield = true;
      await reporter.brownfield?.();
    } else if (responseStatus === 404) {
      logInfo(
        `  Branch 'main' does not contain path '${apiVersion}', so API version is new and must use TypeSpec`,
      );
      if (serviceHasTypeSpecGeneratedSwagger) {
        logInfo(
          "  TypeSpecRequirement suppressions cannot permit new handwritten API versions because this service contains TypeSpec-generated Swagger.",
        );
      }
      pathsWithErrors.push(file);
    } else {
      logError(`Unexpected response from ${logUrl}: ${responseStatus}`);
      logJobFailure();
      return { brownfield, exitCode: 1 };
    }
  }

  if (pathsWithErrors.length > 0) {
    logError(
      "New specs must use TypeSpec.  For more detailed docs see https://aka.ms/azsdk/typespec",
    );
    logJobFailure();
    for (const path of pathsWithErrors) {
      logErrorForFile(
        path,
        "OpenAPI was not generated from TypeSpec, and API version appears to be new",
      );
    }
    return { brownfield, exitCode: 1 };
  }

  return { brownfield, exitCode: 0 };
}
