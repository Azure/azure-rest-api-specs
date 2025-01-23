import { join } from "path";
import { parse as yamlParse } from "yaml";
import { Rule } from "../rule.js";
import { RuleResult } from "../rule-result.js";
import { TsvHost } from "../tsv-host.js";

import tsvPlugin from "eslint-plugin-tsv" 

function convertToOldRules() {
  console.log('plugin name', tsvPlugin);
  
  let newRules = [];
  for (const [_, rule] of Object.entries(tsvPlugin.rules??{})) {
    if (!rule.name.startsWith("tspconfig-")) continue;
    const oldRule: Rule = {
      name: rule.name,
      description: rule.meta?.docs?.description ?? "",
      async execute(host: TsvHost, folder: string): Promise<RuleResult> {
        const configText = await host.readTspConfig(folder);
        const config = yamlParse(configText);
        
        const ruleListener = rule.create(context);
        return {
        };
      }
    }
    newRules.push(oldRule);
  }

}

const rules = convertToOldRules();


export default rules;