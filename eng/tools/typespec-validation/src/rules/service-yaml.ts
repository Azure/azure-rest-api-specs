import { readFile } from "fs/promises";
import { dirname, join, resolve } from "path";
import { type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import { parseServiceYaml } from "../service-yaml.ts";
import { parse as parseTspConfig } from "../tsp-config.ts";
import { fileExists, readTspConfig } from "../utils.ts";

const autorestEmitter = "@azure-tools/typespec-autorest";

export class ServiceYamlRule implements Rule {
  readonly name = "ServiceYaml";

  readonly description =
    "Must have a service.yaml manifest whose swagger-files all point to existing files";

  readonly suppressable = true;

  async execute(folder: string): Promise<RuleResult> {
    const serviceYamlPath = join(folder, "service.yaml");
    const serviceYamlExists = await fileExists(serviceYamlPath);

    if (!serviceYamlExists) {
      if (!(await fileExists(join(folder, "main.tsp")))) {
        // A project without main.tsp is not a compilable service (it is a shared/aggregate folder
        // whose real manifests live in sub-projects), so it has no versions to declare.
        return { success: true, stdOutput: "Skipped: main.tsp not found\n" };
      }

      if (!(await fileExists(join(folder, "tspconfig.yaml")))) {
        return { success: true, stdOutput: "Skipped: tspconfig.yaml not found\n" };
      }

      const config = parseTspConfig(await readTspConfig(folder));
      if (!config?.emit?.includes(autorestEmitter)) {
        return {
          success: true,
          stdOutput: `Skipped: tspconfig.yaml does not emit "${autorestEmitter}"\n`,
        };
      }

      return {
        success: false,
        errorOutput:
          `Missing service.yaml at ${serviceYamlPath}.\n\n` +
          `Every TypeSpec project emitting "${autorestEmitter}" must declare its API versions in a ` +
          `service.yaml next to tspconfig.yaml:\n\n` +
          `versions:\n` +
          `  - version: 2024-06-01\n` +
          `    source: typespec\n` +
          `    swagger-files:\n` +
          `      - resource-manager/Contoso/stable/2024-06-01/openapi.json\n\n` +
          `Create an empty service.yaml and run "tsp compile ." to have the autorest emitter fill ` +
          `it in, then add any legacy swagger-only versions by hand.`,
      };
    }

    const parsed = parseServiceYaml(await readFile(serviceYamlPath, { encoding: "utf8" }));
    if (!parsed.success) {
      return { success: false, errorOutput: `${serviceYamlPath}: ${parsed.error}` };
    }

    const serviceYamlFolder = dirname(serviceYamlPath);
    const missing: string[] = [];
    let swaggerFileCount = 0;

    for (const version of parsed.value.versions) {
      for (const swaggerFile of version["swagger-files"] ?? []) {
        swaggerFileCount++;
        if (!(await fileExists(resolve(serviceYamlFolder, swaggerFile)))) {
          missing.push(`  - version "${version.version}": ${swaggerFile}`);
        }
      }
    }

    const stdOutput = `Validated ${swaggerFileCount} swagger file(s) across ${parsed.value.versions.length} version(s)\n`;

    if (missing.length > 0) {
      return {
        success: false,
        stdOutput,
        errorOutput:
          `${serviceYamlPath} references swagger files that do not exist ` +
          `(paths are relative to service.yaml and are case-sensitive):\n\n` +
          `${missing.join("\n")}\n\n` +
          `For "source: typespec" versions, run "tsp compile ." to regenerate the swagger and ` +
          `update service.yaml. For "source: swagger" versions, correct the path by hand or remove ` +
          `the version if it no longer exists.`,
      };
    }

    return { success: true, stdOutput };
  }
}
