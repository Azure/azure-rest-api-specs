import { existsSync, globSync, readdirSync, readFileSync, statSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { isDeepStrictEqual } from "node:util";
import * as commonmark from "commonmark";
import { parse } from "yaml";
import {
  dataPlane,
  example,
  readme,
  resourceManager,
  swagger,
  tsp,
  tspconfig,
  typespec,
} from "@azure-tools/specs-shared/changed-files";
import { Readme } from "@azure-tools/specs-shared/readme";
import type { ImpactAssessment, ServiceImpact } from "@azure-tools/specs-shared/impact";
import type { PRContext } from "./PRContext.ts";

type Plane = ServiceImpact["plane"];

/** Describe the diff without making review-policy or label decisions. */
export async function evaluateImpact(
  context: PRContext,
  registeredRpaasServices: string[],
): Promise<ImpactAssessment> {
  const services = new Map<string, ServiceImpact>();
  const versionsByProvider = new Map<string, string[]>();
  const planesByDirectory = new Map<string, Plane>();
  const readmes = await context.getReadmeDiffs();
  const changedReadmes = [
    ...(readmes.additions ?? []),
    ...(readmes.changes ?? []),
    ...(readmes.deletions ?? []),
  ].map((entry) => entry.readme);

  const getService = (file: string): ServiceImpact | undefined => {
    const match = /^specification\/([^/]+)\//.exec(file);
    if (!match) return undefined;
    const path = `specification/${match[1]}`;
    const directory = dirname(file);
    let plane = planesByDirectory.get(directory);
    if (plane === undefined) {
      plane = getPlane(file, context);
      planesByDirectory.set(directory, plane);
    }
    const key = `${path}:${plane}`;
    let service = services.get(key);
    if (!service) {
      service = {
        path,
        plane,
        changes: [],
        typeSpec: false,
        newApiVersions: [],
        suppressionsChanged: false,
        resourceProvider: {
          newNamespaces: [],
          usesRpaas: false,
          hasAddedDefinitions: false,
          registered: registeredRpaasServices.includes(match[1]),
        },
      };
      services.set(key, service);
    }
    return service;
  };

  for (const file of context.getChangedFiles()) {
    const service = getService(file);
    if (!service) continue;
    const kind = getChangeKind(file);
    if (!service.changes.includes(kind)) service.changes.push(kind);
    const sourceFile = resolve(context.sourceDirectory, file);
    service.typeSpec ||=
      typespec(file) || (swagger(file) && isSwaggerGeneratedByTypeSpec(sourceFile));

    if (swagger(file) && context.fileList?.additions.includes(file)) {
      const provider = getRPFolderFromSwaggerFile(file);
      if (!provider) continue;
      const version = getApiVersionFromSwaggerFile(sourceFile);
      let existingVersions = versionsByProvider.get(provider);
      if (!existingVersions) {
        existingVersions = getAllApiVersionFromRPFolder(resolve(context.targetDirectory, provider));
        versionsByProvider.set(provider, existingVersions);
      }
      if (
        version &&
        !existingVersions.includes(version) &&
        !service.newApiVersions.includes(version)
      ) {
        service.newApiVersions.push(version);
      }
      if (service.plane === "resource-manager") {
        service.resourceProvider.hasAddedDefinitions = true;
        if (
          !existsSync(resolve(context.targetDirectory, provider)) &&
          !service.resourceProvider.newNamespaces.includes(provider)
        ) {
          service.resourceProvider.newNamespaces.push(provider);
        }
      }
    }
  }

  // Parent readmes carry RPaaS and suppression configuration even when only their specs changed.
  for (const file of changedReadmes) {
    const service = getService(file);
    if (!service) continue;
    const after = resolve(context.sourceDirectory, file);
    if (!existsSync(after)) continue;
    const config = await new Readme(after).getGlobalConfig();
    service.resourceProvider.usesRpaas ||=
      config["openapi-subtype"] === "rpaas" || config["openapi-subtype"] === "providerHub";
    service.suppressionsChanged ||=
      diffSuppression(resolve(context.targetDirectory, file), after).length > 0;
  }

  return {
    schemaVersion: 2,
    services: [...services.values()].sort((a, b) =>
      `${a.path}:${a.plane}`.localeCompare(`${b.path}:${b.plane}`),
    ),
  };
}

function getChangeKind(file: string): ServiceImpact["changes"][number] {
  if (tspconfig(file)) return "sdk-configuration";
  if (example(file)) return "examples";
  if (swagger(file) || tsp(file)) return "api";
  if (readme(file)) return "readme";
  return "other";
}

function getPlane(file: string, context: PRContext): Plane {
  if (resourceManager(file)) return "resource-manager";
  if (dataPlane(file)) return "data-plane";

  // Older TypeSpec projects live beside their emitted plane directory.
  for (const root of [context.sourceDirectory, context.targetDirectory]) {
    let folder = dirname(file);
    while (folder.startsWith("specification/")) {
      const configFile = resolve(root, folder, "tspconfig.yaml");
      if (existsSync(configFile)) {
        const config = parse(readFileSync(configFile, "utf8")) as {
          options?: Record<string, { "azure-resource-provider-folder"?: string }>;
          linter?: { extends?: string[] };
        } | null;
        const outputPlane =
          config?.options?.["@azure-tools/typespec-autorest"]?.["azure-resource-provider-folder"];
        for (const plane of ["resource-manager", "data-plane"] as const) {
          if (
            outputPlane === plane ||
            config?.linter?.extends?.includes(`@azure-tools/typespec-azure-rulesets/${plane}`)
          ) {
            return plane;
          }
        }
      }
      folder = dirname(folder);
    }
  }
  return "unknown";
}

function isSwaggerGeneratedByTypeSpec(file: string): boolean {
  try {
    const swagger = JSON.parse(readFileSync(file, "utf8")) as {
      info?: { "x-typespec-generated"?: unknown };
    };
    return !!swagger?.info?.["x-typespec-generated"];
  } catch {
    return false;
  }
}

export function getAllApiVersionFromRPFolder(rpFolder: string): string[] {
  if (!existsSync(rpFolder)) return [];
  const versions = globSync("**/*.json", { cwd: rpFolder })
    .filter((file) => !example(file))
    .map((file) => getApiVersionFromSwaggerFile(join(rpFolder, file)))
    .filter((version) => version !== undefined);
  return [...new Set(versions)];
}

export function getApiVersionFromSwaggerFile(file: string): string | undefined {
  const swagger = JSON.parse(readFileSync(file, "utf8")) as { info?: { version?: string } };
  return swagger.info?.version;
}

export function getRPFolderFromSwaggerFile(file: string): string | undefined {
  const provider = getResourceProviderFromFilePath(file);
  return provider === undefined
    ? undefined
    : file.substring(0, file.lastIndexOf(provider) + provider.length);
}

export function getResourceProviderFromFilePath(file: string): string | undefined {
  return (
    /\/([a-z0-9]+(?:\.[a-z0-9]+)+)\//i.exec(file)?.[1] ??
    /\/data-plane\/([a-z0-9]+)\//i.exec(file)?.[1]
  );
}

function getSuppressions(file: string): Record<string, unknown>[] {
  if (!existsSync(file)) return [];
  const walker = new commonmark.Parser().parse(readFileSync(file, "utf8")).walker();
  const suppressions: Record<string, unknown>[] = [];
  let event;
  while ((event = walker.next())) {
    if (!event.entering || event.node.type !== "code_block" || !event.node.literal) continue;
    try {
      const block = parse(event.node.literal) as {
        directive?: Record<string, unknown>[];
        suppressions?: Record<string, unknown>[];
      } | null;
      if (Array.isArray(block?.directive)) {
        suppressions.push(...block.directive.filter((directive) => directive.suppress));
      }
      if (Array.isArray(block?.suppressions)) suppressions.push(...block.suppressions);
    } catch (error) {
      console.warn(`Unable to read suppressions in ${file}: ${String(error)}`);
    }
  }
  return suppressions;
}

export function diffSuppression(before: string, after: string) {
  const previous = getSuppressions(before);
  return getSuppressions(after).filter(
    (suppression) =>
      !previous.some((entry) =>
        ["suppress", "from", "where", "code", "reason"].every((key) =>
          isDeepStrictEqual(entry[key], suppression[key]),
        ),
      ),
  );
}

export function getRPaaSFolderList(targetDirectory: string): string[] {
  const folder = join(targetDirectory, ".github", "arm-leases");
  try {
    if (!existsSync(folder)) return [];
    return readdirSync(folder).filter(
      (name) => name !== "scripts" && statSync(join(folder, name)).isDirectory(),
    );
  } catch (error) {
    console.warn(`Unable to read RPaaS registrations in ${folder}: ${String(error)}`);
    return [];
  }
}
