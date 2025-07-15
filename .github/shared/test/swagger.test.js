// @ts-check

import { dirname, resolve, join } from "path";
import { describe, expect, it } from "vitest";
import { Swagger } from "../src/swagger.js";

import { fileURLToPath } from "url";
import { Readme } from "../src/readme.js";
import { Tag } from "../src/tag.js";
import { SpecModel } from "../src/spec-model.js";
import { ConsoleLogger } from "../src/logger.js";

const __dirname = dirname(fileURLToPath(import.meta.url));

describe("Swagger", () => {
  it("can be created with mock path", async () => {
    const swagger = new Swagger("bar");
    expect(swagger.path).toBe(resolve("bar"));
    expect(swagger.tag).toBeUndefined();

    await expect(swagger.getRefs()).rejects.toThrowError(/Failed to resolve file for swagger/i);
  });

  it("resolves path against Tag.readme", async () => {
    const readme = new Readme("/specs/foo/readme.md");
    const tag = new Tag("2025-01-01", [], { readme });
    const swagger = new Swagger("test.json", { tag });

    expect(swagger.path).toBe(resolve("/specs/foo/test.json"));
  });

  // TODO: Test that path is resolved against backpointer

  it("excludes example files", async () => {
    const swagger = new Swagger(resolve(__dirname, "fixtures/swagger/ignoreExamples/swagger.json"));
    const refs = await swagger.getRefs();

    const expectedIncludedPath = resolve(
      __dirname,
      "fixtures/swagger/ignoreExamples/included.json",
    );
    expect(refs).toMatchObject(
      new Map([
        [
          expectedIncludedPath,
          expect.objectContaining({
            path: expect.stringContaining(expectedIncludedPath),
          }),
        ],
      ]),
    );
  });

  describe("getOperations", () => {
    it("should return normal operations", async () => {
      const testFixturePath = join(__dirname, "fixtures", "swagger", "specification");
      const targetPath = join(
        testFixturePath,
        "servicelinker/resource-manager/Microsoft.ServiceLinker/stable/2024-04-01/test.json",
      );
      const specModel = new SpecModel(testFixturePath, {
        logger: new ConsoleLogger(/*debug*/ true),
      });
      const result = await specModel.getSwaggers();
      const swagger = result.find((s) => s.path === targetPath);

      if (!swagger) throw new Error("Swagger not found for the given path");
      const operationsMap = await swagger.getOperations();
      expect(operationsMap.size).toBe(3);

      let expectedApiPath =
        "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.ServiceLinker/locations/{location}/dryruns/{dryrunName}";

      // Test specific operations by ID
      const createDryrun = operationsMap.get("Connector_CreateDryrun");
      const getDryrun = operationsMap.get("Connector_GetDryrun");
      const listDryruns = operationsMap.get("Connector_ListDryrun");

      expect(createDryrun).toBeDefined();
      if (createDryrun) {
        expect(createDryrun.id).toBe("Connector_CreateDryrun");
        expect(createDryrun.httpMethod).toBe("PUT");
        expect(createDryrun.path).toBe(expectedApiPath);
      }

      expect(getDryrun).toBeDefined();
      if (getDryrun) {
        expect(getDryrun.id).toBe("Connector_GetDryrun");
        expect(getDryrun.httpMethod).toBe("GET");
        expect(getDryrun.path).toBe(expectedApiPath);
      }

      expectedApiPath =
        "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.ServiceLinker/locations/{location}/dryruns";
      expect(listDryruns).toBeDefined();
      if (listDryruns) {
        expect(listDryruns.id).toBe("Connector_ListDryrun");
        expect(listDryruns.httpMethod).toBe("GET");
        expect(listDryruns.path).toBe(expectedApiPath);
      }
    });
  });
});
