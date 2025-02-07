import { describe, it } from "vitest";

import { Rule } from "../src/rule.js";
import { TspConfigCommonAzServiceDirMatchPatternRule } from "../src/rules/tspconfig-common-az-service-dir-match-pattern.js";
import { TspConfigJavaAzPackageDirectoryRule } from "../src/rules/tspconfig-az-java-package-dir-match-pattern.js";
import { TsvTestHost } from "./tsv-test-host.js";
import { join } from "path";
import { strictEqual } from "node:assert";

interface TestCase {
  tspconfig: string;
  actualExpectedResult: boolean;
  skip: boolean;
  rule: Rule;
  when: string;
  folder: string;
}

const testCases: TestCase[] = [
  {
    rule: new TspConfigJavaAzPackageDirectoryRule(),
    folder: TsvTestHost.folder,
    when: 'package-dir "azure-abc" is valid',
    tspconfig: `
options:
  "@azure-tools/typespec-java":
    package-dir: azure-abc
`,
    actualExpectedResult: true,
    skip: false,
  },
  {
    rule: new TspConfigJavaAzPackageDirectoryRule(),
    folder: TsvTestHost.folder,
    when: "tspconfig.yaml is not a valid yaml",
    tspconfig: `aaa`,
    actualExpectedResult: false,
    skip: false,
  },
  {
    rule: new TspConfigJavaAzPackageDirectoryRule(),
    folder: TsvTestHost.folder,
    when: "java emitter has no options",
    tspconfig: `
options:
  "@azure-tools/typespec-ts":
    package-dir: com.azure.test
`,
    actualExpectedResult: false,
    skip: false,
  },
  {
    rule: new TspConfigJavaAzPackageDirectoryRule(),
    folder: TsvTestHost.folder,
    when: "java emitter options have no package-dir",
    tspconfig: `
options:
  "@azure-tools/typespec-java":
    x: com.azure.test
`,
    actualExpectedResult: false,
    skip: false,
  },
  {
    rule: new TspConfigJavaAzPackageDirectoryRule(),
    folder: TsvTestHost.folder,
    when: 'package-dir "azure.test" is invalid',
    tspconfig: `
options:
  "@azure-tools/typespec-java":
    package-dir: azure.test
`,
    actualExpectedResult: false,
    skip: false,
  },
  {
    rule: new TspConfigJavaAzPackageDirectoryRule(),
    folder: TsvTestHost.folder,
    when: 'package-dir "azure-" is invalid',
    tspconfig: `
options:
  "@azure-tools/typespec-java":
    package-dir: azure-
`,
    actualExpectedResult: false,
    skip: false,
  },
  {
    rule: new TspConfigCommonAzServiceDirMatchPatternRule(),
    folder: TsvTestHost.folder,
    when: 'service-dir "sdk/abc" is valid',
    tspconfig: `
parameters:
  "service-dir":
    default: sdk/abc
`,
    actualExpectedResult: true,
    skip: false,
  },
  {
    rule: new TspConfigCommonAzServiceDirMatchPatternRule(),
    folder: TsvTestHost.folder,
    when: "tspconfig.yaml is not a valid yaml",
    tspconfig: `aaa`,
    actualExpectedResult: false,
    skip: false,
  },
  {
    rule: new TspConfigCommonAzServiceDirMatchPatternRule(),
    folder: TsvTestHost.folder,
    when: "tspconfig has no parameter service-dir",
    tspconfig: `
parameters:
  x:
    default: sdk/abc
`,
    actualExpectedResult: false,
    skip: false,
  },
  {
    rule: new TspConfigCommonAzServiceDirMatchPatternRule(),
    folder: TsvTestHost.folder,
    when: "tspconfig has no parameters",
    tspconfig: `
`,
    actualExpectedResult: false,
    skip: false,
  },
  {
    rule: new TspConfigCommonAzServiceDirMatchPatternRule(),
    folder: TsvTestHost.folder,
    when: "service-dir is not a string",
    tspconfig: `
parameters:
  "service-dir":
    default: true
`,
    actualExpectedResult: false,
    skip: false,
  },
  {
    rule: new TspConfigCommonAzServiceDirMatchPatternRule(),
    folder: TsvTestHost.folder,
    when: 'service-dir "sdk/abc/" is invalid',
    tspconfig: `
parameters:
  "service-dir":
    default: sdk/abc/
`,
    actualExpectedResult: false,
    skip: false,
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
      strictEqual(result.success, true);
      if (c.actualExpectedResult) {
        if (c.skip) strictEqual(result.stdOutput?.includes("Nothing to validate."), true);
        else strictEqual(result.stdOutput?.includes("validation passed."), true);
      }
    },
  );
});
