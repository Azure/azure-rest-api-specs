import { test, describe } from "vitest";
import { join } from "node:path";

import {
  getSwaggerDependenciesMap,
  getAffectedSwaggers,
  getAffectedServices,
  getLintDiffViolations,
  AutorestRunResult,
  arrayIsEqual,
} from "../src/util.js";

// TODO: Temporary workaround until we have a common set of entities
import { MarkdownType } from "../src/markdown-utils.js";

describe("getSwaggerDependenciesMap", () => {
  test.concurrent("empty set on no .json files", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/empty",
    );

    expect(dependencyMap.size).toEqual(0);
  });

  test.concurrent("d has no dependencies", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    expect(dependencyMap.has("specification/1/d.json")).toEqual(true);
    expect(dependencyMap.get("specification/1/d.json")).toEqual(new Set<string>());
  });

  test.concurrent("a depends on b and c (and d transitively)", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    expect(dependencyMap.has("specification/1/a.json")).toEqual(true);
    expect(dependencyMap.get("specification/1/a.json")).toEqual(
      new Set<string>([
        "specification/1/nesting/b.json",
        "specification/1/c.json",
        // d.json is a dependency of a.json through b.json
        "specification/1/d.json",
      ]),
    );
  });

  test.concurrent("b depends on c and d", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    expect(dependencyMap.has("specification/1/nesting/b.json")).toEqual(true);
    expect(dependencyMap.get("specification/1/nesting/b.json")).toEqual(
      new Set<string>(["specification/1/c.json", "specification/1/d.json"]),
    );
  });
});

describe("getAffectedSwaggers", () => {
  test.concurrent("a affects only a", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    const affectedSwaggers = getAffectedSwaggers(["specification/1/a.json"], dependencyMap);

    expect(affectedSwaggers).toEqual(["specification/1/a.json"]);
  });

  test.concurrent("b affects a and b", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    const affectedSwaggers = getAffectedSwaggers(["specification/1/nesting/b.json"], dependencyMap);

    expect(affectedSwaggers).toEqual(["specification/1/nesting/b.json", "specification/1/a.json"]);
  });

  test.concurrent("c affects a, b, c", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    const affectedSwaggers = getAffectedSwaggers(["specification/1/c.json"], dependencyMap);

    expect(affectedSwaggers).toEqual([
      "specification/1/c.json",
      "specification/1/a.json",
      "specification/1/nesting/b.json",
    ]);
  });

  test.concurrent("d affects a, b, d", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    const affectedSwaggers = getAffectedSwaggers(["specification/1/d.json"], dependencyMap);

    expect(affectedSwaggers).toEqual([
      "specification/1/d.json",
      "specification/1/a.json",
      "specification/1/nesting/b.json",
    ]);
  });

  test.concurrent("d, c affects a, b, c, d", async ({ expect }) => {
    const __dirname = new URL(".", import.meta.url).pathname;
    const dependencyMap = await getSwaggerDependenciesMap(
      join(__dirname, "fixtures/getSwaggerDependenciesMap"),
      "specification/1",
    );

    const affectedSwaggers = getAffectedSwaggers(
      ["specification/1/d.json", "specification/1/c.json"],
      dependencyMap,
    );

    expect(affectedSwaggers).toEqual([
      "specification/1/d.json",
      "specification/1/c.json",
      "specification/1/a.json",
      "specification/1/nesting/b.json",
    ]);
  });
});

describe("getAffectedServices", () => {
  test.concurrent("returns single service with multiple files", async ({ expect }) => {
    const changedFiles = ["specification/service1/file1.json", "specification/service1/file2.json"];
    const affectedServices = await getAffectedServices(changedFiles);

    expect(affectedServices).toEqual(new Set<string>(["specification/service1"]));
  });

  test.concurrent("returns multiple services", async ({ expect }) => {
    const changedFiles = [
      "specification/service1/file1.json",
      "specification/service1/file2.json",
      "specification/service2/file1.json",
    ];
    const affectedServices = await getAffectedServices(changedFiles);

    expect(affectedServices).toEqual(
      new Set<string>(["specification/service1", "specification/service2"]),
    );
  });
});

describe("getLintDiffViolations", async () => {
  function createRunResult(
    stdout: string,
    stderr: string = "",
    openApiType: MarkdownType = "arm",
  ): AutorestRunResult {
    return {
      autorestCommand: "string",
      rootPath: "string",
      readme: "string",
      tag: "string",
      openApiType: openApiType,
      error: null,
      stdout: stdout,
      stderr: stderr,
    };
  }

  test.concurrent("returns an empty array on no interesting violations", async ({ expect }) => {
    const runResult =
      createRunResult(`{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"spectralPluginFunc: Validating OpenAPI spec. TypeSpec-generated: true. Path: 'file:///home/djurek/azure-rest-api-specs/specification/codesigning/resource-manager/Microsoft.CodeSigning/stable/2025-03-30/codeSigningAccount.json'"}
{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"openapiValidatorPluginFunc: Return"}`);

    const violations = await getLintDiffViolations(runResult);
    expect(violations).toEqual([]);
  });

  test.concurrent("returns an error on an interesting violation", async ({ expect }) => {
    const runResult =
      createRunResult(`{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"spectralPluginFunc: Validating OpenAPI spec. TypeSpec-generated: true. Path: 'file:///home/djurek/azure-rest-api-specs/specification/codesigning/resource-manager/Microsoft.CodeSigning/stable/2025-03-30/codeSigningAccount.json'"}
{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"error","message":"Top level property names should not be repeated inside the properties bag for ARM resource 'CodeSigningAccount'. Properties [properties.sku] conflict with ARM top level properties. Please rename these.","code":"ArmResourcePropertiesBag","details":{"jsonpath":["definitions","CodeSigningAccount"],"validationCategory":"ARMViolation","providerNamespace":false,"resourceType":false,"range":{"start":{"line":1036,"column":27},"end":{"line":1051,"column":6}}},"source":[{"document":"file:///home/djurek/azure-rest-api-specs/specification/codesigning/resource-manager/Microsoft.CodeSigning/stable/2025-03-30/codeSigningAccount.json","position":{"line":1036,"column":5}}]}
{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"openapiValidatorPluginFunc: Return"}`);

    const violations = await getLintDiffViolations(runResult);
    expect(violations.length).toEqual(1);
    expect(violations[0].level).toEqual("error");
    expect(violations[0].code).toEqual("ArmResourcePropertiesBag");
  });

  test.concurrent(
    "returns an empty array on violations that don't have extensionname @microsoft.azure/openapi-validator",
    async ({ expect }) => {
      const runResult =
        createRunResult(`{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"spectralPluginFunc: Validating OpenAPI spec. TypeSpec-generated: true. Path: 'file:///home/djurek/azure-rest-api-specs/specification/codesigning/resource-manager/Microsoft.CodeSigning/stable/2025-03-30/codeSigningAccount.json'"}
{"pluginName":"spectral","extensionName":"THIS IS FILTERED OUT","level":"error","message":"Top level property names should not be repeated inside the properties bag for ARM resource 'CodeSigningAccount'. Properties [properties.sku] conflict with ARM top level properties. Please rename these.","code":"ArmResourcePropertiesBag","details":{"jsonpath":["definitions","CodeSigningAccount"],"validationCategory":"ARMViolation","providerNamespace":false,"resourceType":false,"range":{"start":{"line":1036,"column":27},"end":{"line":1051,"column":6}}},"source":[{"document":"file:///home/djurek/azure-rest-api-specs/specification/codesigning/resource-manager/Microsoft.CodeSigning/stable/2025-03-30/codeSigningAccount.json","position":{"line":1036,"column":5}}]}
{"pluginName":"spectral","extensionName":"@microsoft.azure/openapi-validator","level":"information","message":"openapiValidatorPluginFunc: Return"}`);

      const violations = await getLintDiffViolations(runResult);
      expect(violations).toEqual([]);
    },
  );
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
