// @ts-check

import { describe, expect, it } from "vitest";

import { resolve } from "path";
import { Swagger } from "../src/swagger.js";
import { Tag } from "../src/tag.js";

describe("Tag", () => {
  it("can be created with mock swaggers", async () => {
    const inputSwagger = new Swagger("swagger");
    const inputFiles = new Map([[inputSwagger.path, inputSwagger]]);

    const tag = new Tag("tag", inputFiles);

    expect(tag.name).toBe("tag");
    expect(tag.readme).toBeUndefined();

    expect(tag.inputFiles.size).toBe(1);
    const swagger = [...tag.inputFiles.values()][0];
    expect(swagger.path).toBe(resolve("swagger"));

    await expect(swagger.getRefs()).rejects.toThrowError(
      /Failed to resolve file for swagger/i,
    );
  });
});
