import path from "path";
import { parse as yamlParse } from "yaml";
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
    const gitRoot = host.normalizePath(await host.gitOperation(folder).revparse("--show-toplevel"));
    const relativePath = path.relative(gitRoot, folder).split(path.sep).join("/");

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
    const folderStruct = relativePath.split("/").filter(Boolean);
    if (folderStruct[1].match(/[A-Z]/g)) {
      success = false;
      errorOutput += `Invalid folder name. Folders under specification/ must be lower case.\n`;
    }

    const packageFolder = folderStruct[folderStruct.length - 1];

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
    const mainExists = await host.checkFileExists(path.join(folder, "main.tsp"));
    const clientExists = await host.checkFileExists(path.join(folder, "client.tsp"));
    const tspConfigExists = await host.checkFileExists(path.join(folder, "tspconfig.yaml"));

    if (!mainExists && !clientExists) {
      errorOutput += `Invalid folder structure: Spec folder must contain main.tsp or client.tsp.`;
      success = false;
    }

    if (mainExists && !(await host.checkFileExists(path.join(folder, "examples")))) {
      errorOutput += `Invalid folder structure: Spec folder with main.tsp must contain examples folder.`;
      success = false;
    }

    if (!packageFolder.includes("Shared") && !tspConfigExists) {
      errorOutput += `Invalid folder structure: Spec folder must contain tspconfig.yaml.`;
      success = false;
    }

    if (tspConfigExists) {
      const configText = await host.readTspConfig(folder);
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

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}
