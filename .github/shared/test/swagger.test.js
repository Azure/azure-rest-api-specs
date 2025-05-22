// @ts-check

import { resolve } from "path";
import { describe, expect, it } from "vitest";
import { Swagger, isResolverError } from "../src/swagger.js";
import { ResolverError } from "@apidevtools/json-schema-ref-parser";

describe("Swagger", () => {
  it("can be created with mock path", async () => {
    const swagger = new Swagger("bar");
    expect(swagger.path).toBe(resolve("bar"));

    await expect(swagger.getRefs()).rejects.toThrowError(
      /no such file or directory/i,
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

  it("returns false if input is not an error"),
    () => {
      expect(isResolverError(123)).toBe(false);
    };
});
