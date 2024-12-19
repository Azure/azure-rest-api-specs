import { ESLint, Rule } from "eslint";

// ESLint with names for convenience

export namespace NamedRule {
  export interface RuleModule extends Rule.RuleModule {
    name: string;
  }
}

export namespace NamedESLint {
  export interface Plugin extends ESLint.Plugin {
    name: string;
    rules?: Record<string, NamedRule.RuleModule>;
  }
}
