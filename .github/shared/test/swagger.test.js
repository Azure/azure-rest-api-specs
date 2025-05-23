// @ts-check

import { dirname, resolve } from "path";
import { describe, expect, it } from "vitest";
import { Swagger, isResolverError } from "../src/swagger.js";
import { ResolverError } from "@apidevtools/json-schema-ref-parser";

import { fileURLToPath } from "url";
const __dirname = dirname(fileURLToPath(import.meta.url));

describe("Swagger", () => {
  it("can be created with mock path", async () => {
    const swagger = new Swagger("bar");
    expect(swagger.path).toBe(resolve("bar"));

    await expect(swagger.getRefs()).rejects.toThrowError(/Failed to resolve file/i);
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

describe("isResolverError", () => {
  it("returns true for resolver errors with ioErrorCode", () => {
    const resolverError = new ResolverError(new Error("Test error"));
    resolverError.ioErrorCode = "ENOENT";
    expect(isResolverError(resolverError)).toBe(true);
  });

  it("returns false for non-resolver errors", () => {
    const error = new Error("Test error");
    expect(isResolverError(error)).toBe(false);
  });

  it("returns false if input is not an error", () => {
    expect(isResolverError("test")).toBe(false);
  });
});
