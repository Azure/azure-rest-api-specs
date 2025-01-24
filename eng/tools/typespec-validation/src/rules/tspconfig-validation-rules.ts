// Note: temporary workaround to convert new rules to old rules to provides suggestion to correct tspconfig

import { join } from "path";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { TsvHost } from "../tsv-host.js";

import tsvPlugin, { ESLint } from "eslint-plugin-tsv";

async function runESLint(content: string, folder: string, ruleName: string) {
  const config = tsvPlugin.configs.recommended;
  for (const key in config.rules) {
    if (key !== "tsv/" + ruleName) delete config.rules[key];
  }
  const eslint = new ESLint({
    cwd: join(__dirname, "../../../../"),
    overrideConfig: tsvPlugin.configs.recommended,
    overrideConfigFile: true,
  });
  const results = await eslint.lintText(content, { filePath: join(folder, "tspconfig.yaml") });
  return results;
}

// NOTE: This is a workaround to convert the new rules to old rules
//       To be removed when the new TSV framework is ready
function convertToOldRules() {
  let oldRules = [];
  for (const [_, rule] of Object.entries(tsvPlugin.rules ?? {})) {
    if (!rule.name.startsWith("tspconfig-")) continue;
    const oldRule: Rule = {
      name: rule.name,
      description: rule.meta?.docs?.description ?? "",
      async execute(host: TsvHost, folder: string): Promise<RuleResult> {
        const configText = await host.readTspConfig(folder);
        const results = await runESLint(configText, folder, rule.name);
        if (results.length > 0 && results[0].messages.length > 0) {
          return {
            errorOutput: results[0].messages[0].message,
            // Only used to provide suggestion to correct tspconfig
            success: true,
          };
        }

        return {
          stdOutput: `[${rule.name}]: validation passed.`,
          success: true,
        };
      },
    };
    oldRules.push(oldRule);
  }
  return oldRules;
}

const rules = convertToOldRules();

export default rules;
