// @ts-check

import { resolve } from "path";
import { describe, expect, it } from "vitest";
import { Swagger } from "../src/swagger.js";

describe("Swagger", () => {
  it("can be created with mock path", async () => {
    const swagger = new Swagger("bar");
    expect(swagger.path).toBe(resolve("bar"));

    await expect(swagger.getRefs()).rejects.toThrowError(
      /no such file or directory/i,
    );
  });
});
