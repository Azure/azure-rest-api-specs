import { parseYaml } from "@azure-tools/specs-shared/yaml";
import { readFile } from "fs/promises";
import type { Core } from "../github.ts";

export type FormatRule = {
  pattern: string;
  description?: string;
};

export type FormatRulesConfig = Record<string, FormatRule | FormatRule[]>;

const DEFAULT_RULES_PATH = ".github/package-name-format-rules.yml";

/**
 * Load format rules from YAML config.
 */
export async function loadFormatRules(
  core: Core,
  rulesPath: string = DEFAULT_RULES_PATH,
): Promise<FormatRulesConfig | null> {
  try {
    const content = await readFile(rulesPath, "utf8");
    return parseYaml(content) as FormatRulesConfig;
  } catch (e) {
    core.warning(
      `Format rules not found at ${rulesPath}, skipping format validation: ${String(e)}`,
    );
    return null;
  }
}

export type FormatValidationResult = {
  valid: boolean;
  namespace: string;
  language: string;
  matchedRule?: string;
  error?: string;
};

/**
 * Validate a package name string against the format rules for a language.
 * @param language - Language key (e.g., "dotnet", "java", "go")
 * @param namespace - The package name string to validate
 * @param rules - The loaded format rules
 */
export function validateNamespaceFormat(
  language: string,
  namespace: string,
  rules: FormatRulesConfig,
): FormatValidationResult {
  const langRules = rules[language];

  if (!langRules) {
    // No rules defined for this language — pass by default
    return { valid: true, namespace, language, matchedRule: "no rules defined" };
  }

  const ruleList = Array.isArray(langRules) ? langRules : [langRules];

  for (const rule of ruleList) {
    const regex = new RegExp(rule.pattern);
    if (regex.test(namespace)) {
      return {
        valid: true,
        namespace,
        language,
        matchedRule: rule.description ?? rule.pattern,
      };
    }
  }

  // None of the patterns matched
  const expectedPatterns = ruleList.map((r) => r.description ?? r.pattern).join(" OR ");
  return {
    valid: false,
    namespace,
    language,
    error: `"${namespace}" does not match expected format: ${expectedPatterns}`,
  };
}

/**
 * Validate all detected package names against format rules.
 * @param namespacesFound - Map of language to package name
 * @param rules - The loaded format rules
 */
export function validateAllNamespaces(
  namespacesFound: Record<string, string>,
  rules: FormatRulesConfig,
): FormatValidationResult[] {
  const results: FormatValidationResult[] = [];
  for (const [lang, ns] of Object.entries(namespacesFound)) {
    results.push(validateNamespaceFormat(lang, ns, rules));
  }
  return results;
}
