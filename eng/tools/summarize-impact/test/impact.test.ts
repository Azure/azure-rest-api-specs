import { mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
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
        typeSpec: true,
      }),
    ]);
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
});
