import { describe, expect, it, vi } from "vitest";
import { createMockCore } from "../../test/mocks.js";
import { getChangedFiles } from "../src/changed-files.js";
import * as git from "../src/git.js";

describe("changedFiles", () => {
  it("getChangedFiles", async () => {
    const files = [
      ".github/workflows/src/git.js",
      "specification/contosowidgetmanager/Contoso.Management/main.tsp",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json",
      "specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/examples/Employees_Get.json",
    ];

    vi.spyOn(git, "diff").mockResolvedValue(files.join("\n"));

    await expect(getChangedFiles(createMockCore())).resolves.toEqual(files);
  });
});
