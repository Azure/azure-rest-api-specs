import { beforeEach, test, describe, expect, vi } from "vitest";
import {
  compareLintDiffViolations,
  generateAutoRestErrorReport,
  generateLintDiffReport,
  getDocUrl,
  getFile,
  getFileLink,
  getLine,
  getPathSegment,
  iconFor,
} from "../src/generateReport.js";
import {
  Source,
  LintDiffViolation,
  BeforeAfter,
  AutorestRunResult,
  AutoRestMessage,
} from "../src/lintdiff-types.js";
import { isWindows } from "./test-util.js";

import { vol } from "memfs";

vi.mock("node:fs/promises", async () => {
  const memfs = await vi.importActual("memfs") as typeof import("memfs");
  return {
    ...memfs.fs.promises,
  };
});

import { readFile } from "fs/promises";

vi.mock("../src/util.js", async () => {
  const original = await vi.importActual("../src/util.js");
  return {
    ...original,
    getDependencyVersion: vi.fn().mockResolvedValue("1.0.0"),
    getPathToDependency: vi.fn().mockResolvedValue("path/to/dependency"),
  };
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
  test("returns the line number", () => {
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

  test("returns undefined when source is empty array", () => {
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

  test("returns undefined when source position is empty", () => {
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

  test("returns 0 when source position is 0", () => {
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
  test("returns the file name", () => {
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

  test("returns empty string when source is empty array", () => {
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

describe("getDocUrl", () => {
  test("returns a pointer to a kebab-cased markdown file", () => {
    expect(getDocUrl("TestViolation")).toEqual(
      "https://github.com/Azure/azure-openapi-validator/blob/main/docs/test-violation.md",
    );
  });

  test("returns N/A when code is FATAL", () => {
    expect(getDocUrl("FATAL")).toEqual("N/A");
  });
});

describe("getFileLink", () => {
  test("does not include #L if line is null", () => {
    expect(getFileLink("abc123", "file.json", null)).not.toContain("#L");
  });

  test("includes #L if line is not null", () => {
    expect(getFileLink("abc123", "file.json", 1)).toContain("#L1");
  });

  test("returns the correct link with preceeding forward slash", () => {
    expect(getFileLink("abc123", "/file.json", 1)).toEqual(
      "https://github.com/Azure/azure-rest-api-specs/blob/abc123/file.json#L1",
    );
  });
});

describe("getPathSegment", () => {
  test("returns trailing segments of a path", () => {
    expect(
      getPathSegment(
        "/specification/recoveryservicessiterecovery/resource-manager/Microsoft.RecoveryServices/stable/2025-01-01/service.json",
      ),
    ).toEqual("Microsoft.RecoveryServices/stable/2025-01-01/service.json");
  });
});

describe("compareLintDiffViolations", () => {
  test("returns 0 if equal", () => {
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

  test("returns 0 if a and b are equal and don't have lines", () => {
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

  test("returns -1 if a level is less than b's level", () => {
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

  test("returns 1 if a level is greater than b's level", () => {
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

  test("returns -1 if a's file is less than b's file", () => {
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

  test("returns 1 if a's file is greater than b's file", () => {
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

  test("returns -1 if a's line is less than b's line", () => {
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

  test("returns 1 if a's line is greater than b's line", () => {
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

describe("generateLintDiffReport", () => {
  beforeEach(() => {
    vol.reset();

    // Seed current filesystem so that "." exists.
    vol.mkdirSync(".", { recursive: true });
  });
  test.skipIf(isWindows())("fails if new violations include an error", async ({ expect }) => {
    const afterViolation = {
      extensionName: "@microsoft.azure/openapi-validator",
      level: "error",
      code: "SomeCode",
      message: "Some Message",
      source: [
        {
          document:
            "/home/test/specification/contosowidgetmanager/data-plane/Azure.Contoso.WidgetManager/stable/2022-12-01/widgets.json",
          position: { line: 1, colomn: 1 },
        } as Source,
      ],
      details: {},
    };

    const beforeResult = {
      error: null,
      stdout: "",
      stderr: "",
      rootPath: "",
      readme: "file1.md",
      tag: "",
    } as AutorestRunResult;
    const afterResult = {
      error: null,
      stdout: JSON.stringify(afterViolation),
      stderr: "",
      rootPath: "",
      readme: "file1.md",
      tag: "",
    } as AutorestRunResult;

    const runCorrelations = new Map<string, BeforeAfter>([
      ["file1.md", { before: beforeResult, after: afterResult }],
    ]);

    const outFile = "test-output.md";
    const actual = await generateLintDiffReport(
      runCorrelations,
      new Set<string>([
        "specification/contosowidgetmanager/data-plane/Azure.Contoso.WidgetManager/stable/2022-12-01/widgets.json",
      ]),
      outFile,
      "baseBranch",
      "compareSha",
    );
    expect(actual).toBe(false);
    expect(await readFile(outFile, { encoding: "utf-8" })).toMatchInlineSnapshot(`
      "| Compared specs ([v1.0.0](https://www.npmjs.com/package/@microsoft.azure/openapi-validator/v/1.0.0)) | new version | base version |
      | --- | --- | --- |
      | default | [default](https://github.com/Azure/azure-rest-api-specs/blob/compareSha/file1.md) | [default](https://github.com/Azure/azure-rest-api-specs/blob/baseBranch/file1.md) |


      **[must fix]The following errors/warnings are intorduced by current PR:**

      | Rule | Message | Related RPC [For API reviewers] |
      | ---- | ------- | ------------------------------- |
      | :x: [SomeCode](https://github.com/Azure/azure-openapi-validator/blob/main/docs/some-code.md) | Some Message<br />Location: [Azure.Contoso.WidgetManager/stable/2022-12-01/widgets.json#L1](https://github.com/Azure/azure-rest-api-specs/blob/compareSha/specification/contosowidgetmanager/data-plane/Azure.Contoso.WidgetManager/stable/2022-12-01/widgets.json#L1) |  |

      "
    `);
  });

  test.skipIf(isWindows())(
    "passes if new violations do not include an error (warnings only)",
    async ({ expect }) => {
      const afterViolation = {
        extensionName: "@microsoft.azure/openapi-validator",
        level: "warning",
        code: "SomeCode",
        message: "Some Message",
        source: [
          {
            document:
              "/home/test/specification/contosowidgetmanager/data-plane/Azure.Contoso.WidgetManager/stable/2022-12-01/widgets.json",
            position: { line: 1, colomn: 1 },
          } as Source,
        ],
        details: {},
      };

      const beforeResult = {
        error: null,
        stdout: "",
        stderr: "",
        rootPath: "",
        readme: "file1.md",
        tag: "",
      } as AutorestRunResult;
      const afterResult = {
        error: null,
        stdout: JSON.stringify(afterViolation),
        stderr: "",
        rootPath: "",
        readme: "file1.md",
        tag: "",
      } as AutorestRunResult;

      const runCorrelations = new Map<string, BeforeAfter>([
        ["file1.md", { before: beforeResult, after: afterResult }],
      ]);

      const outFile = "test-output.md";
      const actual = await generateLintDiffReport(
        runCorrelations,
        new Set<string>([
          "specification/contosowidgetmanager/data-plane/Azure.Contoso.WidgetManager/stable/2022-12-01/widgets.json",
        ]),
        outFile,
        "baseBranch",
        "compareSha",
      );
      expect(actual).toBe(true);
      
      expect(await readFile(outFile, { encoding: "utf-8" })).toMatchInlineSnapshot(`
        "| Compared specs ([v1.0.0](https://www.npmjs.com/package/@microsoft.azure/openapi-validator/v/1.0.0)) | new version | base version |
        | --- | --- | --- |
        | default | [default](https://github.com/Azure/azure-rest-api-specs/blob/compareSha/file1.md) | [default](https://github.com/Azure/azure-rest-api-specs/blob/baseBranch/file1.md) |


        **[must fix]The following errors/warnings are intorduced by current PR:**

        | Rule | Message | Related RPC [For API reviewers] |
        | ---- | ------- | ------------------------------- |
        | :warning: [SomeCode](https://github.com/Azure/azure-openapi-validator/blob/main/docs/some-code.md) | Some Message<br />Location: [Azure.Contoso.WidgetManager/stable/2022-12-01/widgets.json#L1](https://github.com/Azure/azure-rest-api-specs/blob/compareSha/specification/contosowidgetmanager/data-plane/Azure.Contoso.WidgetManager/stable/2022-12-01/widgets.json#L1) |  |

        "
      `);
    },
  );
});

describe("generateAutoRestErrorReport", () => {
  beforeEach(() => {
    vol.reset();

    // Seed current filesystem so that "." exists.
    vol.mkdirSync(".", { recursive: true });
  });

  test("generates a report with errors", async () => {
    const autoRestErrors = [
      {
        result: {
          readme: "readme.md",
          tag: "tag1",
          rootPath: "dummy/rootPath",
          error: null,
          stdout: "dummy stdout",
          stderr: "dummy stderr",
        },
        errors: [
          { level: "error", message: "Error message 1" } as AutoRestMessage,
          { level: "fatal", message: "Fatal error message" } as AutoRestMessage,
        ],
      },
      {
        result: {
          readme: "readme2.md",
          tag: "tag2",
          rootPath: "dummy/rootPath",
          error: null,
          stdout: "dummy stdout",
          stderr: "dummy stderr",
        },
        errors: [
          { level: "error", message: "Error message 2" } as AutoRestMessage,
        ],
      },
    ];

    const outFile = "autorest-error-report.md";
    await generateAutoRestErrorReport(autoRestErrors, outFile);

    const actual = await readFile(outFile, { encoding: "utf-8" });
    expect(actual).toMatchInlineSnapshot(`
      "**AutoRest errors:**

      Readme: readme.md
      Tag: tag1
      Errors:
      | Level | Message |
      | ----- | ------- |
      | :x: error | Error message 1 |
      | :warning: fatal | Fatal error message |


      Readme: readme2.md
      Tag: tag2
      Errors:
      | Level | Message |
      | ----- | ------- |
      | :x: error | Error message 2 |


      "
    `);
  });
});