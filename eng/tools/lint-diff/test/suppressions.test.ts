import { resolve } from "node:path";
import { describe, expect, it } from "vitest";
import { getRunList } from "../src/processChanges.ts";
import { getUnsuppressedSwaggers } from "../src/swagger-suppressions.ts";

const ROOT = resolve(__dirname, "fixtures", "suppressions");
const BEFORE_ROOT = resolve(__dirname, "fixtures", "suppressions-before");

describe("Swagger suppressions", () => {
  it("skips every file matched by directory and SwaggerAll suppressions", async () => {
    const affectedSwaggers = new Set([
      "specification/contoso/stable/one.json",
      "specification/contoso/stable/two.json",
      "specification/contoso/preview/three.json",
      "specification/contoso/other/four.json",
    ]);

    await expect(getUnsuppressedSwaggers(ROOT, ROOT, affectedSwaggers)).resolves.toEqual(
      new Set(["specification/contoso/other/four.json"]),
    );
  });

  it("filters suppressed changed swaggers before building the spec model", async () => {
    await expect(
      getRunList(BEFORE_ROOT, ROOT, resolve(ROOT, "changed-files.txt")),
    ).resolves.toEqual([new Map(), new Map(), new Set()]);
  });
});
