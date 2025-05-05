// @ts-check

import { dirname, relative, resolve } from "path";
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

    const readme = Readme.fromContent(contosoReadme, options);

    inputFiles = new Set(
      [...(await readme.getAllInputFiles())].map((p) =>
        relative(dirname(readme.path), p),
      ),
    );

    expect(inputFiles).toEqual(expected);
  });
});
