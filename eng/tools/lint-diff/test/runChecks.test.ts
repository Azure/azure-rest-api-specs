import { beforeEach, describe, expect, Mock, test, vi } from "vitest";

vi.mock(import("@azure-tools/specs-shared/exec"), async (importOriginal) => {
  const actual = await importOriginal();
  return {
    ...actual,
    execNpmExec: vi.fn(),
  };
});

vi.mock(import("../src/util.js"), async (importOriginal) => {
  const actual = await importOriginal();
  return {
    ...actual,
    getPathToDependency: vi.fn(),
  };
});

vi.mock(import("../src/markdown-utils.js"), async (importOriginal) => {
  const actual = await importOriginal();
  return {
    ...actual,
    getOpenapiType: vi.fn(),
  };
});

import { execNpmExec } from "@azure-tools/specs-shared/exec";
import { Readme } from "@azure-tools/specs-shared/readme";
import { AutorestRunResult, ReadmeAffectedTags } from "../src/lintdiff-types.js";
import { getAutorestErrors, runChecks } from "../src/runChecks.js";

describe("runChecks", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  test("sets outputs properly on tag", async () => {
    (execNpmExec as Mock).mockResolvedValue({ stdout: "out", stderr: "err" });
    const runList = new Map<string, ReadmeAffectedTags>([
      ["readme.md", { readme: new Readme(""), changedTags: new Set<string>(["tag1"]) }],
    ]);

    const actual = await runChecks("root", runList);
    expect(actual).toHaveLength(1);
    expect(actual[0].error).toBeNull();
    expect(actual[0].stdout).toBe("out");
    expect(actual[0].stderr).toBe("err");

    expect(execNpmExec).toHaveBeenCalledWith(
      expect.arrayContaining([expect.stringContaining("--tag=tag1")]),
      expect.anything(),
    );
  });

  test("coalesces null tag when no tags specified", async () => {
    (execNpmExec as Mock).mockResolvedValue({ stdout: "", stderr: "" });
    const runList = new Map<string, ReadmeAffectedTags>([
      ["readme.md", { readme: new Readme(""), changedTags: new Set<string>() }],
    ]);

    const actual = await runChecks("root", runList);
    expect(actual).toHaveLength(1);
    expect(execNpmExec).toHaveBeenCalledWith(
      expect.not.arrayContaining([expect.stringContaining("--tag")]),
      expect.anything(),
    );
  });

  test("error path populates error, stdout, stderr", async () => {
    // Consturct an error object that will return true when passed to isExecError
    const err = new Error();
    (err as any).stdout = "s";
    (err as any).stderr = "e";
    (err as any).code = 1;

    (execNpmExec as Mock).mockRejectedValue(err);
    const runList = new Map<string, ReadmeAffectedTags>([
      ["readme.md", { readme: new Readme(""), changedTags: new Set<string>(["tag1", "tag2"]) }],
    ]);

    const actual = await runChecks("root", runList);
    expect(actual).toHaveLength(2);
    actual.forEach((r) => {
      expect(r.error).toBe(err);
      expect(r.stdout).toBe("s");
      expect(r.stderr).toBe("e");
    });
  });

  test("error path throws an error that isn't an ExecError", async () => {
    (execNpmExec as Mock).mockRejectedValue({
      message: "some error for which isExecError returns false",
    });
    const runList = new Map<string, ReadmeAffectedTags>([
      ["readme.md", { readme: new Readme(""), changedTags: new Set<string>(["tag1", "tag2"]) }],
    ]);
    expect(runChecks("root", runList)).rejects.toThrow();
  });
});

describe("getAutorestErrors", () => {
  test("filters only error and fatal levels", () => {
    const lines = `{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"warning","message":"Use the latest version v6 of types.json.","code":"LatestVersionOfCommonTypesMustBeUsed","details":{"jsonpath":["definitions","SettingsResourceUpdate","allOf","0","$ref"],"validationCategory":"","providerNamespace":false,"resourceType":false,"rpcGuidelineCode":"","range":{"start":{"line":444,"column":18},"end":{"line":444,"column":111}}},"source":[{"document":"file:///mnt/vss/_work/1/azure-rest-api-specs-pr/specification/portalservices/resource-manager/Microsoft.PortalServices/settings/preview/2025-04-01-preview/settings.json","position":{"line":444,"column":11}}]}
{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"spectralPluginFunc: Return"}
{"level":"fatal","message":"Process() cancelled due to failure "}
{"level":"error","message":"!Error: There are multiple operations defined for \\n  'get: /providers/Microsoft.PortalServices/operations'.\\n\\n  You are probably trying to use an input with multiple API versions with an autorest V2 generator, and that will not work. "}
{"level":"error","message":"stack: Error: There are multiple operations defined for \\n  'get: /providers/Microsoft.PortalServices/operations'.\\n\\n  You are probably trying to use an input with multiple API versions with an autorest V2 generator, and that will not work. \\n    at NewComposer.visitPath (/home/cloudtest/.autorest/@autorest_core@3.10.4/node_modules/@autorest/core/dist/src_lib_autorest-core_ts.js:4371:23)\\n    at NewComposer.visitPaths (/home/cloudtest/.autorest/@autorest_core@3.10.4/node_modules/@autorest/core/dist/src_lib_autorest-core_ts.js:4357:22)\\n    at NewComposer.process (/home/cloudtest/.autorest/@autorest_core@3.10.4/node_modules/@autorest/core/dist/src_lib_autorest-core_ts.js:4305:26)\\n    at NewComposer.runProcess (/home/cloudtest/.autorest/@autorest_core@3.10.4/node_modules/@autorest/core/dist/src_lib_autorest-core_ts.js:16339:28)\\n    at NewComposer.getOutput (/home/cloudtest/.autorest/@autorest_core@3.10.4/node_modules/@autorest/core/dist/src_lib_autorest-core_ts.js:16259:9)\\n    at compose (/home/cloudtest/.autorest/@autorest_core@3.10.4/node_modules/@autorest/core/dist/src_lib_autorest-core_ts.js:4624:56)\\n    at ScheduleNode (/home/cloudtest/.autorest/@autorest_core@3.10.4/node_modules/@autorest/core/dist/src_lib_autorest-core_ts.js:1351:29)"}
{"level":"error","message":"Autorest completed with an error. If you think the error message is unclear, or is a bug, please declare an issues at https://github.com/Azure/autorest/issues with the error message you are seeing."}`;

    const runResult = { stdout: lines, stderr: "" } as any;

    const errors = getAutorestErrors(runResult);
    expect(errors).toEqual(
      expect.arrayContaining([
        expect.objectContaining({ level: "fatal", message: "Process() cancelled due to failure " }),
        expect.objectContaining({ level: "error" }),
      ]),
    );

    expect(errors).not.toEqual(
      expect.arrayContaining([expect.objectContaining({ level: "information" })]),
    );
    expect(errors).not.toEqual(
      expect.arrayContaining([expect.objectContaining({ level: "warning" })]),
    );
  });

  test("returns empty when none", () => {
    expect(getAutorestErrors({ stdout: "", stderr: "" } as AutorestRunResult)).toEqual([]);
  });
});
