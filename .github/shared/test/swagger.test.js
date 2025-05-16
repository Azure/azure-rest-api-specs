// @ts-check

import { resolve } from "path";
import { describe, expect, it } from "vitest";
import { Swagger } from "../src/swagger.js";

const __dirname = resolve(new URL(".", import.meta.url).pathname);

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
    const swagger = new Swagger(
      resolve(__dirname, "fixtures/Swagger/ignoreExamples/swagger.json"),
    );
    const refs = await swagger.getRefs();

    expect(refs).toMatchObject(
      new Set([
        expect.objectContaining({
          path: expect.stringContaining("test/fixtures/Swagger/ignoreExamples/included.json"),
        }),
        expect.objectContaining({
          path: expect.stringContaining(
            "test/fixtures/Swagger/ignoreExamples/examples/example.json",
          ),
        }),
      ]),
    );
  });

  it("excludes example files when ignoreExamples is set", async () => {
    const swagger = new Swagger(
      resolve(__dirname, "fixtures/Swagger/ignoreExamples/swagger.json"),
      { ignoreSwaggerExamples: true },
    );
    const refs = await swagger.getRefs();

    expect(refs).toMatchObject(
      new Set([
        expect.objectContaining({
          path: expect.stringContaining("test/fixtures/Swagger/ignoreExamples/included.json"),
        }),
      ]),
    );
  });
});
