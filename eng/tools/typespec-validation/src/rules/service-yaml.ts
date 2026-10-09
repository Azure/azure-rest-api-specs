import type { ILogger } from "@azure-tools/specs-shared/logger";
import { readFile } from "node:fs/promises";
import { dirname, join, resolve } from "pathe";
import { filePath, indent, lines, text, type DiagnosticContent } from "../diagnostic-content.ts";
import { failure, type RuleResult } from "../rule-result.ts";
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

  async execute(folder: string, logger: ILogger): Promise<RuleResult> {
    const serviceYamlPath = join(folder, "service.yaml");
    const serviceYamlExists = await fileExists(serviceYamlPath);

    if (!serviceYamlExists) {
      if (!(await fileExists(join(folder, "main.tsp")))) {
        // A project without main.tsp is not a compilable service (it is a shared/aggregate folder
        // whose real manifests live in sub-projects), so it has no versions to declare.
        return { success: true, skipped: "main.tsp not found" };
      }

      if (!(await fileExists(join(folder, "tspconfig.yaml")))) {
        return { success: true, skipped: "tspconfig.yaml not found" };
      }

      const config = parseTspConfig(await readTspConfig(folder), join(folder, "tspconfig.yaml"));
      if (!config?.emit?.includes(autorestEmitter)) {
        return {
          success: true,
          skipped: `tspconfig.yaml does not emit "${autorestEmitter}"`,
        };
      }

      return failure("service-yaml", "Missing service.yaml.", {
        path: serviceYamlPath,
        help: 'Create an empty service.yaml and run "tsp compile ." to declare emitted API versions, then add any legacy swagger-only versions by hand.',
      });
    }

    const parsed = parseServiceYaml(await readFile(serviceYamlPath, { encoding: "utf8" }));
    if (!parsed.success) {
      return failure("service-yaml", parsed.error, { path: serviceYamlPath });
    }

    const serviceYamlFolder = dirname(serviceYamlPath);
    const missing: DiagnosticContent[] = [];
    let swaggerFileCount = 0;

    for (const version of parsed.value.versions) {
      for (const swaggerFile of version["swagger-files"] ?? []) {
        swaggerFileCount++;
        if (!(await fileExists(resolve(serviceYamlFolder, swaggerFile)))) {
          missing.push(text`- version "${version.version}": ${filePath(swaggerFile)}`);
        }
      }
    }

    logger.debug(
      `Validated ${swaggerFileCount} swagger file(s) across ${parsed.value.versions.length} version(s)`,
    );

    if (missing.length > 0) {
      return failure(
        "service-yaml",
        `Manifest references swagger files that do not exist ` +
          `(paths are relative to service.yaml and are case-sensitive):`,
        {
          path: serviceYamlPath,
          details: indent(lines(missing)),
          help:
            `For "source: typespec" versions, run "tsp compile ." to regenerate the swagger and ` +
            `update service.yaml. For "source: swagger" versions, correct the path by hand or remove ` +
            `the version if it no longer exists.`,
        },
      );
    }

    return { success: true };
  }
}
