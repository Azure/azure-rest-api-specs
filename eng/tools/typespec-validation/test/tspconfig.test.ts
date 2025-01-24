import { describe, it } from "vitest";
import { join } from "path";
import tspconfigRules from "../src/rules/tspconfig-validation-rules.js";
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

describe("tspconfig rules", () => {
  it.each([
    {
      rule: tspconfigRules.find((r) => r.name === "tspconfig-java-az-package-dir-match-pattern")!,
      folder: "aaa/bbb/",
      when: 'package-dir "azure-" is invalid',
      tspconfig: `
  options:
    "@azure-tools/typespec-java":
      package-dir: xxxxx
      flavor: azure
  `,
      expectedResult: false,
    },
    {
      rule: tspconfigRules.find((r) => r.name === "tspconfig-java-az-package-dir-match-pattern")!,
      folder: "aaa/aaa.Management/",
      when: 'package-dir "azure-" is invalid',
      tspconfig: `
  options:
    "@azure-tools/typespec-java":
      package-dir: azure-test
      flavor: azure
  `,
      expectedResult: true,
    },
  ])(`should be $expectedResult for new rule $rule.name when $when`, async (c: TestCase) => {
    let host = new TsvTestHost();
    host.checkFileExists = async (file: string) => {
      return file === join(TsvTestHost.folder, "tspconfig.yaml");
    };
    host.readTspConfig = async (_folder: string) => c.tspconfig;
    const result = await c.rule.execute(host, c.folder);
    strictEqual(result.success, true);
    assert(
      (c.expectedResult &&
        result.stdOutput &&
        result.stdOutput.length > 0 &&
        result.errorOutput === undefined) ||
        (!c.expectedResult &&
          result.stdOutput === undefined &&
          result.errorOutput &&
          result.errorOutput.length > 0),
    );
  });
});
