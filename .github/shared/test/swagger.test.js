// @ts-check

import { dirname, resolve } from "path";
import { describe, expect, it } from "vitest";
import { Swagger } from "../src/swagger.js";

import { fileURLToPath } from "url";
import { Readme } from "../src/readme.js";
import { Tag } from "../src/tag.js";
const __dirname = dirname(fileURLToPath(import.meta.url));

describe("Swagger", () => {
  it("can be created with mock path", async () => {
    const swagger = new Swagger("bar");
    expect(swagger.path).toBe(resolve("bar"));
    expect(swagger.tag).toBeUndefined();

    await expect(swagger.getRefs()).rejects.toThrowError(
      /Failed to resolve file for swagger/i,
    );
  });

  it("resolves path against Tag.readme", async () => {
    const readme = new Readme("/specs/foo/readme.md");
    const tag = new Tag("2025-01-01", [], { readme });
    const swagger = new Swagger("test.json", { tag });

    expect(swagger.path).toBe(resolve("/specs/foo/test.json"));
  });

  // TODO: Test that path is resolved against backpointer

  it("excludes example files", async () => {
    const swagger = new Swagger(
      resolve(__dirname, "fixtures/Swagger/ignoreExamples/swagger.json"),
    );
    const refs = await swagger.getRefs();

    const expectedIncludedPath = resolve(
      __dirname,
      "fixtures/Swagger/ignoreExamples/included.json",
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
});
