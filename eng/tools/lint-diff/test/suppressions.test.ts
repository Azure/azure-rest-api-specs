import { resolve } from "node:path";
import { describe, expect, it } from "vitest";
import { getUnsuppressedSwaggers } from "../src/lint-diff.ts";

const ROOT = resolve(__dirname, "fixtures", "suppressions");

describe("Swagger suppressions", () => {
  it("skips every file matched by directory and SwaggerAll suppressions", async () => {
    const affectedSwaggers = new Set([
      "specification/contoso/stable/one.json",
      "specification/contoso/stable/two.json",
      "specification/contoso/preview/three.json",
      "specification/contoso/other/four.json",
    ]);

    await expect(getUnsuppressedSwaggers(ROOT, affectedSwaggers)).resolves.toEqual(
      new Set(["specification/contoso/other/four.json"]),
    );
  });
});
