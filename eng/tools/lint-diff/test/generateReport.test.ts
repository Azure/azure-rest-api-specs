import { test, describe, expect } from "vitest";

import { AutorestRunResult } from "../src/util.js";
import {
  getLintDiffViolations,
  arrayIsEqual,
  isFailure,
  isWarning,
  LintDiffViolation,
  getNewItems,
  Source,
  iconFor,
  getLine,
  getFile,
  relativizePath,
  getDocUrl,
  getFileLink,
  getPathSegment,
  compareLintDiffViolations,
} from "../src/generateReport.js";
import { isWindows } from "./test-util.js";

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

  test.concurrent("returns an empty array on no interesting violations", ({ expect }) => {
    const runResult =
      createRunResult(`{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"spectralPluginFunc: Validating OpenAPI spec. TypeSpec-generated: true. Path: 'file:///home/djurek/azure-rest-api-specs/specification/codesigning/resource-manager/Microsoft.CodeSigning/stable/2025-03-30/codeSigningAccount.json'"}
{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"openapiValidatorPluginFunc: Return"}`);

    const violations = getLintDiffViolations(runResult);
    expect(violations).toEqual([]);
  });

  test.concurrent("returns an error on an interesting violation", ({ expect }) => {
    const runResult =
      createRunResult(`{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"spectralPluginFunc: Validating OpenAPI spec. TypeSpec-generated: true. Path: 'file:///home/djurek/azure-rest-api-specs/specification/codesigning/resource-manager/Microsoft.CodeSigning/stable/2025-03-30/codeSigningAccount.json'"}
{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"error","message":"Top level property names should not be repeated inside the properties bag for ARM resource 'CodeSigningAccount'. Properties [properties.sku] conflict with ARM top level properties. Please rename these.","code":"ArmResourcePropertiesBag","details":{"jsonpath":["definitions","CodeSigningAccount"],"validationCategory":"ARMViolation","providerNamespace":false,"resourceType":false,"range":{"start":{"line":1036,"column":27},"end":{"line":1051,"column":6}}},"source":[{"document":"file:///home/djurek/azure-rest-api-specs/specification/codesigning/resource-manager/Microsoft.CodeSigning/stable/2025-03-30/codeSigningAccount.json","position":{"line":1036,"column":5}}]}
{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"openapiValidatorPluginFunc: Return"}`);

    const violations = getLintDiffViolations(runResult);
    expect(violations.length).toEqual(1);
    expect(violations[0].level).toEqual("error");
    expect(violations[0].code).toEqual("ArmResourcePropertiesBag");
  });

  test.concurrent(
    "returns an empty array on violations that don't have extensionname @microsoft.azure/openapi-validator",
    ({ expect }) => {
      const runResult =
        createRunResult(`{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"spectralPluginFunc: Validating OpenAPI spec. TypeSpec-generated: true. Path: 'file:///home/djurek/azure-rest-api-specs/specification/codesigning/resource-manager/Microsoft.CodeSigning/stable/2025-03-30/codeSigningAccount.json'"}
{"pluginName":"spectral","extensionName":"THIS IS FILTERED OUT","level":"error","message":"Top level property names should not be repeated inside the properties bag for ARM resource 'CodeSigningAccount'. Properties [properties.sku] conflict with ARM top level properties. Please rename these.","code":"ArmResourcePropertiesBag","details":{"jsonpath":["definitions","CodeSigningAccount"],"validationCategory":"ARMViolation","providerNamespace":false,"resourceType":false,"range":{"start":{"line":1036,"column":27},"end":{"line":1051,"column":6}}},"source":[{"document":"file:///home/djurek/azure-rest-api-specs/specification/codesigning/resource-manager/Microsoft.CodeSigning/stable/2025-03-30/codeSigningAccount.json","position":{"line":1036,"column":5}}]}
{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"openapiValidatorPluginFunc: Return"}`);

      const violations = getLintDiffViolations(runResult);
      expect(violations).toEqual([]);
    },
  );

  test.concurrent("returns a violation with code FATAL if the result.code is undefined", () => {
    const runResult = createRunResult(
      `{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","message": "test message with no code"}`,
    );
    const violations = getLintDiffViolations(runResult);
    expect(violations[0].code).toEqual("FATAL");
  });
});

describe("arrayIsEqual", () => {
  test.concurrent("returns true for equal arrays", async ({ expect }) => {
    const a = ["a", "b", "c"];
    const b = ["a", "b", "c"];

    const result = arrayIsEqual(a, b);
    expect(result).toEqual(true);
  });

  test.concurrent("returns false for different arrays", async ({ expect }) => {
    const a = ["a", "b", "c"];
    const b = ["a", "b", "d"];

    const result = arrayIsEqual(a, b);
    expect(result).toEqual(false);
  });

  test.concurrent("returns false for different lengths", async ({ expect }) => {
    const a = ["a", "b", "c"];
    const b = ["a", "b"];

    const result = arrayIsEqual(a, b);
    expect(result).toEqual(false);
  });

  test.concurrent("returns true for empty arrays", async ({ expect }) => {
    const a: string[] = [];
    const b: string[] = [];

    const result = arrayIsEqual(a, b);
    expect(result).toEqual(true);
  });

  test.concurrent("returns true for equal arrays with different types", async ({ expect }) => {
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
  test.concurrent("returns empty array when no before or after", ({ expect }) => {
    const before: LintDiffViolation[] = [];
    const after: LintDiffViolation[] = [];

    const result = getNewItems(before, after);
    expect(result).toEqual([[], []]);
  });

  test.concurrent("a fatal error is always new", ({ expect }) => {
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

  test.concurrent("returns all after items when no before", ({ expect }) => {
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

  test.concurrent("returns only new errors", ({ expect }) => {
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

describe("iconFor", () => {
  test.each([
    { input: "error", expected: ":x:" },
    { input: "warning", expected: ":warning:" },
    { input: "info", expected: ":warning:" },
  ])(`iconFor($input) returns $expected`, ({ input, expected }) => {
    expect(iconFor(input)).toEqual(expected);
  });
});

describe("getLine", () => {
  test.concurrent("returns the line number", ({ expect }) => {
    const violation = {
      level: "fatal",
      code: "SomeCode1",
      message: "Some Message",
      source: [{ document: "path/to/document1.json", position: { line: 1, colomn: 1 } } as Source],
      details: {},
    } as LintDiffViolation;

    const actual = getLine(violation);
    expect(actual).toEqual(1);
  });

  test.concurrent("returns undefined when source is empty array", ({ expect }) => {
    const violation = {
      level: "fatal",
      code: "SomeCode1",
      message: "Some Message",
      source: [] as Source[],
      details: {},
    } as LintDiffViolation;

    const actual = getLine(violation);
    expect(actual).toEqual(undefined);
  });

  test.concurrent("returns undefined when source position is empty", ({ expect }) => {
    const violation = {
      level: "fatal",
      code: "SomeCode1",
      message: "Some Message",
      source: [{ document: "path/to/document1.json", position: {} } as Source],
      details: {},
    } as LintDiffViolation;

    const actual = getLine(violation);
    expect(actual).toEqual(undefined);
  });

  test.concurrent("returns 0 when source position is 0", ({ expect }) => {
    const violation = {
      level: "fatal",
      code: "SomeCode1",
      message: "Some Message",
      source: [{ document: "path/to/document1.json", position: { line: 0 } } as Source],
      details: {},
    } as LintDiffViolation;

    const actual = getLine(violation);
    expect(actual).toEqual(0);
  });
});

describe("getFile", () => {
  test.concurrent("returns the file name", ({ expect }) => {
    const violation = {
      level: "fatal",
      code: "SomeCode1",
      message: "Some Message",
      source: [{ document: "path/to/document1.json", position: { line: 1, colomn: 1 } } as Source],
      details: {},
    } as LintDiffViolation;

    const actual = getFile(violation);
    expect(actual).toEqual("path/to/document1.json");
  });

  test.concurrent("returns empty string when source is empty array", ({ expect }) => {
    const violation = {
      level: "fatal",
      code: "SomeCode1",
      message: "Some Message",
      source: [] as Source[],
      details: {},
    } as LintDiffViolation;

    const actual = getFile(violation);
    expect(actual).toEqual("");
  });
});

describe("relativizePath", () => {
  test.skipIf(isWindows)
  .concurrent("relativizes path correctly", ({ expect }) => {
    expect(relativizePath("/path/to/specification/service/file.json")).toEqual(
      "/specification/service/file.json",
    );
  });

  test.concurrent("returns the same path if it doesn't include from", ({ expect }) => {
    expect(relativizePath("/path/to/other/file.json")).toEqual("/path/to/other/file.json");
  });

  test.concurrent("returns empty string when path is empty", ({ expect }) => {
    expect(relativizePath("")).toEqual("");
  });

  test.skipIf(isWindows)
  .concurrent("uses the last instance of from", ({ expect }) => {
    expect(
      relativizePath("/path/to/specification/another/specification/service/file.json"),
    ).toEqual("/specification/service/file.json");
  });
});

describe("getDocUrl", () => {
  test.concurrent("returns a pointer to a kebab-cased markdown file", ({ expect }) => {
    expect(getDocUrl("TestViolation")).toEqual(
      "https://github.com/Azure/azure-openapi-validator/blob/main/docs/test-violation.md",
    );
  });

  test.concurrent("returns N/A when code is FATAL", ({ expect }) => {
    expect(getDocUrl("FATAL")).toEqual("N/A");
  });
});

describe("getFileLink", () => {
  test.concurrent("does not include #L if line is null", ({ expect }) => {
    expect(getFileLink("abc123", "file.json", null)).not.toContain("#L");
  });

  test.concurrent("includes #L if line is not null", ({ expect }) => {
    expect(getFileLink("abc123", "file.json", 1)).toContain("#L1");
  });

  test.concurrent("returns the correct link with preceeding forward slash", ({ expect }) => {
    expect(getFileLink("abc123", "/file.json", 1)).toEqual(
      "https://github.com/Azure/azure-rest-api-specs/blob/abc123/file.json#L1",
    );
  });
});

describe("getPathSegment", () => {
  test.concurrent("returns trailing segments of a path", ({ expect }) => {
    expect(
      getPathSegment(
        "/specification/recoveryservicessiterecovery/resource-manager/Microsoft.RecoveryServices/stable/2025-01-01/service.json",
      ),
    ).toEqual("Microsoft.RecoveryServices/stable/2025-01-01/service.json");
  });
});

describe("compareLintDiffViolations", () => {
  test.concurrent("returns 0 if equal", ({ expect }) => {
    const a: LintDiffViolation = {
      level: "error",
      code: "SomeCode1",
      message: "Some Message",
      source: [{ document: "path/to/document1.json", position: { line: 1, colomn: 1 } } as Source],
      details: {},
    } as LintDiffViolation;
    const b = { ...a };

    const actual = compareLintDiffViolations(a, b);
    expect(actual).toEqual(0);
  });

  test.concurrent("returns 0 if a and b are equal and don't have lines", ({ expect }) => {
    const a: LintDiffViolation = {
      level: "warning",
      code: "SomeCode1",
      message: "Some Message",
      source: [{ document: "path/to/document1.json", position: {} } as Source],
      details: {},
    } as LintDiffViolation;
    const b = {
      ...a,
      source: [{ document: "path/to/document1.json", position: {} } as Source],
    };

    const actual = compareLintDiffViolations(a, b);
    expect(actual).toEqual(0);
  });

  test.concurrent("returns -1 if a level is less than b's level", ({ expect }) => {
    const a: LintDiffViolation = {
      level: "error",
      code: "SomeCode1",
      message: "Some Message",
      source: [{ document: "path/to/document1.json", position: { line: 1, colomn: 1 } } as Source],
      details: {},
    } as LintDiffViolation;
    const b = { ...a, level: "warning" };

    const actual = compareLintDiffViolations(a, b);
    expect(actual).toEqual(-1);
  });

  test.concurrent("returns 1 if a level is greater than b's level", ({ expect }) => {
    const a: LintDiffViolation = {
      level: "warning",
      code: "SomeCode1",
      message: "Some Message",
      source: [{ document: "path/to/document1.json", position: { line: 1, colomn: 1 } } as Source],
      details: {},
    } as LintDiffViolation;
    const b = { ...a, level: "error" };

    const actual = compareLintDiffViolations(a, b);
    expect(actual).toEqual(1);
  });

  test.concurrent("returns -1 if a's file is less than b's file", ({ expect }) => {
    const a: LintDiffViolation = {
      level: "warning",
      code: "SomeCode1",
      message: "Some Message",
      source: [{ document: "path/to/document1.json", position: { line: 1, colomn: 1 } } as Source],
      details: {},
    } as LintDiffViolation;
    const b = {
      ...a,
      source: [{ document: "path/to/document2.json", position: { line: 1, colomn: 1 } } as Source],
    };

    const actual = compareLintDiffViolations(a, b);
    expect(actual).toEqual(-1);
  });

  test.concurrent("returns 1 if a's file is greater than b's file", ({ expect }) => {
    const a: LintDiffViolation = {
      level: "warning",
      code: "SomeCode1",
      message: "Some Message",
      source: [{ document: "path/to/document2.json", position: { line: 1, colomn: 1 } } as Source],
      details: {},
    } as LintDiffViolation;
    const b = {
      ...a,
      source: [{ document: "path/to/document1.json", position: { line: 1, colomn: 1 } } as Source],
    };

    const actual = compareLintDiffViolations(a, b);
    expect(actual).toEqual(1);
  });

  test.concurrent("returns -1 if a's line is less than b's line", ({ expect }) => {
    const a: LintDiffViolation = {
      level: "warning",
      code: "SomeCode1",
      message: "Some Message",
      source: [{ document: "path/to/document1.json", position: { line: 1, colomn: 1 } } as Source],
      details: {},
    } as LintDiffViolation;
    const b = {
      ...a,
      source: [{ document: "path/to/document1.json", position: { line: 2, colomn: 1 } } as Source],
    };

    const actual = compareLintDiffViolations(a, b);
    expect(actual).toEqual(-1);
  });

  test.concurrent("returns 1 if a's line is greater than b's line", ({ expect }) => {
    const a: LintDiffViolation = {
      level: "warning",
      code: "SomeCode1",
      message: "Some Message",
      source: [{ document: "path/to/document1.json", position: { line: 2, colomn: 1 } } as Source],
      details: {},
    } as LintDiffViolation;
    const b = {
      ...a,
      source: [{ document: "path/to/document1.json", position: { line: 1, colomn: 1 } } as Source],
    };

    const actual = compareLintDiffViolations(a, b);
    expect(actual).toEqual(1);
  });
});
