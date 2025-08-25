import debug from "debug";
import { readFile } from "fs/promises";
import { globby } from "globby";
import path from "path";
import { simpleGit } from "simple-git";
import { parse as yamlParse } from "yaml";
import { RuleResult } from "../rule-result.js";
import { Rule } from "../rule.js";
import { fileExists, normalizePath, readTspConfig } from "../utils.js";

// Enable simple-git debug logging to improve console output
debug.enable("simple-git");

export class FolderStructureRule implements Rule {
  readonly name = "FolderStructure";
  readonly description = "Verify spec directory's folder structure and naming conventions.";
  async execute(folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";
    const gitRoot = normalizePath(await simpleGit(folder).revparse("--show-toplevel"));
    const relativePath = path.relative(gitRoot, folder).split(path.sep).join("/");

    // If the folder containing TypeSpec sources is under "data-plane" or "resource-manager", the spec
    // must be using "folder structure v2".  Otherwise, it must be using v1.
    const structureVersion =
      relativePath.includes("data-plane") || relativePath.includes("resource-manager") ? 2 : 1;

    stdOutput += `folder: ${folder}\n`;
    if (!(await fileExists(folder))) {
      return {
        success: false,
        stdOutput: stdOutput,
        errorOutput: `Folder '${folder}' does not exist.\n`,
      };
    }

    const tspConfigs = await globby([`${folder}/**tspconfig.*`]);
    stdOutput += `config files: ${JSON.stringify(tspConfigs)}\n`;
    tspConfigs.forEach((file: string) => {
      if (!file.endsWith("tspconfig.yaml")) {
        success = false;
        errorOutput += `Invalid config file '${file}'.  Must be named 'tspconfig.yaml'.\n`;
      }
    });

    // Verify tspconfig, main.tsp, examples/
    const mainExists = await fileExists(path.join(folder, "main.tsp"));
    const clientExists = await fileExists(path.join(folder, "client.tsp"));
    const tspConfigExists = await fileExists(path.join(folder, "tspconfig.yaml"));

    if (!mainExists && !clientExists) {
      errorOutput += `Invalid folder structure: Spec folder must contain main.tsp or client.tsp.`;
      success = false;
    }

    if (mainExists && !(await fileExists(path.join(folder, "examples")))) {
      errorOutput += `Invalid folder structure: Spec folder with main.tsp must contain examples folder.`;
      success = false;
    }

    const folderStruct = relativePath.split("/").filter(Boolean);

    // Verify top level folder is lower case and remove empty entries when splitting by slash
    if (folderStruct[1].match(/[A-Z]/g)) {
      success = false;
      errorOutput += `Invalid folder name. Folders under specification/ must be lower case.\n`;
    }

    if (structureVersion === 1) {
      const packageFolder = folderStruct[folderStruct.length - 1];

      if (!packageFolder.includes("Shared") && !tspConfigExists) {
        errorOutput += `Invalid folder structure: Spec folder must contain tspconfig.yaml.`;
        success = false;
      }

      // Verify package folder is at most 3 levels deep
      if (folderStruct.length > 4) {
        success = false;
        errorOutput += `Please limit TypeSpec folder depth to 3 levels or less`;
      }

      // Verify second level folder is capitalized after each '.'
      if (/(^|\. *)([a-z])/g.test(packageFolder)) {
        success = false;
        errorOutput += `Invalid folder name. Folders under specification/${folderStruct[1]} must be capitalized after each '.'\n`;
      }

      // Verify 'Shared' follows 'Management'
      if (packageFolder.includes("Management") && packageFolder.includes("Shared")) {
        if (!packageFolder.includes("Management.Shared")) {
          success = false;
          errorOutput += `Invalid folder name. For management libraries with a shared component, 'Shared' should follow 'Management'.`;
        }
      }

      if (tspConfigExists) {
        const configText = await readTspConfig(folder);
        const config = yamlParse(configText);
        const rpFolder =
          config?.options?.["@azure-tools/typespec-autorest"]?.["azure-resource-provider-folder"];
        stdOutput += `azure-resource-provider-folder: ${JSON.stringify(rpFolder)}\n`;

        if (
          rpFolder?.trim()?.endsWith("resource-manager") &&
          !packageFolder.endsWith(".Management")
        ) {
          errorOutput += `Invalid folder structure: TypeSpec for resource-manager specs must be in a folder ending with '.Management'`;
          success = false;
        } else if (
          !rpFolder?.trim()?.endsWith("resource-manager") &&
          packageFolder.endsWith(".Management")
        ) {
          errorOutput += `Invalid folder structure: TypeSpec for data-plane specs or shared code must be in a folder NOT ending with '.Management'`;
          success = false;
        }
      }
    } else if (structureVersion === 2) {
      if (!tspConfigExists) {
        errorOutput += `Invalid folder structure: Spec folder must contain tspconfig.yaml.`;
        success = false;
      }

      const specType = folder.includes("data-plane") ? "data-plane" : "resource-manager";
      if (specType === "data-plane") {
        if (folderStruct.length !== 4) {
          errorOutput +=
            "Invalid folder structure: TypeSpec for data-plane specs must be in a folder exactly one level under 'data-plane', like 'specification/foo/data-plane/FooAnalytics'.";
          success = false;
        }
      } else if (specType === "resource-manager") {
        if (folderStruct.length !== 5) {
          errorOutput +=
            "Invalid folder structure: TypeSpec for resource-manager specs must be in a folder exactly two levels under 'resource-manager', like 'specification/foo/resource-management/Microsoft.Foo/Foo'.";
          success = false;
        }

        const rpNamespaceRegex = /^[A-Za-z0-9\.]+$/;
        const rpNamespaceFolder = folderStruct[folderStruct.length - 2];

        if (!rpNamespaceRegex.test(rpNamespaceFolder)) {
          success = false;
          errorOutput += `RPNamespace folder '${rpNamespaceFolder}' does not match regex ${rpNamespaceRegex}`;
        }
      }

      const serviceRegex = /^[A-Za-z0-9]+$/;
      const serviceFolder = folderStruct[folderStruct.length - 1];

      if (!serviceRegex.test(serviceFolder)) {
        success = false;
        errorOutput += `Service folder '${serviceFolder}' does not match regex ${serviceRegex}. Service folders must use PascalCase without any special characters (e.g. dot, hyphen, underscore).`;
      }
    }

    // Ensure specs only import files from same folder under "specification"
    stdOutput += "imports:\n";

    const allowedImportRoot =
      structureVersion === 1 ? path.join(...folderStruct.slice(0, 2)) : folder;
    stdOutput += `  ${allowedImportRoot}\n`;

    const allowedImportRootResolved = path.resolve(gitRoot, allowedImportRoot);

    const tsps = await globby("**/*.tsp", { cwd: allowedImportRootResolved });

    for (const tsp of tsps) {
      const tspResolved = path.resolve(allowedImportRootResolved, tsp);

      const pattern = /^\s*import\s+['"]([^'"]+)['"]\s*;\s*$/gm;
      const text = await readFile(tspResolved, { encoding: "utf8" });
      const imports = [...text.matchAll(pattern)].map((m) => m[1]);

      // The path specified in the import must either start with "./" or "../", or be an absolute path.
      // The path should either point to a directory, or have an extension of either ".tsp" or ".js".
      // https://typespec.io/docs/language-basics/imports/
      //
      // We don't bother checking if the path has an extension of ".tsp" or ".js", because a directory
      // is also valid, and a directory could be named anything.  We only care if the path is under
      // $teamFolder, so we just treat anything that looks like a relative or absolute path,
      // as a path.
      const fileImports = imports.filter(
        (i) => i.startsWith("./") || i.startsWith("../") || path.isAbsolute(i),
      );

      stdOutput += `    ${tsp}: ${JSON.stringify(fileImports)}\n`;

      for (const fileImport of fileImports) {
        const fileImportResolved = path.resolve(path.dirname(tspResolved), fileImport);

        const relative = path.relative(allowedImportRootResolved, fileImportResolved);

        if (relative.startsWith("..")) {
          errorOutput +=
            `Invalid folder structure: '${tsp}' imports '${fileImport}', ` +
            `which is outside '${path.relative(gitRoot, allowedImportRoot)}'`;
          success = false;
        }
      }
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
