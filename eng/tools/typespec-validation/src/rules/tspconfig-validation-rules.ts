import { join } from "path";
import { parse as yamlParse } from "yaml";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { TsvHost } from "../tsv-host.js";

import tsvPlugin, { ESLint, ESRule, parseForESLint } from "eslint-plugin-tsv";

async function runESLint(content: string) {
  const eslint = new ESLint({
    cwd: join(__dirname, "../../../../"),
    overrideConfig: tsvPlugin.configs.recommended,
    overrideConfigFile: true,
  });
    const results = await eslint.lintText(content, {filePath: 'tspconfig.yaml'});
    return results;
}

function convertToOldRules() {
  let oldRules = [];
  for (const [_, rule] of Object.entries(tsvPlugin.rules ?? {})) {
    if (!rule.name.startsWith("tspconfig-")) continue;
    const oldRule: Rule = {
      name: rule.name,
      description: rule.meta?.docs?.description ?? "",
      async execute(host: TsvHost, folder: string): Promise<RuleResult> {
        const configText = await host.readTspConfig(folder);
        // const parsed = parseForESLint(configText, {location: true, });
        // const node = parsed as unknown as ESRule.Node;
        // console.log('---node', node)
        // const context = createFakeRuleContext(folder);
        // const ruleListener = rule.create(context);
        // const runTspConfigRule = ruleListener.YAMLDocument as (node: ESRule.Node) => void;
        // if (runTspConfigRule) runTspConfigRule(node);
        console.log('---configText', configText);
        const results = await runESLint(configText);
        console.log('---messages', results.map(r => r.messages));
        return {
          stdOutput: "",
          success: true,
        };
      },
    };
    oldRules.push(oldRule);
  }
  return oldRules;
}

const rules = convertToOldRules();

export default function () {
  return convertToOldRules();
}

// export default rules;
