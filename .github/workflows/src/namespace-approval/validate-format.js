import { readFile } from "fs/promises";
import yaml from "js-yaml";

/**
 * @typedef {Object} FormatRule
 * @property {string} pattern - Regex pattern string
 * @property {string} [description] - Human-readable description
 */

/**
 * @typedef {Record<string, FormatRule | FormatRule[]>} FormatRulesConfig
 */

const DEFAULT_RULES_PATH = ".github/package-name-format-rules.yml";

/**
 * Load format rules from YAML config.
 *
 * @param {import("@actions/core")} core
 * @param {string} [rulesPath]
 * @returns {Promise<FormatRulesConfig | null>}
 */
export async function loadFormatRules(core, rulesPath = DEFAULT_RULES_PATH) {
  try {
    const content = await readFile(rulesPath, "utf8");
    return /** @type {FormatRulesConfig} */ (yaml.load(content));
  } catch (e) {
    core.warning(
      `Format rules not found at ${rulesPath}, skipping format validation: ${String(e)}`,
    );
    return null;
  }
}

/**
 * @typedef {Object} FormatValidationResult
 * @property {boolean} valid
 * @property {string} namespace
 * @property {string} language
 * @property {string} [matchedRule] - Description of the rule that matched
 * @property {string} [error] - Error message if invalid
 */

/**
 * Validate a package name string against the format rules for a language.
 *
 * @param {string} language - Language key (e.g., "dotnet", "java", "go")
 * @param {string} namespace - The package name string to validate
 * @param {FormatRulesConfig} rules - The loaded format rules
 * @returns {FormatValidationResult}
 */
export function validateNamespaceFormat(language, namespace, rules) {
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
 *
 * @param {Record<string, string>} namespacesFound - Map of language to package name
 * @param {FormatRulesConfig} rules - The loaded format rules
 * @returns {FormatValidationResult[]}
 */
export function validateAllNamespaces(namespacesFound, rules) {
  /** @type {FormatValidationResult[]} */
  const results = [];
  for (const [lang, ns] of Object.entries(namespacesFound)) {
    results.push(validateNamespaceFormat(lang, ns, rules));
  }
  return results;
}
