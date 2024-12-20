import { join, resolve } from "path";
import { describe, expect, it } from "vitest";
import { createESLint } from "./utils/e2e.js";

const specsFolder = resolve(__filename, "../../../../../specification");

describe("e2e-realfs", () => {
  it("contosowidgetmanager/Contso.WidgetManager", async () => {
    const eslint = createESLint();
    const filePath = join(specsFolder, "contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml");
    const results = await eslint.lintFiles(filePath);

    expect(results).toHaveLength(1);
    expect(results[0].filePath).toBe(filePath);
    expect(results[0].messages).toHaveLength(0);
  });
});
