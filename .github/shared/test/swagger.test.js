// @ts-check

import { dirname, join, resolve } from "path";
import { describe, expect, it } from "vitest";
import { Swagger } from "../src/swagger.js";

import { fileURLToPath } from "url";
const __dirname = dirname(fileURLToPath(import.meta.url));

describe("Swagger", () => {
  it("can be created with mock path", async () => {
    const swagger = new Swagger("bar");
    expect(swagger.path).toBe(resolve("bar"));

    await expect(swagger.getRefs()).rejects.toThrowError(
      /no such file or directory/i,
    );
  });
});

describe("Ignore examples", () => {
  it("includes example files by default", async () => {
    const swaggerFile = join(
      __dirname,
      "fixtures/Swagger/ignoreExamples/swagger.json",
    );
    const swagger = new Swagger(swaggerFile);

    const refs = await swagger.getRefs();

    const expectedIncludedPath = resolve(
      __dirname,
      "fixtures/Swagger/ignoreExamples/included.json",
    );
    const expectedExamplePath = resolve(
      __dirname,
      "fixtures/Swagger/ignoreExamples/examples/example.json",
    );

    expect(refs).toMatchObject(
      new Map([
        [
          expectedIncludedPath,
          expect.objectContaining({
            path: expect.stringContaining(expectedIncludedPath),
          }),
        ],
        [
          expectedExamplePath,
          expect.objectContaining({
            path: expect.stringContaining(expectedExamplePath),
          }),
        ],
      ]),
    );
  });

  it("excludes example files when ignoreExamples is set", async () => {
    const swagger = new Swagger(
      resolve(__dirname, "fixtures/Swagger/ignoreExamples/swagger.json"),
      { ignoreSwaggerExamples: true },
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
