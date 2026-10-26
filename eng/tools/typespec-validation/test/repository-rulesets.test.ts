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

  const postQuerySource = `import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
using TypeSpec.Http;
using Azure.ResourceManager;

@armProviderNamespace
namespace Microsoft.RolloutTest;

@post
@route("/restart")
op restart(
  @query reason?: string,
): void;
`;

  it(
    "enables the POST query pilot in the composed ARM profile but not data-plane",
    { timeout: 30_000 },
    async () => {
      const code = "@azure-tools/typespec-azure-resource-manager/no-query-in-post";
      await writeFile(join(folder, "main.tsp"), postQuerySource);
      for (const [extendsRules, expected] of [
        [["@azure-tools/typespec-azure-rulesets-original/resource-manager"], 0],
        [
          [
            "@azure-tools/typespec-azure-rulesets/resource-manager",
            "@azure-tools/typespec-azure-rulesets/client-sdk",
          ],
          1,
        ],
        [["@azure-tools/typespec-azure-rulesets/data-plane"], 0],
      ] as const) {
        const program = await compile(NodeHost, join(folder, "main.tsp"), {
          noEmit: true,
          linterRuleSet: { extends: [...extendsRules] },
        });
        expect(program.diagnostics.filter(({ severity }) => severity === "error")).toEqual([]);
        expect(program.diagnostics.filter((diagnostic) => diagnostic.code === code)).toHaveLength(
          expected,
        );
      }
    },
  );

  it("suppresses only the grandfathered POST query parameter", async () => {
    const code = "@azure-tools/typespec-azure-resource-manager/no-query-in-post";
    await writeFile(
      join(folder, "main.tsp"),
      postQuerySource.replace(
        "  @query reason?: string,",
        `  #suppress "${code}" "Back compat: Preserve the existing published query parameter."
  @query reason?: string,
  @query newReason?: string,`,
      ),
    );
    const program = await compile(NodeHost, join(folder, "main.tsp"), {
      noEmit: true,
      linterRuleSet: { extends: ["@azure-tools/typespec-azure-rulesets/resource-manager"] },
    });
    expect(program.diagnostics.filter(({ severity }) => severity === "error")).toEqual([]);
    const diagnostics = program.diagnostics.filter((diagnostic) => diagnostic.code === code);
    expect(diagnostics).toHaveLength(1);
    expect(diagnostics[0].message).toContain("'newReason'");
  });

});
