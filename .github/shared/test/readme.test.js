// @ts-check

import { resolve } from "path";
import { describe, expect, it } from "vitest";
import { getInputFiles, Readme } from "../src/readme.js";
import { contosoReadme } from "./examples.js";

describe("readme", () => {
  it("can be created with mock path", async () => {
    const readme = new Readme("bar");
    expect(readme.path).toBe(resolve("bar"));

    await expect(readme.getTags()).rejects.toThrowError(
      /no such file or directory/i,
    );
  });

  it("getInputFiles", async () => {
    await expect(getInputFiles(contosoReadme)).resolves.toEqual(
      new Set([
        "Microsoft.Contoso/stable/2021-11-01/contoso.json",
        "Microsoft.Contoso/preview/2021-10-01-preview/contoso.json",
      ]),
    );
  });
});
