import { ESLint, Linter, Rule } from "eslint";

// ESLint with names for convenience

export namespace NamedRule {
  export interface RuleModule extends Rule.RuleModule {
    name: string;
  }
}

export namespace NamedESLint {
  export interface Plugin extends ESLint.Plugin {
    configs: { recommended: Linter.Config };
    name: string;
    rules?: Record<string, NamedRule.RuleModule>;
  }
}
