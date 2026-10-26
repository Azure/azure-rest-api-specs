import { compile, NodeHost } from "@typespec/compiler";
import type { CompilerOptions, RuleSetRef } from "@typespec/compiler";
import { mkdtemp, rm, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { afterEach, beforeEach, describe, expect, it } from "vitest";

describe("repository ruleset package", () => {
  let folder: string;

  beforeEach(async () => {
    folder = await mkdtemp(join(import.meta.dirname, "rulesets-"));
    await writeFile(
      join(folder, "main.tsp"),
      `/** Example model. */
model Example {
  /** Example flag. */
  flag: string;
}
`,
    );
  });

  afterEach(async () => {
    await rm(folder, { recursive: true, force: true });
  });

  it.each(["data-plane", "resource-manager", "client-sdk"])(
    "resolves %s by the existing package name with the same diagnostics as upstream",
    { timeout: 30_000 },
    async (ruleset) => {
      const upstream = await compile(NodeHost, join(folder, "main.tsp"), {
        noEmit: true,
        linterRuleSet: { extends: [`@azure-tools/typespec-azure-rulesets-original/${ruleset}`] },
      });
      const repository = await compile(NodeHost, join(folder, "main.tsp"), {
        noEmit: true,
        linterRuleSet: { extends: [`@azure-tools/typespec-azure-rulesets/${ruleset}`] },
      });
      expect(
        repository.diagnostics.filter((diagnostic) => diagnostic.severity === "error"),
      ).toEqual([]);
      expect(repository.diagnostics.map(({ code, message }) => ({ code, message }))).toEqual(
        upstream.diagnostics.map(({ code, message }) => ({ code, message })),
      );
    },
  );

  it("enables no-boolean without changing upstream defaults", async () => {
    const code = "@azure-tools/typespec-azure-core/no-boolean";
    await writeFile(
      join(folder, "main.tsp"),
      "/** Example model. */ model Example { /** Example flag. */ flag: boolean; }",
    );
    const defaults = await compile(NodeHost, join(folder, "main.tsp"), {
      noEmit: true,
      linterRuleSet: { extends: ["@azure-tools/typespec-azure-rulesets-original/data-plane"] },
    });
    expect(defaults.diagnostics.some((diagnostic) => diagnostic.code === code)).toBe(false);

    const enabled = await compile(NodeHost, join(folder, "main.tsp"), {
      noEmit: true,
      linterRuleSet: {
        extends: ["@azure-tools/typespec-azure-rulesets/data-plane"],
      },
    });
    expect(enabled.diagnostics.filter((diagnostic) => diagnostic.severity === "error")).toEqual([]);
    expect(enabled.diagnostics.some((diagnostic) => diagnostic.code === code)).toBe(true);
  });


  const batchCases = [
    {
      code: "@azure-tools/typespec-azure-core/no-boolean",
      profile: "data-plane",
      source: `model Flags {
  __SUPPRESSION__
  legacyFlag: boolean;
  newFlag: boolean;
}`,
    },
  ];

  it.each(batchCases)(
    "enables $code through composition and keeps new violations detectable",
    { timeout: 30_000 },
    async ({ code, profile, source }) => {
      const imports = `import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
using TypeSpec.Http;
using Azure.ResourceManager;
@service
@armProviderNamespace
namespace Microsoft.RolloutTest;
`;
      await writeFile(join(folder, "main.tsp"), imports + source.replace("__SUPPRESSION__", ""));
      const upstream = await compile(NodeHost, join(folder, "main.tsp"), {
        noEmit: true,
        linterRuleSet: { extends: [`@azure-tools/typespec-azure-rulesets-original/${profile}`] },
      });
      expect(upstream.diagnostics.filter(({ severity }) => severity === "error")).toEqual([]);
      expect(upstream.diagnostics.filter((diagnostic) => diagnostic.code === code)).toEqual([]);

      const profiles =
        profile === "data-plane"
          ? ["data-plane", "client-sdk"]
          : ["resource-manager", "client-sdk"];
      const options: CompilerOptions = {
        noEmit: true,
        linterRuleSet: {
          extends: profiles.map<RuleSetRef>(
            (name) => `@azure-tools/typespec-azure-rulesets/${name}`,
          ),
        },
      };
      const enabled = await compile(NodeHost, join(folder, "main.tsp"), options);
      expect(enabled.diagnostics.filter(({ severity }) => severity === "error")).toEqual([]);
      expect(enabled.diagnostics.filter((diagnostic) => diagnostic.code === code)).toHaveLength(2);

      await writeFile(
        join(folder, "main.tsp"),
        imports +
          source.replace(
            "__SUPPRESSION__",
            `#suppress "${code}" "Back compat: Preserve the existing API or SDK contract during rule enablement."`,
          ),
      );
      const suppressed = await compile(NodeHost, join(folder, "main.tsp"), options);
      expect(suppressed.diagnostics.filter(({ severity }) => severity === "error")).toEqual([]);
      expect(suppressed.diagnostics.filter((diagnostic) => diagnostic.code === code)).toHaveLength(
        1,
      );
    },
  );
});
