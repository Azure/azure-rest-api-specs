// @ts-check

import { resolve } from "path";
import { describe, expect, it } from "vitest";
import { ConsoleLogger } from "../src/logger.js";
import { Readme } from "../src/readme.js";
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

  it("can be created with string content", async () => {
    const folder = "/fake";
    const readme = new Readme(resolve(folder, "readme.md"), {
      ...options,
      content: contosoReadme,
    });

    const tags = await readme.getTags();
    const tagNames = new Set([...tags].map((t) => t.name));
    const expectedTagNames = new Set([
      "package-2021-11-01",
      "package-2021-10-01-preview",
    ]);

    expect(tagNames).toEqual(expectedTagNames);

    const swaggers = [...tags].flatMap((t) => [...t.inputFiles]);
    const swaggerPaths = new Set(swaggers.map((s) => s.path));

    const expectedPaths = new Set([
      resolve(folder, "Microsoft.Contoso/stable/2021-11-01/contoso.json"),
      resolve(
        folder,
        "Microsoft.Contoso/preview/2021-10-01-preview/contoso.json",
      ),
    ]);

    expect(swaggerPaths).toEqual(expectedPaths);
  });

  it("can be created with empty content", async () => {
    const folder = "/fake";
    const readme = new Readme(resolve(folder, "readme.md"), {
      ...options,
      // Simulate empty file
      content: "",
    });

    const tags = await readme.getTags();

    // Ensures code doesn't try to read file `/fake/readme.md` which would throw
    expect(tags.size).toBe(0);
  });
});
