import { test, describe, expect } from "vitest";
import {
  iconFor,
  getLine,
  getFile,
  getDocUrl,
  getFileLink,
  getPathSegment,
  compareLintDiffViolations,
} from "../src/generateReport.js";

import { Source, LintDiffViolation } from "../src/types.js";

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
