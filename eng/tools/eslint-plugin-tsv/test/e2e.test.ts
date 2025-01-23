import { ESLint } from "eslint";
import { join, resolve } from "path";
import { describe, expect, it } from "vitest";
import eslintPluginTsv from "../src/eslint-plugin-tsv.js";

function createESLint() {
  return new ESLint({
    cwd: join(__dirname, "../../../../"),
    overrideConfig: eslintPluginTsv.configs.recommended,
    overrideConfigFile: true,
  });
}

describe("lint-text", () => {
  it("Not-Kebab-Case/Not.KebabCase", async () => {
    const filePath = "/specification/Not-Kebab-Case/Not.KebabCase/tspconfig.yaml";
    const eslint = createESLint();

    const results = await eslint.lintText("", { filePath: filePath });

    expect(results).toHaveLength(1);
    expect(results[0].filePath).toBe(filePath);
    expect(results[0].messages[0].ruleId).toBe("tsv/kebab-case-org");
    expect(results[0].messages[0].messageId).toBe("kebab");
  });

  it("Not-Kebab-Case-Disabled/Not.KebabCase", async () => {
    const filePath = "/specification/Not-Kebab-Case-Disabled/Not.KebabCase/tspconfig.yaml";
    const eslint = createESLint();

    const results = await eslint.lintText(
      "# eslint-disable tsv/kebab-case-org, tsv/emit-autorest\n",
      {
        filePath: filePath,
      },
    );

    expect(results).toHaveLength(1);
    expect(results[0].filePath).toBe(filePath);
    expect(results[0].messages).toHaveLength(0);
  });
});

describe("lint-files", () => {
  const specsFolder = resolve(__filename, "../../../../../specification");

  it("contosowidgetmanager/Contso.WidgetManager", async () => {
    const eslint = createESLint();
    const filePath = join(specsFolder, "contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml");
    const results = await eslint.lintFiles(filePath);

    expect(results).toHaveLength(1);
    expect(results[0].filePath).toBe(filePath);
    expect(results[0].messages).toHaveLength(0);
  });

  it("contosowidgetmanager/Contso.Management", async () => {
    const eslint = createESLint();
    const filePath = join(specsFolder, "contosowidgetmanager/Contoso.Management/tspconfig.yaml");
    const results = await eslint.lintFiles(filePath);

    expect(results).toHaveLength(1);
    expect(results[0].filePath).toBe(filePath);
    expect(results[0].messages).toHaveLength(0);
  });
});
