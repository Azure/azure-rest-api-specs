import type { RuleMetadata, SuppressionChange, SuppressionRecord } from "./types.ts";

type RuleDefinition = {
  name?: string;
  description?: string;
  url?: string;
};

type LinterModule = {
  $linter?: {
    rules?: RuleDefinition[];
  };
};

const moduleCache = new Map<string, Promise<LinterModule | undefined>>();
const metadataCache = new Map<string, Promise<RuleMetadata | undefined>>();

function parseRuleIdentifier(ruleName: string): { packageName?: string; localRuleName: string } {
  if (ruleName.startsWith("@")) {
    const parts = ruleName.split("/");
    if (parts.length >= 3) {
      return {
        packageName: `${parts[0]}/${parts[1]}`,
        localRuleName: parts.slice(2).join("/"),
      };
    }
  }

  const separatorIndex = ruleName.indexOf("/");
  if (separatorIndex > 0) {
    return {
      packageName: ruleName.slice(0, separatorIndex),
      localRuleName: ruleName.slice(separatorIndex + 1),
    };
  }

  return { localRuleName: ruleName };
}

async function loadLinterModule(packageName: string): Promise<LinterModule | undefined> {
  let cached = moduleCache.get(packageName);
  if (!cached) {
    cached = import(packageName).then((module) => module as LinterModule).catch(() => undefined);
    moduleCache.set(packageName, cached);
  }

  return cached;
}

export async function resolveRuleMetadata(ruleName: string): Promise<RuleMetadata | undefined> {
  let cached = metadataCache.get(ruleName);
  if (!cached) {
    cached = (async () => {
      const { packageName, localRuleName } = parseRuleIdentifier(ruleName);
      if (!packageName) {
        return undefined;
      }

      const module = await loadLinterModule(packageName);
      const rule = module?.$linter?.rules?.find((candidate) => candidate.name === localRuleName);
      if (!rule) {
        return {
          packageName,
          localRuleName,
        };
      }

      return {
        packageName,
        localRuleName,
        description: rule.description,
        documentationUrl: rule.url,
      };
    })();
    metadataCache.set(ruleName, cached);
  }

  return cached;
}

export async function enrichSuppressionRecords(
  suppressions: SuppressionRecord[],
): Promise<SuppressionRecord[]> {
  return Promise.all(
    suppressions.map(async (suppression) => {
      const ruleMetadata = await resolveRuleMetadata(suppression.ruleName);
      return ruleMetadata ? { ...suppression, ruleMetadata } : suppression;
    }),
  );
}

export async function enrichSuppressionChanges(
  changes: SuppressionChange[],
): Promise<SuppressionChange[]> {
  return Promise.all(
    changes.map(async (change) => {
      const ruleMetadata = await resolveRuleMetadata(change.after.ruleName);
      if (!ruleMetadata) {
        return change;
      }

      return {
        before: { ...change.before, ruleMetadata },
        after: { ...change.after, ruleMetadata },
      };
    }),
  );
}
