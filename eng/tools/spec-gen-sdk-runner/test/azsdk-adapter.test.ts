import { describe, expect, test } from "vitest";
import {
  AzsdkBuildResponse,
  AzsdkGenerateResponse,
  AzsdkPackResponse,
  buildExecutionReport,
  parseAzsdkResponse,
} from "../src/azsdk-adapter.js";
import { EmitterCheckResult } from "../src/emitter-check.js";

describe("parseAzsdkResponse", () => {
  test("parses JSON from clean output", () => {
    const output = '{"result":"succeeded","package_name":"test-pkg"}';
    const result = parseAzsdkResponse<{ result: string; package_name: string }>(output);
    expect(result.result).toBe("succeeded");
    expect(result.package_name).toBe("test-pkg");
  });

  test("parses JSON with log lines before it", () => {
    const output = [
      "Some log line",
      "Another log line",
      "{",
      '  "result": "succeeded",',
      '  "package_name": "test-pkg"',
      "}",
    ].join("\n");
    const result = parseAzsdkResponse<{ result: string; package_name: string }>(output);
    expect(result.result).toBe("succeeded");
    expect(result.package_name).toBe("test-pkg");
  });

  test("parses JSON when log lines contain braces", () => {
    const output = [
      "Log line with { brace",
      "Another } log line",
      "{",
      '  "result": "failed",',
      '  "message": "error with {braces} inside"',
      "}",
    ].join("\n");
    const result = parseAzsdkResponse<{ result: string; message: string }>(output);
    expect(result.result).toBe("failed");
    expect(result.message).toBe("error with {braces} inside");
  });

  test("throws SyntaxError when no JSON found", () => {
    const output = "just some log lines\nno json here";
    expect(() => parseAzsdkResponse(output)).toThrow(SyntaxError);
    expect(() => parseAzsdkResponse(output)).toThrow("No JSON object found");
  });

  test("throws on invalid JSON", () => {
    const output = "log line\n{invalid json}";
    expect(() => parseAzsdkResponse(output)).toThrow();
  });

  test("parses nested JSON objects", () => {
    const output = [
      "log line",
      "{",
      '  "result": "succeeded",',
      '  "nested": { "key": "value" }',
      "}",
    ].join("\n");
    const result = parseAzsdkResponse<{ result: string; nested: { key: string } }>(output);
    expect(result.result).toBe("succeeded");
    expect(result.nested.key).toBe("value");
  });
});

describe("buildExecutionReport", () => {
  const enabledEmitter: EmitterCheckResult = {
    enabled: true,
    packageName: "test-package",
    languageKey: "rust",
  };

  const disabledEmitter: EmitterCheckResult = {
    enabled: false,
  };

  const succeededGenerate: AzsdkGenerateResponse = {
    result: "succeeded",
    package_name: "test-package",
    language: "Rust",
    version: "0.1.0",
    package_type: "client",
    typespec_project: "specification/test",
    sdk_repo: "azure-sdk-for-rust",
    operation_status: "Succeeded",
  };

  const failedGenerate: AzsdkGenerateResponse = {
    result: "failed",
    package_name: "test-package",
    language: "Rust",
    version: "0.1.0",
    package_type: "client",
    typespec_project: "specification/test",
    sdk_repo: "azure-sdk-for-rust",
    operation_status: "Failed",
    response_error: "Generation error",
  };

  const succeededBuild: AzsdkBuildResponse = {
    result: "succeeded",
    package_name: "test-package",
    language: "Rust",
  };

  const failedBuild: AzsdkBuildResponse = {
    result: "failed",
    package_name: "test-package",
    language: "Rust",
    response_error: "Build error",
  };

  const succeededPack: AzsdkPackResponse = {
    result: "succeeded",
    message: "Pack completed successfully. Artifact: /tmp/artifacts/test-package-0.1.0.crate",
    package_name: "test-package",
    language: "Rust",
    version: "0.1.0",
    package_type: "client",
  };

  const failedPack: AzsdkPackResponse = {
    result: "failed",
    package_name: "test-package",
    language: "Rust",
    version: "0.1.0",
    package_type: "client",
    response_error: "Pack error",
  };

  test("returns notEnabled when emitter is disabled", () => {
    const report = buildExecutionReport(undefined, undefined, disabledEmitter);
    expect(report.executionResult).toBe("notEnabled");
    expect(report.packages).toHaveLength(0);
    expect(report.generateFromTypeSpec).toBe(true);
  });

  test("returns succeeded when all steps succeed", () => {
    const report = buildExecutionReport(
      succeededGenerate,
      succeededPack,
      enabledEmitter,
      succeededBuild,
    );
    expect(report.executionResult).toBe("succeeded");
    expect(report.packages).toHaveLength(1);
    expect(report.packages[0].packageName).toBe("test-package");
    expect(report.generateFromTypeSpec).toBe(true);
  });

  test("returns failed when generate fails", () => {
    const report = buildExecutionReport(failedGenerate, undefined, enabledEmitter);
    expect(report.executionResult).toBe("failed");
  });

  test("returns failed when generate response is undefined", () => {
    const report = buildExecutionReport(undefined, undefined, enabledEmitter);
    expect(report.executionResult).toBe("failed");
  });

  test("returns failed when build fails", () => {
    const report = buildExecutionReport(succeededGenerate, undefined, enabledEmitter, failedBuild);
    expect(report.executionResult).toBe("failed");
  });

  test("returns failed when pack fails", () => {
    const report = buildExecutionReport(
      succeededGenerate,
      failedPack,
      enabledEmitter,
      succeededBuild,
    );
    expect(report.executionResult).toBe("failed");
  });

  test("returns succeeded when build is skipped (Python)", () => {
    const report = buildExecutionReport(succeededGenerate, succeededPack, enabledEmitter);
    expect(report.executionResult).toBe("succeeded");
  });

  test("stagedArtifactsFolder is undefined (deferred) even with pack response", () => {
    const report = buildExecutionReport(
      succeededGenerate,
      succeededPack,
      enabledEmitter,
      succeededBuild,
    );
    expect(report.stagedArtifactsFolder).toBeUndefined();
  });

  test("stagedArtifactsFolder is undefined when no pack response", () => {
    const report = buildExecutionReport(
      succeededGenerate,
      undefined,
      enabledEmitter,
      succeededBuild,
    );
    expect(report.stagedArtifactsFolder).toBeUndefined();
  });

  test("stagedArtifactsFolder is undefined when pack has no artifact message", () => {
    const packNoMessage: AzsdkPackResponse = {
      result: "succeeded",
      package_name: "test-package",
      language: "Rust",
      version: "0.1.0",
      package_type: "client",
    };
    const report = buildExecutionReport(
      succeededGenerate,
      packNoMessage,
      enabledEmitter,
      succeededBuild,
    );
    expect(report.stagedArtifactsFolder).toBeUndefined();
  });

  test("uses emitter packageName over generate package_name", () => {
    const emitter: EmitterCheckResult = {
      enabled: true,
      packageName: "emitter-package-name",
      languageKey: "rust",
    };
    const report = buildExecutionReport(succeededGenerate, undefined, emitter);
    expect(report.packages[0].packageName).toBe("emitter-package-name");
  });

  test("falls back to generate package_name when emitter packageName is undefined", () => {
    const emitter: EmitterCheckResult = {
      enabled: true,
      languageKey: "rust",
    };
    const report = buildExecutionReport(succeededGenerate, undefined, emitter);
    expect(report.packages[0].packageName).toBe("test-package");
  });
});
