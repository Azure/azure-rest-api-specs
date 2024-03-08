import path from "path";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { TsvHost } from "../tsv-host.js";

export class FolderStructureRule implements Rule {
  readonly name = "FolderStructure";
  readonly description = "Verify spec directory's folder structure and naming conventions.";
  async execute(host: TsvHost, folder: string): Promise<RuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput = "";
    let gitRoot = host.normalizePath(await host.gitOperation(folder).revparse("--show-toplevel"));
    let relativePath = path.relative(gitRoot, folder).split(path.sep).join("/");

    stdOutput += `folder: ${folder}\n`;
    if (!(await host.checkFileExists(folder))) {
      return {
        success: false,
        stdOutput: stdOutput,
        errorOutput: `Folder '${folder}' does not exist.\n`,
      };
    }

    const tspConfigs = await host.globby([`${folder}/**tspconfig.*`]);
    stdOutput += `config files: ${JSON.stringify(tspConfigs)}\n`;
    tspConfigs.forEach((file: string) => {
      if (!file.endsWith("tspconfig.yaml")) {
        success = false;
        errorOutput += `Invalid config file '${file}'.  Must be named 'tspconfig.yaml'.\n`;
      }
    });

    // Verify top level folder is lower case and remove empty entries when splitting by slash
    let folderStruct = relativePath.split("/").filter(Boolean);
    if (folderStruct[1].match(/[A-Z]/g)) {
      success = false;
      errorOutput += `Invalid folder name. Folders under specification/ must be lower case.\n`;
    }

    let packageFolder = folderStruct[folderStruct.length - 1];

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

    // Verify tspconfig, main.tsp, examples/
    let mainExists = await host.checkFileExists(path.join(folder, "main.tsp"));
    let clientExists = await host.checkFileExists(path.join(folder, "client.tsp"));

    if (!mainExists && !clientExists) {
      errorOutput += `Invalid folder structure: Spec folder must contain main.tsp or client.tsp.`;
      success = false;
    }

    if (mainExists && !(await host.checkFileExists(path.join(folder, "examples")))) {
      errorOutput += `Invalid folder structure: Spec folder with main.tsp must contain examples folder.`;
      success = false;
    }

    if (
      !packageFolder.includes("Shared") &&
      !(await host.checkFileExists(path.join(folder, "tspconfig.yaml")))
    ) {
      errorOutput += `Invalid folder structure: Spec folder must contain tspconfig.yaml.`;
      success = false;
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
