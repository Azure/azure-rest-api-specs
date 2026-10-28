import { describe, expect, it } from "vitest";
import { extractInlineSuppressions, extractTspconfigSuppressions } from "../src/extract.ts";

describe("extractTspconfigSuppressions", () => {
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
  it("extracts inline suppressions with semantic-ish anchors", () => {
    const suppressions = extractInlineSuppressions(
      "specification/demo/resource-manager/Microsoft.Demo/Demo",
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
      },
    ]);
  });
});
