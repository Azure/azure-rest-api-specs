import { describe, it } from "vitest";
import { join } from "path";
import { TspConfigJavaPackageDirectoryRule } from "../src/rules/tspconfig-java-package-dir.js";
import { TsvTestHost } from "./tsv-test-host.js";
import { strict as assert, strictEqual } from "node:assert";
import { Rule } from "../src/rule.js";

interface TestCase {
  tspconfig: string;
  expectedResult: boolean;
  rule: Rule;
  when: string;
  folder: string;
}

const testCases: TestCase[] = [
  {
    rule: new TspConfigJavaPackageDirectoryRule(),
    folder: TsvTestHost.folder,
    when: "package-dir \"azure-abc\" is valid",
    tspconfig: `
options:
  "@azure-tools/typespec-java":
    package-dir: azure-abc
`,
    expectedResult: true,
  },
  {
    rule: new TspConfigJavaPackageDirectoryRule(),
    folder: TsvTestHost.folder,
    when: "tspconfig.yaml is not a valid yaml",
    tspconfig: `aaa`,
    expectedResult: false,
  },
  {
    rule: new TspConfigJavaPackageDirectoryRule(),
    folder: TsvTestHost.folder,
    when: "java emitter has no options",
    tspconfig: `
options:
  "@azure-tools/typespec-ts":
    package-dir: com.azure.test
`,
    expectedResult: false,
  },
  {
    rule: new TspConfigJavaPackageDirectoryRule(),
    folder: TsvTestHost.folder,
    when: "java emitter options have no package-dir",
    tspconfig: `
options:
  "@azure-tools/typespec-java":
    x: com.azure.test
`,
    expectedResult: false,
  },
  {
    rule: new TspConfigJavaPackageDirectoryRule(),
    folder: TsvTestHost.folder,
    when: "package-dir \"azure.test\" is invalid",
    tspconfig: `
options:
  "@azure-tools/typespec-java":
    package-dir: azure.test
`,
    expectedResult: false,
  },
  {
    rule: new TspConfigJavaPackageDirectoryRule(),
    folder: TsvTestHost.folder,
    when: "package-dir \"azure-\" is invalid",
    tspconfig: `
options:
  "@azure-tools/typespec-java":
    package-dir: azure-
`,
    expectedResult: false,
  },
];

describe("tspconfig", function () {
  it.each(testCases)(
    `should be $expectedResult for rule $rule.name when $when`,
    async (c: TestCase) => {
      let host = new TsvTestHost();
      host.checkFileExists = async (file: string) => {
        return file === join(TsvTestHost.folder, "tspconfig.yaml");
      };
      host.readTspConfig = async (_folder: string) => c.tspconfig;
      const result = await c.rule.execute(host, TsvTestHost.folder);
      strictEqual(result.success, c.expectedResult);
      if (!c.expectedResult) {
        // TODO: assert link when ready
        assert(result.errorOutput?.includes(c.rule.name));
        assert(result.errorOutput?.includes(c.rule.description));
        assert(result.errorOutput?.includes(c.rule.action!));
      }
    },
  );
});
