// @ts-check

import { relative, resolve } from "path";
import { describe, expect, it } from "vitest";
import { ConsoleLogger } from "../src/logger.js";
import { getInputFiles, Readme } from "../src/readme.js";
import { contosoReadme } from "./examples.js";

const options = { logger: new ConsoleLogger(/*debug*/ true) };

describe("readme", () => {
  it("can be created with mock path", async () => {
    const readme = new Readme("bar");
    expect(readme.path).toBe(resolve("bar"));

    await expect(readme.getTags()).rejects.toThrowError(
      /no such file or directory/i,
    );
  });

  it("getInputFiles", async () => {
    let inputFiles = await getInputFiles(contosoReadme);

    const expected = new Set([
      "Microsoft.Contoso/stable/2021-11-01/contoso.json",
      "Microsoft.Contoso/preview/2021-10-01-preview/contoso.json",
    ]);

    expect(inputFiles).toEqual(expected);

    const folder = "/fake";
    const readme = new Readme(resolve(folder, "readme.md"), {
      ...options,
      content: contosoReadme,
    });

    const tags = await readme.getTags();
    const swaggers = [...tags].flatMap((t) => [...t.inputFiles]);
    inputFiles = new Set(swaggers.map((s) => relative(folder, s.path)));

    expect(inputFiles).toEqual(expected);
  });
});
