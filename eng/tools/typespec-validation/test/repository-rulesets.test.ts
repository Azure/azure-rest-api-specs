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
        `  #suppress "${code}" "Preserve the existing published query parameter."
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

  const batchCases = [
    {
      code: "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op",
      profile: "resource-manager",
      source: `@get
@route("/providers/Microsoft.RolloutTest/widgets/{name}")
op getWidget(
  @path name: string,
  __SUPPRESSION__
  @query legacyReason?: string,
  @query newReason?: string,
): void;`,
    },
    {
      code: "@azure-tools/typespec-azure-resource-manager/no-query-in-collection",
      profile: "resource-manager",
      source: `@get
@route("/providers/Microsoft.RolloutTest/widgets")
op listWidgets(
  __SUPPRESSION__
  @query legacyReason?: string,
  @query newReason?: string,
): void;`,
    },
    {
      code: "@azure-tools/typespec-azure-resource-manager/use-application-json-content-type",
      profile: "resource-manager",
      source: `@post
@route("/legacy")
op sendLegacy(
  __SUPPRESSION__
  @header contentType: "application/octet-stream",
  @body payload: bytes,
): void;
@post
@route("/new")
op sendNew(@header contentType: "application/octet-stream", @body payload: bytes): void;`,
    },
    {
      code: "@azure-tools/typespec-azure-resource-manager/use-model-request-body",
      profile: "resource-manager",
      source: `@post
@route("/legacy")
op sendLegacy(
  __SUPPRESSION__
  @body payload: string,
): void;
@post
@route("/new")
op sendNew(@body payload: string): void;`,
    },
    {
      code: "@azure-tools/typespec-azure-resource-manager/list-operation-missing-pageable",
      profile: "resource-manager",
      source: `__SUPPRESSION__
@get
@route("/providers/Microsoft.RolloutTest/widgets")
op listLegacy(): string[];
@get
@route("/providers/Microsoft.RolloutTest/otherWidgets")
op listNew(): string[];`,
    },
    {
      code: "@azure-tools/typespec-azure-resource-manager/no-tenant-level-apis",
      profile: "resource-manager",
      source: `__SUPPRESSION__
@put
@route("/providers/Microsoft.RolloutTest/widgets/{name}")
op createLegacy(@path name: string): void;
@put
@route("/providers/Microsoft.RolloutTest/otherWidgets/{name}")
op createNew(@path name: string): void;`,
    },
    {
      code: "@azure-tools/typespec-azure-core/no-boolean",
      profile: "data-plane",
      source: `model Flags {
  __SUPPRESSION__
  legacyFlag: boolean;
  newFlag: boolean;
}`,
    },
    {
      code: "@azure-tools/typespec-client-generator-core/get-operation-name",
      profile: "client-sdk",
      source: `__SUPPRESSION__
@get
@route("/legacy")
op fetchLegacy(): string;
@get
@route("/new")
op fetchNew(): string;`,
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
            `#suppress "${code}" "Preserve the existing API or SDK contract during rule enablement."`,
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
