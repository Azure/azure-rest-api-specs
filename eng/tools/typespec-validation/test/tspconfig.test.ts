import { describe, it } from "vitest";
import { join } from "path";
import { TspConfigJavaNamespaceRule } from "../src/rules/tspconfig-java-namepace.js";
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
    rule: new TspConfigJavaNamespaceRule(),
    folder: TsvTestHost.folder,
    when: "namespace is valid",
    tspconfig: `
options:
  "@azure-tools/typespec-java":
    namespace: com.azure.test
`,
    expectedResult: true,
  },
  {
    rule: new TspConfigJavaNamespaceRule(),
    folder: TsvTestHost.folder,
    when: "tspconfig.yaml is not a valid yaml",
    tspconfig: `aaa`,
    expectedResult: false,
  },
  {
    rule: new TspConfigJavaNamespaceRule(),
    folder: TsvTestHost.folder,
    when: "java emitter has no options",
    tspconfig: `
options:
  "@azure-tools/typespec-ts":
    namespace: com.azure.test
`,
    expectedResult: false,
  },
  {
    rule: new TspConfigJavaNamespaceRule(),
    folder: TsvTestHost.folder,
    when: "java emitter options have no namespace",
    tspconfig: `
options:
  "@azure-tools/typespec-java":
    x: com.azure.test
`,
    expectedResult: false,
  },
  {
    rule: new TspConfigJavaNamespaceRule(),
    folder: TsvTestHost.folder,
    when: "namespace is invalid",
    tspconfig: `
options:
  "@azure-tools/typespec-java":
    namespace: x.com.azure.test
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
