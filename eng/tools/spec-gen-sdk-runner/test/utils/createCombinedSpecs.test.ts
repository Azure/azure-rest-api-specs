import path from "node:path";
import { describe, expect, test } from "vitest";
import { createCombinedSpecs, type SpecResults } from "../../src/utils.js";

describe("createCombinedSpecs", () => {
  test("combines specs from readme and typespec paths", () => {
    const results: SpecResults = {
      readmeMDResult: {
        "specification/apicenter/data-plane": ["data.json", "api.json"],
      },
      typespecProjectResult: {
        "specification/apicenter/ApiCenter.DataApi": ["client.tsp", "main.tsp"],
        "specification/apicenter/ApiCenter.Management": ["main.tsp"],
      },
    };

    const readmePath = "specification/apicenter/data-plane";
    const typespecPaths = [
      "specification/apicenter/ApiCenter.DataApi",
      "specification/apicenter/ApiCenter.Management",
    ];

    const result = createCombinedSpecs(readmePath, typespecPaths, results);

    expect(result).toHaveLength(2);
    expect(result[0].specs).toContain("data.json");
    expect(result[0].specs).toContain("api.json");
    expect(result[0].specs).toContain("main.tsp");
    expect(result[0].specs).toContain("client.tsp");
    expect(result[0].readmeMd).toBe(path.normalize("specification/apicenter/data-plane/readme.md"));
    expect(result[0].typespecProject).toBe(
      path.normalize("specification/apicenter/ApiCenter.DataApi/tspconfig.yaml"),
    );
  });

  test("handles missing specs gracefully", () => {
    const results: SpecResults = {
      readmeMDResult: {},
      typespecProjectResult: {},
    };

    const result = createCombinedSpecs("path/to/readme", ["path/to/typespec"], results);

    expect(result).toHaveLength(1);
    expect(result[0].specs).toHaveLength(0);
  });
});
