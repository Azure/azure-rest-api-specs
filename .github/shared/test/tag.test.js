// @ts-check

import { describe, expect, it } from "vitest";

import { resolve } from "path";
import { Swagger } from "../src/swagger.js";
import { Tag } from "../src/tag.js";

describe("Tag", () => {
  it("can be created with mock swaggers", async () => {
    const tag = new Tag("tag", new Set([new Swagger("swagger")]));
    expect(tag.name).toBe("tag");
    expect(tag.inputFiles.size).toBe(1);

    const swagger = [...tag.inputFiles][0];
    expect(swagger.path).toBe(resolve("swagger"));

    await expect(swagger.getRefs()).rejects.toThrowError(
      /no such file or directory/i,
    );
  });
});
