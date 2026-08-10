import { Readme } from "@azure-tools/specs-shared/readme";
import { resolve } from "node:path";
import { describe, expect, it } from "vitest";
import { filterBeforeRunList, filterRunList, getUnsuppressedSwaggers } from "../src/lint-diff.ts";

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

  it("prunes fully suppressed tags and retains mixed tags", async () => {
    const readmePath = "specification/contoso/readme.md";
    const readme = new Readme(resolve(ROOT, readmePath));
    const runList = new Map([
      [
        readmePath,
        {
          readme,
          changedTags: new Set(["stable", "preview", "mixed"]),
        },
      ],
    ]);

    const result = await filterRunList(
      ROOT,
      runList,
      new Set([
        "specification/contoso/stable/one.json",
        "specification/contoso/stable/two.json",
        "specification/contoso/preview/three.json",
        "specification/contoso/other/four.json",
      ]),
      new Set(["specification/contoso/other/four.json"]),
    );

    expect(result.get(readmePath)?.changedTags).toEqual(new Set(["mixed"]));
  });

  it("retains README-only tags and all baselines for retained readmes", async () => {
    const readmePath = "specification/contoso/readme.md";
    const readme = new Readme(resolve(ROOT, readmePath));
    const runList = new Map([
      [
        readmePath,
        {
          readme,
          changedTags: new Set(["stable", "preview"]),
        },
      ],
    ]);

    const afterList = await filterRunList(
      ROOT,
      runList,
      new Set(["specification/contoso/stable/one.json"]),
      new Set<string>(),
    );
    expect(afterList.get(readmePath)?.changedTags).toEqual(new Set(["preview"]));

    const beforeList = filterBeforeRunList(runList, afterList);
    expect(beforeList.get(readmePath)?.changedTags).toEqual(new Set(["stable", "preview"]));
  });
});
