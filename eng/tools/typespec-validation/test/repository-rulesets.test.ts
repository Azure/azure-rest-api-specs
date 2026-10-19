import { compile, NodeHost } from "@typespec/compiler";
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
  flag: boolean;
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

  it("allows enabling an individual rule disabled by the inherited ruleset", async () => {
    const code = "@azure-tools/typespec-azure-core/no-boolean";
    const defaults = await compile(NodeHost, join(folder, "main.tsp"), {
      noEmit: true,
      linterRuleSet: { extends: ["@azure-tools/typespec-azure-rulesets/data-plane"] },
    });
    expect(defaults.diagnostics.some((diagnostic) => diagnostic.code === code)).toBe(false);

    const enabled = await compile(NodeHost, join(folder, "main.tsp"), {
      noEmit: true,
      linterRuleSet: {
        extends: ["@azure-tools/typespec-azure-rulesets/data-plane"],
        enable: { [code]: true },
      },
    });
    expect(enabled.diagnostics.filter((diagnostic) => diagnostic.severity === "error")).toEqual([]);
    expect(enabled.diagnostics.some((diagnostic) => diagnostic.code === code)).toBe(true);
  });
});
