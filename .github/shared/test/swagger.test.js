// @ts-check

import { dirname, resolve } from "path";
import { describe, expect, it } from "vitest";
import { Swagger } from "../src/swagger.js";

import { fileURLToPath } from "url";
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
