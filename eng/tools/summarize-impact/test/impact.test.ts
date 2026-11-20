import { mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join, win32 } from "node:path";
import { describe, expect, it } from "vitest";
import { ImpactAssessmentSchema } from "@azure-tools/specs-shared/impact";
import { PRContext, type FileListInfo } from "../src/PRContext.ts";
import { evaluateImpact } from "../src/impact.ts";

const BEFORE = join(import.meta.dirname, "fixtures/default/before");
const AFTER = join(import.meta.dirname, "fixtures/default/after");

function context(files: Partial<FileListInfo>, source = AFTER, target = BEFORE) {
  return new PRContext(source, target, {
    fileList: {
      additions: [],
      modifications: [],
      deletions: [],
      renames: [],
      total: 0,
      ...files,
    },
  });
}

describe("change impact", () => {
  it("reports no services when nothing changed", async () => {
    expect(await evaluateImpact(context({}), [])).toEqual({ schemaVersion: 2, services: [] });
  });

  it("keeps facts scoped to their service and plane", async () => {
    const impact = await evaluateImpact(
      context({
        additions: [
          "specification/contosowidgetmanager/data-plane/Azure.Contoso.WidgetManager/stable/2024-12-01/widgets.json",
        ],
        modifications: ["specification/contosowidgetmanager/resource-manager/readme.md"],
      }),
      [],
    );

    expect(ImpactAssessmentSchema.parse(impact)).toEqual(impact);
    expect(impact.services).toEqual([
      expect.objectContaining({
        path: "specification/contosowidgetmanager",
        plane: "data-plane",
        changes: ["api"],
        typeSpec: true,
        newApiVersions: ["2024-12-01"],
        suppressionsChanged: false,
      }),
      expect.objectContaining({
        path: "specification/contosowidgetmanager",
        plane: "resource-manager",
        changes: ["readme"],
        newApiVersions: [],
        suppressionsChanged: true,
      }),
    ]);
    expect(impact.services[1].resourceProvider.usesRpaas).toBe(true);
  });

  it("classifies an old-layout TypeSpec configuration without treating it as an API change", async () => {
    const impact = await evaluateImpact(
      context({
        modifications: ["specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml"],
      }),
      [],
    );
    expect(impact.services).toEqual([
      expect.objectContaining({
        plane: "data-plane",
        changes: ["sdk-configuration"],
        typeSpec: true,
      }),
    ]);
  });

  it.each(["additions", "modifications", "deletions"] as const)(
    "records existing-version API %s separately from new versions",
    async (change) => {
      const file =
        "specification/contosowidgetmanager/data-plane/Azure.Contoso.WidgetManager/stable/2024-12-01/widgets.json";
      const impact = await evaluateImpact(context({ [change]: [file] }, AFTER, AFTER), []);
      expect(impact.services[0]).toMatchObject({
        plane: "data-plane",
        hasApiDefinitionChanges: true,
        newApiVersions: [],
      });
    },
  );

  it.each([
    ["main.tsp", true],
    ["models.tsp", true],
    ["generated.tsp", true],
    ["myclient.tsp", true],
    ["client.tsp", false],
    ["CLIENT.TSP", false],
    ["tspconfig.yaml", false],
    ["readme.md", false],
    ["examples/payload.json", false],
    ["scenarios/scenario.json", false],
  ])("classifies old-layout %s for contract review: %s", async (file, expected) => {
    const impact = await evaluateImpact(
      context({
        modifications: [`specification/contosowidgetmanager/Contoso.WidgetManager/${file}`],
      }),
      [],
    );
    expect(impact.services[0]).toMatchObject({
      plane: "data-plane",
      hasApiDefinitionChanges: expected,
    });
  });

  it("excludes SDK metadata alongside client customization, but not a contract change", async () => {
    const folder = await mkdtemp(join(tmpdir(), "impact-config-"));
    try {
      const directory = "specification/example/data-plane/Example";
      await mkdir(join(folder, directory), { recursive: true });
      await writeFile(join(folder, directory, "package.json"), '{"name":"example","version":"1"}');
      await writeFile(join(folder, directory, "tsconfig.json"), '{"compilerOptions":{}}');
      const modifications = [
        `${directory}/client.tsp`,
        `${directory}/package.json`,
        `${directory}/tsconfig.json`,
        `${directory}/tsconfig.build.json`,
        `${directory}/package-lock.json`,
        `${directory}/npm-shrinkwrap.json`,
        `${directory}/readme.md`,
        `${directory}/tspconfig.yaml`,
        `${directory}/examples/payload.json`,
      ];
      // Only the package/build JSON is read by the existing Swagger classifier.
      for (const file of modifications.filter((file) => file.endsWith(".json"))) {
        await mkdir(dirname(join(folder, file)), { recursive: true });
        await writeFile(join(folder, file), "{}");
      }
      const excluded = await evaluateImpact(context({ modifications }, folder, folder), []);
      expect(excluded.services[0].hasApiDefinitionChanges).toBe(false);
      const mixed = await evaluateImpact(
        context({ modifications: [...modifications, `${directory}/models.tsp`] }, folder, folder),
        [],
      );
      expect(mixed.services[0].hasApiDefinitionChanges).toBe(true);
    } finally {
      await rm(folder, { recursive: true, force: true });
    }
  });

  it.each([false, true])(
    "recognizes a deleted neutral-layout data-plane contract from base config: %s",
    async (deleted) => {
      const folder = await mkdtemp(join(tmpdir(), "impact-contract-"));
      try {
        const before = join(folder, "before");
        const after = join(folder, "after");
        const project = "specification/example/Example.Service";
        await mkdir(join(before, project), { recursive: true });
        await mkdir(after);
        await writeFile(
          join(before, project, "tspconfig.yaml"),
          "linter:\n  extends:\n    - '@azure-tools/typespec-azure-rulesets/data-plane'\n",
        );
        const impact = await evaluateImpact(
          context(
            { [deleted ? "deletions" : "modifications"]: [`${project}/main.tsp`] },
            after,
            before,
          ),
          [],
        );
        expect(impact.services[0]).toMatchObject({
          plane: "data-plane",
          hasApiDefinitionChanges: true,
        });
      } finally {
        await rm(folder, { recursive: true, force: true });
      }
    },
  );

  it.each([
    ["resource-manager", "data-plane", true],
    ["data-plane", "resource-manager", true],
    ["data-plane", "data-plane", false],
  ] as const)(
    "uses the baseline plane when a retained project changes from %s to %s",
    async (fromPlane, toPlane, changed) => {
      const folder = await mkdtemp(join(tmpdir(), "impact-retargeted-move-"));
      try {
        const before = join(folder, "before");
        const after = join(folder, "after");
        const project = "specification/example/Example.Service";
        const from = `${project}/models.tsp`;
        const to = `specification/example/${toPlane}/Example/models.tsp`;
        const config = `${project}/tspconfig.yaml`;
        const content = "namespace Example;\nmodel Widget {}\n";
        await mkdir(join(before, project), { recursive: true });
        await mkdir(join(after, project), { recursive: true });
        await mkdir(dirname(join(after, to)), { recursive: true });
        await writeFile(
          join(before, config),
          `linter:\n  extends:\n    - '@azure-tools/typespec-azure-rulesets/${fromPlane}'\n`,
        );
        await writeFile(
          join(after, config),
          `# Retained project configuration.\nlinter:\n  extends:\n    - '@azure-tools/typespec-azure-rulesets/${toPlane}'\n`,
        );
        await writeFile(join(before, from), content);
        await writeFile(join(after, to), content);
        const impact = await evaluateImpact(
          context({ additions: [to], deletions: [from], modifications: [config] }, after, before),
          [],
        );
        expect(impact.services.find((service) => service.plane === toPlane)).toMatchObject({
          hasApiDefinitionChanges: changed,
        });
        expect(impact.services.find((service) => service.plane === toPlane)?.changes).toContain(
          "sdk-configuration",
        );
        expect(impact.services.find((service) => service.plane === fromPlane)).toMatchObject({
          hasApiDefinitionChanges: changed,
        });
      } finally {
        await rm(folder, { recursive: true, force: true });
      }
    },
  );

  it("separates deleted and modified contracts in a retargeted project directory", async () => {
    const folder = await mkdtemp(join(tmpdir(), "impact-retargeted-deletion-"));
    try {
      const before = join(folder, "before");
      const after = join(folder, "after");
      const project = "specification/example/Example.Service";
      const deleted = `${project}/models.tsp`;
      const modified = `${project}/main.tsp`;
      const config = `${project}/tspconfig.yaml`;
      await mkdir(join(before, project), { recursive: true });
      await mkdir(join(after, project), { recursive: true });
      await writeFile(
        join(before, config),
        "linter:\n  extends:\n    - '@azure-tools/typespec-azure-rulesets/data-plane'\n",
      );
      await writeFile(
        join(after, config),
        "linter:\n  extends:\n    - '@azure-tools/typespec-azure-rulesets/resource-manager'\n",
      );
      await writeFile(join(before, deleted), "namespace Example;\nmodel Widget {}\n");
      await writeFile(join(before, modified), "namespace Example;\n");
      await writeFile(join(after, modified), "namespace Example;\nmodel Resource {}\n");
      const impact = await evaluateImpact(
        context({ deletions: [deleted], modifications: [config, modified] }, after, before),
        [],
      );
      expect(impact.services).toMatchObject([
        { plane: "data-plane", hasApiDefinitionChanges: true, changes: ["api"] },
        {
          plane: "resource-manager",
          hasApiDefinitionChanges: true,
        },
      ]);
    } finally {
      await rm(folder, { recursive: true, force: true });
    }
  });

  it.each(["unchanged", "edited", "new-version", "extra-copy", "other-service", "other-plane"])(
    "distinguishes unchanged unified-folder migrations from %s changes",
    async (scenario) => {
      const folder = await mkdtemp(join(tmpdir(), "impact-moves-"));
      try {
        const before = join(folder, "before");
        const after = join(folder, "after");
        const definitions = [
          [
            "specification/example/Example.Service/main.tsp",
            "specification/example/data-plane/Example/main.tsp",
            "namespace Example;\n",
          ],
          [
            "specification/example/data-plane/Microsoft.Example/preview/v1/api.json",
            "specification/example/data-plane/Example/preview/v1/api.json",
            '{"swagger":"2.0","info":{"version":"v1"},"paths":{}}',
          ],
          [
            "specification/example/resource-manager/Microsoft.Example/stable/2025-01-01/api.json",
            "specification/example/resource-manager/Microsoft.Example/Example/stable/2025-01-01/api.json",
            '{"swagger":"2.0","info":{"version":"2025-01-01"},"paths":{}}',
          ],
        ];
        await mkdir(join(before, "specification/example/Example.Service"), { recursive: true });
        await writeFile(
          join(before, "specification/example/Example.Service/tspconfig.yaml"),
          "linter:\n  extends:\n    - '@azure-tools/typespec-azure-rulesets/data-plane'\n",
        );
        const additions: string[] = [];
        const deletions: string[] = [];
        for (const [from, destination, content] of definitions) {
          let to = destination;
          if (scenario === "other-service") to = to.replace("/example/", "/another/");
          if (scenario === "other-plane" && to.includes("/data-plane/")) {
            to = to.replace("/data-plane/", "/resource-manager/");
          }
          await mkdir(dirname(join(before, from)), { recursive: true });
          await mkdir(dirname(join(after, to)), { recursive: true });
          await writeFile(join(before, from), content);
          await writeFile(
            join(after, to),
            scenario === "edited" && to.endsWith(".tsp") ? `${content}model Widget {}\n` : content,
          );
          deletions.push(from);
          additions.push(to);
        }
        if (scenario === "extra-copy" || scenario === "new-version") {
          const extra =
            scenario === "extra-copy"
              ? "specification/example/data-plane/Example/copy.tsp"
              : "specification/example/data-plane/Example/preview/v2/api.json";
          await mkdir(dirname(join(after, extra)), { recursive: true });
          await writeFile(
            join(after, extra),
            scenario === "extra-copy"
              ? definitions[0][2]
              : '{"swagger":"2.0","info":{"version":"v2"},"paths":{}}',
          );
          additions.push(extra);
        }
        const impact = await evaluateImpact(context({ additions, deletions }, after, before), []);
        expect(ImpactAssessmentSchema.parse(impact)).toEqual(impact);
        expect(impact.services.some((service) => service.plane === "data-plane")).toBe(true);
        expect(impact.services.some((service) => service.plane === "resource-manager")).toBe(true);
        expect(impact.services.some((service) => service.hasApiDefinitionChanges)).toBe(
          scenario !== "unchanged",
        );
        if (scenario === "unchanged") {
          expect(impact.services.every((service) => service.newApiVersions.length === 0)).toBe(
            true,
          );
        }
        if (scenario === "new-version") {
          expect(impact.services.find((service) => service.plane === "data-plane")).toMatchObject({
            hasApiDefinitionChanges: true,
            newApiVersions: ["v2"],
          });
        }
      } finally {
        await rm(folder, { recursive: true, force: true });
      }
    },
  );

  it("retains management classification for configuration-only changes", async () => {
    const impact = await evaluateImpact(
      context({
        modifications: [
          "specification/contosowidgetmanager/resource-manager/Contoso.WidgetManager/tspconfig.yaml",
        ],
      }),
      [],
    );
    expect(impact.services).toEqual([
      expect.objectContaining({
        plane: "resource-manager",
        changes: ["sdk-configuration"],
        hasAffectedReadme: false,
        typeSpec: true,
      }),
    ]);
  });

  it("records policy changes through an unchanged owning README", async () => {
    const impact = await evaluateImpact(
      context({
        modifications: ["specification/contosowidgetmanager/resource-manager/suppressions.yaml"],
      }),
      [],
    );
    expect(impact.services).toEqual([
      expect.objectContaining({
        plane: "resource-manager",
        changes: ["other"],
        hasAffectedReadme: true,
      }),
    ]);
  });

  it("preserves review, RPaaS, and suppression facts from Windows-formatted owning README paths", async () => {
    const prContext = context({
      modifications: ["specification/contosowidgetmanager/resource-manager/suppressions.yaml"],
    });
    const readmes = await prContext.getReadmeDiffs();
    prContext.getReadmeDiffs = () =>
      Promise.resolve({
        ...readmes,
        changes: readmes.changes?.map((entry) => ({
          ...entry,
          readme: win32.normalize(entry.readme),
        })),
      });

    const impact = await evaluateImpact(prContext, []);
    expect(impact.services[0]).toMatchObject({
      path: "specification/contosowidgetmanager",
      plane: "resource-manager",
      hasAffectedReadme: true,
      suppressionsChanged: true,
      resourceProvider: { usesRpaas: true },
    });
  });

  it("uses the baseline configuration to classify a deleted old-layout management project", async () => {
    const folder = await mkdtemp(join(tmpdir(), "impact-plane-"));
    try {
      const before = join(folder, "before");
      const after = join(folder, "after");
      const project = "specification/example/Example.Management";
      await mkdir(join(before, project), { recursive: true });
      await mkdir(after);
      await writeFile(
        join(before, project, "tspconfig.yaml"),
        "linter:\n  extends:\n    - '@azure-tools/typespec-azure-rulesets/resource-manager'\n",
      );
      const impact = await evaluateImpact(
        context({ deletions: [`${project}/tspconfig.yaml`] }, after, before),
        [],
      );
      expect(impact.services).toEqual([
        expect.objectContaining({ plane: "resource-manager", changes: ["sdk-configuration"] }),
      ]);
    } finally {
      await rm(folder, { recursive: true, force: true });
    }
  });

  it("records new namespaces and registration facts without deciding whether review is required", async () => {
    const impact = await evaluateImpact(
      context({
        additions: [
          "specification/contosowidgermanager2/resource-manager/readme.md",
          "specification/contosowidgermanager2/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
          "specification/contosowidgermanager3/resource-manager/readme.md",
          "specification/contosowidgermanager3/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
        ],
      }),
      ["contosowidgermanager2"],
    );
    expect(impact.services.map((service) => service.resourceProvider)).toEqual([
      {
        newNamespaces: ["specification/contosowidgermanager2/resource-manager/Microsoft.Contoso"],
        usesRpaas: true,
        hasAddedDefinitions: true,
        registered: true,
      },
      {
        newNamespaces: ["specification/contosowidgermanager3/resource-manager/Microsoft.Contoso"],
        usesRpaas: false,
        hasAddedDefinitions: true,
        registered: false,
      },
    ]);
  });

  it("compares versions against each provider rather than the first provider in the PR", async () => {
    const folder = await mkdtemp(join(tmpdir(), "impact-versions-"));
    try {
      const before = join(folder, "before");
      const after = join(folder, "after");
      const version = "2026-01-01";
      const providerA = "specification/example/resource-manager/Microsoft.First";
      const providerB = "specification/example/resource-manager/Microsoft.Second";
      for (const [root, provider] of [
        [before, providerA],
        [after, providerA],
        [after, providerB],
      ]) {
        const directory = join(root, provider, "stable", version);
        await mkdir(directory, { recursive: true });
        await writeFile(join(directory, "api.json"), JSON.stringify({ info: { version } }));
      }

      const impact = await evaluateImpact(
        context(
          {
            additions: [
              `${providerA}/stable/${version}/api.json`,
              `${providerB}/stable/${version}/api.json`,
            ],
          },
          after,
          before,
        ),
        [],
      );
      expect(impact.services[0].newApiVersions).toEqual([version]);
      expect(impact.services[0].resourceProvider.newNamespaces).toEqual([providerB]);
    } finally {
      await rm(folder, { recursive: true, force: true });
    }
  });

  it.each([
    { version: "2025-01-01", newApiVersions: [] },
    { version: "2026-01-01", newApiVersions: ["2026-01-01"] },
  ])(
    "uses the provider directory when the Swagger filename repeats its namespace: $version",
    async ({ version, newApiVersions }) => {
      const folder = await mkdtemp(join(tmpdir(), "impact-provider-path-"));
      try {
        const before = join(folder, "before");
        const after = join(folder, "after");
        const provider = "specification/example/resource-manager/Microsoft.Example";
        const oldDirectory = join(before, provider, "stable/2025-01-01");
        const newDirectory = join(after, provider, "stable", version);
        await mkdir(oldDirectory, { recursive: true });
        await mkdir(newDirectory, { recursive: true });
        await writeFile(
          join(oldDirectory, "existing.json"),
          JSON.stringify({ info: { version: "2025-01-01" } }),
        );
        await writeFile(
          join(newDirectory, "Microsoft.Example.json"),
          JSON.stringify({ info: { version } }),
        );

        const impact = await evaluateImpact(
          context(
            { additions: [`${provider}/stable/${version}/Microsoft.Example.json`] },
            after,
            before,
          ),
          [],
        );
        expect(impact.services[0]).toMatchObject({
          newApiVersions,
          resourceProvider: { newNamespaces: [], hasAddedDefinitions: true },
        });
      } finally {
        await rm(folder, { recursive: true, force: true });
      }
    },
  );
});
