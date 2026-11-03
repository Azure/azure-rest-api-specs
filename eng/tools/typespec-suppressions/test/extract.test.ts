import { describe, expect, it } from "vitest";
import { extractInlineSuppressions, extractTspconfigSuppressions } from "../src/extract.ts";

describe("extractTspconfigSuppressions", () => {
  it("rejects invalid disables instead of reporting an empty inventory", () => {
    expect(() =>
      extractTspconfigSuppressions("demo", "demo/tspconfig.yaml", "linter: { disable: { rule } }"),
    ).toThrow("Failed to parse demo/tspconfig.yaml:");
  });

  it("extracts linter.disable suppressions with locations", () => {
    const suppressions = extractTspconfigSuppressions(
      "specification/demo/resource-manager/Microsoft.Demo/Demo",
      "specification/demo/resource-manager/Microsoft.Demo/Demo/tspconfig.yaml",
      `linter:
  disable:
    "@azure-tools/rule-a": "first reason"
    "@azure-tools/rule-b": "second reason"
`,
    );

    expect(suppressions).toEqual([
      {
        specPath: "specification/demo/resource-manager/Microsoft.Demo/Demo",
        sourceKind: "tspconfig",
        ruleName: "@azure-tools/rule-a",
        justification: "first reason",
        sourceFile: "specification/demo/resource-manager/Microsoft.Demo/Demo/tspconfig.yaml",
        anchorPath: "tspconfig:linter.disable.@azure-tools/rule-a",
        location: { line: 3, column: 5 },
        rawText: "@azure-tools/rule-a: first reason",
      },
      {
        specPath: "specification/demo/resource-manager/Microsoft.Demo/Demo",
        sourceKind: "tspconfig",
        ruleName: "@azure-tools/rule-b",
        justification: "second reason",
        sourceFile: "specification/demo/resource-manager/Microsoft.Demo/Demo/tspconfig.yaml",
        anchorPath: "tspconfig:linter.disable.@azure-tools/rule-b",
        location: { line: 4, column: 5 },
        rawText: "@azure-tools/rule-b: second reason",
      },
    ]);
  });
});

describe("extractInlineSuppressions", () => {
  it("tracks cross-file diagnostics while keeping imported shared files out of the report", async () => {
    const sources = new Map([
      [
        "demo/main.tsp",
        'import "../shared";\n#suppress "deprecated" "kept"\nmodel Widget { value: Old; }',
      ],
    ]);
    const suppressions = await extractInlineSuppressions("demo", sources, {
      readFile: (sourcePath) =>
        Promise.resolve(
          sourcePath === "shared/main.tsp"
            ? '#deprecated "old"\n#suppress "deprecated" "shared"\nmodel Old {}'
            : sources.get(sourcePath),
        ),
      stat: (sourcePath) =>
        Promise.resolve(
          sourcePath === "shared" || sourcePath === "shared/main.tsp"
            ? {
                isDirectory: () => sourcePath === "shared",
                isFile: () => sourcePath === "shared/main.tsp",
              }
            : undefined,
        ),
    });
    expect(suppressions).toMatchObject([
      { sourceFile: "demo/main.tsp", ruleName: "deprecated", used: true },
    ]);
    expect(suppressions).toHaveLength(1);
  });

  it("reports suppressions on and inside block namespaces", async () => {
    const suppressions = await extractInlineSuppressions(
      "demo",
      new Map([
        [
          "demo/main.tsp",
          `#suppress "library/namespace" "namespace reason"
namespace Demo.Service {
  #suppress "library/model" "model reason"
  model Widget {}
}`,
        ],
      ]),
    );
    expect(suppressions.map(({ ruleName, anchorPath }) => [ruleName, anchorPath])).toEqual([
      ["library/namespace", "namespace:Demo.Service"],
      ["library/model", "namespace:Demo.Service/model:Widget"],
    ]);
  });

  it("rejects parse errors instead of producing a partial inventory", async () => {
    await expect(
      extractInlineSuppressions(
        "demo",
        new Map([["demo/main.tsp", "#suppress 123\nmodel Widget {}"]]),
      ),
    ).rejects.toThrow("Failed to parse");
  });

  it("extracts inline suppressions with semantic-ish anchors", async () => {
    const suppressions = await extractInlineSuppressions(
      "specification/demo/resource-manager/Microsoft.Demo/Demo",
      new Map([
        [
          "specification/demo/resource-manager/Microsoft.Demo/Demo/main.tsp",
          `namespace Demo.Service;

model Widget {
  #suppress "@azure-tools/rule-a" "property reason"
  name: string;
}

interface Widgets {
  #suppress "@azure-tools/rule-b" "operation reason"
  read(): Widget;
}
`,
        ],
      ]),
    );

    expect(suppressions).toEqual([
      {
        specPath: "specification/demo/resource-manager/Microsoft.Demo/Demo",
        sourceKind: "inline",
        ruleName: "@azure-tools/rule-a",
        justification: "property reason",
        sourceFile: "specification/demo/resource-manager/Microsoft.Demo/Demo/main.tsp",
        anchorPath: "namespace:Demo.Service/model:Widget/property:name",
        location: { line: 4, column: 3 },
        rawText: '#suppress "@azure-tools/rule-a" "property reason"',
        used: false,
      },
      {
        specPath: "specification/demo/resource-manager/Microsoft.Demo/Demo",
        sourceKind: "inline",
        ruleName: "@azure-tools/rule-b",
        justification: "operation reason",
        sourceFile: "specification/demo/resource-manager/Microsoft.Demo/Demo/main.tsp",
        anchorPath: "namespace:Demo.Service/interface:Widgets/op:read",
        location: { line: 9, column: 3 },
        rawText: '#suppress "@azure-tools/rule-b" "operation reason"',
        used: false,
      },
    ]);
  });
});
