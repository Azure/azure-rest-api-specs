import type { ILogger } from "@azure-tools/specs-shared/logger";
import { readFile } from "node:fs/promises";
import path from "pathe";
import { simpleGit } from "simple-git";
import { globFiles } from "../glob.ts";
import { failure, type Diagnostic, type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";
import { parse } from "../tsp-config.ts";
import { fileExists, getStructureVersion, getSuppressions, readTspConfig } from "../utils.ts";

export class FolderStructureRule implements Rule {
  readonly name = "FolderStructure";
  readonly description = "Verify spec directory's folder structure and naming conventions.";
  readonly suppressable = true;
  async execute(folder: string, logger: ILogger): Promise<RuleResult> {
    let success = true;
    const diagnostics: Diagnostic[] = [];
    const gitRoot = path.resolve(await simpleGit(folder).revparse("--show-toplevel"));
    const relativePath = path.relative(gitRoot, folder);

    const structureVersion = getStructureVersion(relativePath);

    if (structureVersion === 1) {
      const suppressions = (await getSuppressions(folder)).filter((s) =>
        s.rules?.includes(this.name),
      );
      const suppressMustUseV2 = suppressions.find((s) => s.subRules?.includes("MustUseV2"));

      if (suppressMustUseV2) {
        logger.debug(`Folder '${folder}' is not using "folder structure v2", but was suppressed.`);
      } else {
        return failure("folder-structure", 'Project must use "folder structure v2".', {
          path: folder,
          url: "https://aka.ms/azsdk/spec-dirs",
        });
      }
    }

    logger.debug(`folder: ${folder}`);
    if (!(await fileExists(folder))) {
      return failure("folder-structure", "Folder does not exist.", { path: folder });
    }

    const tspConfigs = await globFiles([`${folder}/**tspconfig.*`]);
    logger.debug(`config files: ${JSON.stringify(tspConfigs)}`);
    tspConfigs.forEach((file: string) => {
      if (!file.endsWith("tspconfig.yaml")) {
        success = false;
        diagnostics.push({
          severity: "error",
          code: "folder-structure",
          path: file,
          message: "Invalid config file. Must be named 'tspconfig.yaml'.",
        });
      }
    });

    // Verify tspconfig, main.tsp, examples/
    const mainExists = await fileExists(path.join(folder, "main.tsp"));
    const clientExists = await fileExists(path.join(folder, "client.tsp"));
    const tspConfigExists = await fileExists(path.join(folder, "tspconfig.yaml"));

    if (!mainExists && !clientExists) {
      diagnostics.push({
        severity: "error",
        code: "folder-structure",
        path: folder,
        message: `Invalid folder structure: Spec folder must contain main.tsp or client.tsp.`,
      });
      success = false;
    }

    if (mainExists && !(await fileExists(path.join(folder, "examples")))) {
      diagnostics.push({
        severity: "error",
        code: "folder-structure",
        path: folder,
        message: `Invalid folder structure: Spec folder with main.tsp must contain examples folder.`,
      });
      success = false;
    }

    const folderStruct = relativePath.split("/").filter(Boolean);

    // Verify top level folder is lower case and remove empty entries when splitting by slash
    if (folderStruct[1].match(/[A-Z]/g)) {
      success = false;
      diagnostics.push({
        severity: "error",
        code: "folder-structure",
        path: folder,
        message: `Invalid folder name. Folders under specification/ must be lower case.\n`,
      });
    }

    if (structureVersion === 1) {
      const packageFolder = folderStruct[folderStruct.length - 1];

      if (!packageFolder.includes("Shared") && !tspConfigExists) {
        diagnostics.push({
          severity: "error",
          code: "folder-structure",
          path: folder,
          message: `Invalid folder structure: Spec folder must contain tspconfig.yaml.`,
        });
        success = false;
      }

      // Verify package folder is at most 3 levels deep
      if (folderStruct.length > 4) {
        success = false;
        diagnostics.push({
          severity: "error",
          code: "folder-structure",
          path: folder,
          message: `Please limit TypeSpec folder depth to 3 levels or less`,
        });
      }

      // Verify second level folder is capitalized after each '.'
      if (/(^|\. *)([a-z])/g.test(packageFolder)) {
        success = false;
        diagnostics.push({
          severity: "error",
          code: "folder-structure",
          path: folder,
          message: `Invalid folder name. Folders under specification/${folderStruct[1]} must be capitalized after each '.'\n`,
        });
      }

      // Verify 'Shared' follows 'Management'
      if (packageFolder.includes("Management") && packageFolder.includes("Shared")) {
        if (!packageFolder.includes("Management.Shared")) {
          success = false;
          diagnostics.push({
            severity: "error",
            code: "folder-structure",
            path: folder,
            message: `Invalid folder name. For management libraries with a shared component, 'Shared' should follow 'Management'.`,
          });
        }
      }

      if (tspConfigExists) {
        const configText = await readTspConfig(folder);
        const config = parse(configText, path.join(folder, "tspconfig.yaml"));
        const rpFolder =
          config?.options?.["@azure-tools/typespec-autorest"]?.["azure-resource-provider-folder"];
        logger.debug(`azure-resource-provider-folder: ${JSON.stringify(rpFolder)}`);

        if (
          rpFolder?.trim()?.endsWith("resource-manager") &&
          !packageFolder.endsWith(".Management")
        ) {
          diagnostics.push({
            severity: "error",
            code: "folder-structure",
            path: folder,
            message: `Invalid folder structure: TypeSpec for resource-manager specs must be in a folder ending with '.Management'`,
          });
          success = false;
        } else if (
          !rpFolder?.trim()?.endsWith("resource-manager") &&
          packageFolder.endsWith(".Management")
        ) {
          diagnostics.push({
            severity: "error",
            code: "folder-structure",
            path: folder,
            message: `Invalid folder structure: TypeSpec for data-plane specs or shared code must be in a folder NOT ending with '.Management'`,
          });
          success = false;
        }
      }
    } else if (structureVersion === 2) {
      if (!tspConfigExists) {
        diagnostics.push({
          severity: "error",
          code: "folder-structure",
          path: folder,
          message: `Invalid folder structure: Spec folder must contain tspconfig.yaml.`,
        });
        success = false;
      }

      const specType = folder.includes("data-plane") ? "data-plane" : "resource-manager";
      if (specType === "data-plane") {
        if (folderStruct.length !== 4) {
          diagnostics.push({
            severity: "error",
            code: "folder-structure",
            path: folder,
            message:
              "TypeSpec for data-plane specs must be in a folder exactly one level under 'data-plane', like 'specification/foo/data-plane/FooAnalytics'.",
          });
          success = false;
        }
      } else if (specType === "resource-manager") {
        if (folderStruct.length !== 5) {
          diagnostics.push({
            severity: "error",
            code: "folder-structure",
            path: folder,
            message:
              "TypeSpec for resource-manager specs must be in a folder exactly two levels under 'resource-manager', like 'specification/foo/resource-manager/Microsoft.Foo/Foo'.",
          });
          success = false;
        }

        const rpNamespaceRegex = /^[A-Za-z0-9.]+$/;
        const rpNamespaceFolder = folderStruct[folderStruct.length - 2];

        if (!rpNamespaceRegex.test(rpNamespaceFolder)) {
          success = false;
          diagnostics.push({
            severity: "error",
            code: "folder-structure",
            path: folder,
            message: `RPNamespace folder '${rpNamespaceFolder}' does not match regex ${rpNamespaceRegex}`,
          });
        }
      }

      const serviceRegex = /^[A-Za-z0-9]+$/;
      const serviceFolder = folderStruct[folderStruct.length - 1];

      if (!serviceRegex.test(serviceFolder)) {
        success = false;
        diagnostics.push({
          severity: "error",
          code: "folder-structure",
          path: folder,
          message: `Service folder '${serviceFolder}' does not match regex ${serviceRegex}. Service folders must use PascalCase without any special characters (e.g. dot, hyphen, underscore).`,
        });
      }
    }

    // Ensure specs only import files from same folder under "specification"
    logger.debug("imports:");

    const allowedImportRoot =
      structureVersion === 1 ? path.join(...folderStruct.slice(0, 2)) : folder;
    logger.debug(`  ${allowedImportRoot}`);

    const allowedImportRootResolved = path.resolve(gitRoot, allowedImportRoot);

    const tsps = await globFiles("**/*.tsp", { cwd: allowedImportRootResolved });

    for (const tsp of tsps) {
      const tspResolved = path.resolve(allowedImportRootResolved, tsp);

      const pattern = /^\s*import\s+['"]([^'"]+)['"]\s*;\s*$/gm;
      const text = await readFile(tspResolved, { encoding: "utf8" });
      const imports = [...text.matchAll(pattern)];

      // The path specified in the import must either start with "./" or "../", or be an absolute path.
      // The path should either point to a directory, or have an extension of either ".tsp" or ".js".
      // https://typespec.io/docs/language-basics/imports/
      //
      // We don't bother checking if the path has an extension of ".tsp" or ".js", because a directory
      // is also valid, and a directory could be named anything.  We only care if the path is under
      // $teamFolder, so we just treat anything that looks like a relative or absolute path,
      // as a path.
      const fileImports = imports.filter(
        (match) =>
          match[1].startsWith("./") || match[1].startsWith("../") || path.isAbsolute(match[1]),
      );

      logger.debug(`    ${tsp}: ${JSON.stringify(fileImports.map((match) => match[1]))}`);

      for (const match of fileImports) {
        const fileImport = match[1];
        const fileImportResolved = path.resolve(path.dirname(tspResolved), fileImport);

        const relative = path.relative(allowedImportRootResolved, fileImportResolved);

        if (relative.startsWith("..")) {
          const prefix = text.slice(0, match.index + match[0].indexOf(fileImport)).split(/\r?\n/);
          diagnostics.push({
            severity: "error",
            code: "import-outside-project",
            path: tspResolved,
            location: { line: prefix.length, column: prefix[prefix.length - 1].length + 1, text },
            message: `'${tsp}' imports '${fileImport}', which is outside '${path.relative(gitRoot, allowedImportRoot)}'`,
          });
          success = false;
        }
      }
    }

    return {
      success: success,
      diagnostics,
    };
  }
}
