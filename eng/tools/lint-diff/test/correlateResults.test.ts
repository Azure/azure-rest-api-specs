import { test, describe, expect } from "vitest";

import { AutorestRunResult, LintDiffViolation, Source, BeforeAfter } from "../src/types.js";
import {
  getViolations,
  getLintDiffViolations,
  arrayIsEqual,
  isFailure,
  isWarning,
  getNewItems,
  isSameSources,
} from "../src/correlateResults.js";
import { relativizePath } from "../src/util.js";
import { isWindows } from "./test-util.js";

describe("getViolations", () => {
  test.sequential("returns a result", () => {
    const newError = `{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"error","message":"Collection object returned by list operation 'RedisEnterprise_ListSkusForScaling' with 'x-ms-pageable' extension, has no property named 'value'.","code":"CollectionObjectPropertiesNaming","details":{"jsonpath":["paths","/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/listSkusForScaling","post","responses","200","schema"],"validationCategory":"","providerNamespace":false,"resourceType":false,"rpcGuidelineCode":"","range":{"start":{"line":1245,"column":21},"end":{"line":1246,"column":52}}},"source":[{"document":"file:///mnt/vss/_work/1/azure-rest-api-specs/specification/redisenterprise/resource-manager/Microsoft.Cache/preview/2025-05-01-preview/redisenterprise.json","position":{"line":1245,"column":13}}]}`;
    const existingErrorInBefore = `{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"error","message":"Properties of a PATCH request body must not be required, property:name.","code":"PatchBodyParametersSchema","details":{"jsonpath":["paths","/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}","patch","parameters","2","schema","properties","sku"],"validationCategory":"","providerNamespace":false,"resourceType":false,"rpcGuidelineCode":"RPC-Patch-V1-10","range":{"start":{"line":1,"column":0},"end":{"line":1,"column":0}}},"source":[{"document":"file:///mnt/vss/_work/1/lint-c93b354fd9c14905bb574a8834c4d69b/specification/redisenterprise/resource-manager/Microsoft.Cache/stable/2025-04-01/redisenterprise.json","position":{"line":201,"column":13}}]}`;
    const correlatedErrorInAfter = ` {"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"error","message":"Properties of a PATCH request body must not be required, property:name.","code":"PatchBodyParametersSchema","details":{"jsonpath":["paths","/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}","patch","parameters","2","schema","properties","sku"],"validationCategory":"","providerNamespace":false,"resourceType":false,"rpcGuidelineCode":"RPC-Patch-V1-10","range":{"start":{"line":1,"column":0},"end":{"line":1,"column":0}}},"source":[{"document":"file:///mnt/vss/_work/1/azure-rest-api-specs/specification/redisenterprise/resource-manager/Microsoft.Cache/preview/2025-05-01-preview/redisenterprise.json","position":{"line":201,"column":13}}]}`;

    const affectedSwaggers = new Set([
      "specification/redisenterprise/resource-manager/Microsoft.Cache/preview/2025-05-01-preview/redisenterprise.json",
    ]);

    const runCorrelations = new Map<string, BeforeAfter>([
      [
        "specification/service1/resource-manager/readme.md#tag1",
        {
          before: {
            rootPath: "before",
            readme: "specification/service1/resource-manager/readme.md",
            tag: "tag1",
            stdout: existingErrorInBefore,
            stderr: "",
          },
          after: {
            rootPath: "after",
            readme: "specification/service1/resource-manager/readme.md",
            tag: "tag1",
            stdout: `${newError}\n${correlatedErrorInAfter}`,
            stderr: "",
          },
        } as BeforeAfter,
      ],
    ]);

    expect(getViolations(runCorrelations, affectedSwaggers)).toEqual([
      [
        expect.objectContaining({
          level: "error",
          code: "CollectionObjectPropertiesNaming",
        }),
      ],
      [
        expect.objectContaining({
          level: "error",
          code: "PatchBodyParametersSchema",
        }),
      ],
    ]);
  });

  test.sequential("correlates warnings with same basename", () => {
    const beforeViolation = `{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"warning","message":"Use the latest version v6 of types.json.","code":"LatestVersionOfCommonTypesMustBeUsed","details":{"jsonpath":["paths","/providers/Microsoft.Cache/operations","get","parameters","0","$ref"],"validationCategory":"","providerNamespace":false,"resourceType":false,"rpcGuidelineCode":"","range":{"start":{"line":51,"column":20},"end":{"line":51,"column":115}}},"source":[{"document":"file:///mnt/vss/_work/1/lint-c93b354fd9c14905bb574a8834c4d69b/specification/redisenterprise/resource-manager/Microsoft.Cache/stable/2025-04-01/redisenterprise.json","position":{"line":51,"column":13}}]}`;
    const afterViolation = `{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"warning","message":"Use the latest version v6 of types.json.","code":"LatestVersionOfCommonTypesMustBeUsed","details":{"jsonpath":["paths","/providers/Microsoft.Cache/operations","get","parameters","0","$ref"],"validationCategory":"","providerNamespace":false,"resourceType":false,"rpcGuidelineCode":"","range":{"start":{"line":51,"column":20},"end":{"line":51,"column":115}}},"source":[{"document":"file:///mnt/vss/_work/1/azure-rest-api-specs/specification/redisenterprise/resource-manager/Microsoft.Cache/preview/2025-05-01-preview/redisenterprise.json","position":{"line":51,"column":13}}]}`;
    const runCorrelations = new Map<string, BeforeAfter>([
      [
        "specification/service1/resource-manager/readme.md#tag1",
        {
          before: {
            rootPath: "before",
            readme: "specification/service1/resource-manager/readme.md",
            tag: "tag1",
            stdout: beforeViolation,
            stderr: "",
          },
          after: {
            rootPath: "after",
            readme: "specification/service1/resource-manager/readme.md",
            tag: "tag1",
            stdout: afterViolation,
            stderr: "",
          },
        } as BeforeAfter,
      ],
    ]);

    const affectedSwaggers = new Set([
      "specification/redisenterprise/resource-manager/Microsoft.Cache/preview/2025-05-01-preview/redisenterprise.json",
    ]);

    expect(getViolations(runCorrelations, affectedSwaggers)).toEqual([
      [],
      [
        expect.objectContaining({
          level: "warning",
          code: "LatestVersionOfCommonTypesMustBeUsed",
        }),
      ],
    ]);
  });

  test.sequential("handles empty beforeViolations", () => {
    const afterViolation = `{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"warning","message":"Use the latest version v6 of types.json.","code":"LatestVersionOfCommonTypesMustBeUsed","details":{"jsonpath":["paths","/providers/Microsoft.Cache/operations","get","parameters","0","$ref"],"validationCategory":"","providerNamespace":false,"resourceType":false,"rpcGuidelineCode":"","range":{"start":{"line":51,"column":20},"end":{"line":51,"column":115}}},"source":[{"document":"file:///mnt/vss/_work/1/azure-rest-api-specs/specification/redisenterprise/resource-manager/Microsoft.Cache/preview/2025-05-01-preview/redisenterprise.json","position":{"line":51,"column":13}}]}`;

    const runCorrelations = new Map<string, BeforeAfter>([
      [
        "specification/service1/resource-manager/readme.md#tag1",
        {
          before: null,
          after: {
            rootPath: "after",
            readme: "specification/service1/resource-manager/readme.md",
            tag: "tag1",
            stdout: afterViolation,
            stderr: "",
          },
        } as BeforeAfter,
      ],
    ]);

    const affectedSwaggers = new Set([
      "specification/redisenterprise/resource-manager/Microsoft.Cache/preview/2025-05-01-preview/redisenterprise.json",
    ]);

    expect(getViolations(runCorrelations, affectedSwaggers)).toEqual([
      [
        expect.objectContaining({
          level: "warning",
          code: "LatestVersionOfCommonTypesMustBeUsed",
        }),
      ],
      [],
    ]);
  });
});

describe("isSameSources", () => {
  test.sequential("returns true when sources are the same", () => {
    const a: Source[] = [{ document: "path/to/document1.json" } as Source];
    const b: Source[] = [{ document: "a/different/path/to/document1.json" } as Source];

    expect(isSameSources(a, b)).toEqual(true);
  });

  test.sequential("returns true when one source is empty", () => {
    const a: Source[] = [{ document: "path/to/document1.json" } as Source];
    const b: Source[] = [];

    expect(isSameSources(a, b)).toEqual(true);
  });
});

describe("getLintDiffViolations", async () => {
  function createRunResult(stdout: string, stderr: string = ""): AutorestRunResult {
    return {
      rootPath: "string",
      readme: "string",
      tag: "string",
      error: null,
      stdout: stdout,
      stderr: stderr,
    };
  }

  test.sequential("returns an empty array on no interesting violations", () => {
    const runResult =
      createRunResult(`{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"spectralPluginFunc: Validating OpenAPI spec. TypeSpec-generated: true. Path: 'file:///home/djurek/azure-rest-api-specs/specification/codesigning/resource-manager/Microsoft.CodeSigning/stable/2025-03-30/codeSigningAccount.json'"}
{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"openapiValidatorPluginFunc: Return"}`);

    const violations = getLintDiffViolations(runResult);
    expect(violations).toEqual([]);
  });

  test.sequential("returns an error on an interesting violation", () => {
    const runResult =
      createRunResult(`{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"spectralPluginFunc: Validating OpenAPI spec. TypeSpec-generated: true. Path: 'file:///home/djurek/azure-rest-api-specs/specification/codesigning/resource-manager/Microsoft.CodeSigning/stable/2025-03-30/codeSigningAccount.json'"}
{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"error","message":"Top level property names should not be repeated inside the properties bag for ARM resource 'CodeSigningAccount'. Properties [properties.sku] conflict with ARM top level properties. Please rename these.","code":"ArmResourcePropertiesBag","details":{"jsonpath":["definitions","CodeSigningAccount"],"validationCategory":"ARMViolation","providerNamespace":false,"resourceType":false,"range":{"start":{"line":1036,"column":27},"end":{"line":1051,"column":6}}},"source":[{"document":"file:///home/djurek/azure-rest-api-specs/specification/codesigning/resource-manager/Microsoft.CodeSigning/stable/2025-03-30/codeSigningAccount.json","position":{"line":1036,"column":5}}]}
{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"openapiValidatorPluginFunc: Return"}`);

    const violations = getLintDiffViolations(runResult);
    expect(violations.length).toEqual(1);
    expect(violations[0].level).toEqual("error");
    expect(violations[0].code).toEqual("ArmResourcePropertiesBag");
  });

  test.sequential(
    "returns an empty array on violations that don't have extensionname @microsoft.azure/openapi-validator",
    () => {
      const runResult =
        createRunResult(`{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"spectralPluginFunc: Validating OpenAPI spec. TypeSpec-generated: true. Path: 'file:///home/djurek/azure-rest-api-specs/specification/codesigning/resource-manager/Microsoft.CodeSigning/stable/2025-03-30/codeSigningAccount.json'"}
{"pluginName":"spectral","extensionName":"THIS IS FILTERED OUT","level":"error","message":"Top level property names should not be repeated inside the properties bag for ARM resource 'CodeSigningAccount'. Properties [properties.sku] conflict with ARM top level properties. Please rename these.","code":"ArmResourcePropertiesBag","details":{"jsonpath":["definitions","CodeSigningAccount"],"validationCategory":"ARMViolation","providerNamespace":false,"resourceType":false,"range":{"start":{"line":1036,"column":27},"end":{"line":1051,"column":6}}},"source":[{"document":"file:///home/djurek/azure-rest-api-specs/specification/codesigning/resource-manager/Microsoft.CodeSigning/stable/2025-03-30/codeSigningAccount.json","position":{"line":1036,"column":5}}]}
{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"openapiValidatorPluginFunc: Return"}`);

      const violations = getLintDiffViolations(runResult);
      expect(violations).toEqual([]);
    },
  );

  test.sequential("returns a violation with code FATAL if the result.code is undefined", () => {
    const runResult = createRunResult(
      `{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","message": "test message with no code"}`,
    );
    const violations = getLintDiffViolations(runResult);
    expect(violations[0].code).toEqual("FATAL");
  });
});

describe("arrayIsEqual", () => {
  test.sequential("returns true for equal arrays", async () => {
    const a = ["a", "b", "c"];
    const b = ["a", "b", "c"];

    const result = arrayIsEqual(a, b);
    expect(result).toEqual(true);
  });

  test.sequential("returns false for different arrays", async () => {
    const a = ["a", "b", "c"];
    const b = ["a", "b", "d"];

    const result = arrayIsEqual(a, b);
    expect(result).toEqual(false);
  });

  test.sequential("returns false for different lengths", async () => {
    const a = ["a", "b", "c"];
    const b = ["a", "b"];

    const result = arrayIsEqual(a, b);
    expect(result).toEqual(false);
  });

  test.sequential("returns true for empty arrays", async () => {
    const a: string[] = [];
    const b: string[] = [];

    const result = arrayIsEqual(a, b);
    expect(result).toEqual(true);
  });

  test.sequential("returns true for equal arrays with different types", async () => {
    const a = ["a", 1, "c"];
    const b = ["a", 1, "c"];

    const result = arrayIsEqual(a, b);
    expect(result).toEqual(true);
  });
});

describe("isFailure", () => {
  // Data driven test
  test.each([
    { level: "error", expected: true },
    { level: "fatal", expected: true },
    { level: "warning", expected: false },
    { level: "information", expected: false },
    { level: "info", expected: false },
  ])(`isFailure($level) returns $expected`, ({ level, expected }) => {
    expect(isFailure(level)).toEqual(expected);
  });
});

describe("isWarning", () => {
  test.each([
    { level: "error", expected: false },
    { level: "fatal", expected: false },
    { level: "warning", expected: true },
    { level: "information", expected: false },
    { level: "info", expected: false },
  ])(`isWarning($level) returns $expected`, ({ level, expected }) => {
    expect(isWarning(level)).toEqual(expected);
  });
});

describe("getNewItems", () => {
  test.sequential("returns empty array when no before or after", () => {
    const before: LintDiffViolation[] = [];
    const after: LintDiffViolation[] = [];

    const result = getNewItems(before, after);
    expect(result).toEqual([[], []]);
  });

  test.sequential("a fatal error is always new", () => {
    const before = [
      {
        level: "fatal",
        code: "SomeCode1",
        message: "Some Message",
        source: [
          { document: "path/to/document1.json", position: { line: 1, colomn: 1 } } as Source,
        ],
        details: {},
      } as LintDiffViolation,
    ];
    const after = [
      {
        level: "fatal",
        code: "SomeCode1",
        message: "Some Message",
        source: [
          { document: "path/to/document1.json", position: { line: 1, colomn: 1 } } as Source,
        ],
        details: {},
      } as LintDiffViolation,
    ];

    const result = getNewItems(before, after);
    expect(result).toEqual([after, []]);
  });

  test.sequential("returns all after items when no before", () => {
    const before: LintDiffViolation[] = [];
    const after = [
      {
        level: "error",
        code: "SomeCode1",
        message: "Some Message",
        source: [
          { document: "path/to/document1.json", position: { line: 1, colomn: 1 } } as Source,
        ],
        details: {},
      } as LintDiffViolation,
      {
        level: "error",
        code: "SomeCode2",
        message: "Some Message",
        source: [
          { document: "path/to/document2.json", position: { line: 1, colomn: 1 } } as Source,
        ],
        details: {},
      } as LintDiffViolation,
    ];

    const result = getNewItems(before, after);
    expect(result).toEqual([after, []]);
  });

  test.sequential("returns only new errors", () => {
    const before: LintDiffViolation[] = [
      {
        level: "error",
        code: "SomeCode1",
        message: "Some Message",
        source: [
          { document: "path/to/document1.json", position: { line: 1, colomn: 1 } } as Source,
        ],
        details: {
          jsonpath: ["some", "path"],
        },
      } as LintDiffViolation,
    ];
    const after = [
      {
        level: "error",
        code: "SomeCode1",
        message: "Some Message",
        source: [
          { document: "path/to/document1.json", position: { line: 1, colomn: 1 } } as Source,
        ],
        details: {
          jsonpath: ["some", "path"],
        },
      } as LintDiffViolation,
      {
        level: "error",
        code: "SomeCode2",
        message: "Some Message",
        source: [
          { document: "path/to/document2.json", position: { line: 1, colomn: 1 } } as Source,
        ],
        details: {
          jsonpath: ["some", "path"],
        },
      } as LintDiffViolation,
    ];

    const result = getNewItems(before, after);
    expect(result).toEqual([after.slice(1), before]);
  });
});

describe("relativizePath", () => {
  test.skipIf(isWindows).sequential("relativizes path correctly", () => {
    expect(relativizePath("/path/to/specification/service/file.json")).toEqual(
      "/specification/service/file.json",
    );
  });

  test.sequential("returns the same path if it doesn't include from", () => {
    expect(relativizePath("/path/to/other/file.json")).toEqual("/path/to/other/file.json");
  });

  test.sequential("returns empty string when path is empty", () => {
    expect(relativizePath("")).toEqual("");
  });

  test.skipIf(isWindows).sequential("uses the last instance of from", () => {
    expect(
      relativizePath("/path/to/specification/another/specification/service/file.json"),
    ).toEqual("/specification/service/file.json");
  });
});
