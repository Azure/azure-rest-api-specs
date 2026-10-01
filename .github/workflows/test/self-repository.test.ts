import { existsSync, globSync, readFileSync } from "node:fs";
import { resolve } from "node:path";
import { describe, expect, it } from "vitest";
import { isScalar, isSeq, parseDocument, visit } from "yaml";

const root = resolve(import.meta.dirname, "../../..");

describe("self-repository references", () => {
  it("resolves repository targets and retains only intentionally different checkouts", () => {
    const references: { file: string; uses: string }[] = [];
    for (const path of globSync(
      [".github/workflows/*.{yaml,yml}", ".github/actions/**/action.{yaml,yml}"],
      { cwd: root, exclude: (path) => path.endsWith(".lock.yml") },
    )) {
      const file = path.replaceAll("\\", "/");
      const document = parseDocument(readFileSync(resolve(root, path), "utf8"));
      expect(document.errors).toEqual([]);
      visit(document, {
        Pair(_, pair) {
          if (
            isScalar(pair.key) &&
            pair.key.value === "uses" &&
            isScalar(pair.value) &&
            typeof pair.value.value === "string"
          ) {
            references.push({ file, uses: pair.value.value });
          }
        },
      });
    }

    expect(references.filter(({ uses }) => uses.startsWith("./"))).toEqual(
      expect.arrayContaining([
        {
          file: ".github/workflows/summarize-impact.yaml",
          uses: "./after/.github/actions/setup-node-install-deps",
        },
        {
          file: ".github/workflows/typespec-validation-all.yaml",
          uses: "./.github/actions/setup-node-install-deps",
        },
      ]),
    );
    expect(references.filter(({ uses }) => uses.startsWith("./"))).toHaveLength(2);

    const selfReferences = references.filter(({ uses }) => uses.startsWith("$/"));
    expect(selfReferences.length).toBeGreaterThan(0);
    for (const { file, uses } of selfReferences) {
      expect(uses, file).toMatch(/^\$\/\.github\/(actions|workflows)\/[^@]+$/);
      const target = resolve(root, uses.slice(2));
      const candidates = uses.startsWith("$/.github/workflows/")
        ? [target]
        : [resolve(target, "action.yaml"), resolve(target, "action.yml")];
      expect(
        candidates.some((path) => existsSync(path)),
        `${file}: ${uses}`,
      ).toBe(true);
    }
  });

  it("ignores only unsupported syntax for known self-repository targets", () => {
    const configuration = parseDocument(
      readFileSync(resolve(root, ".github/actionlint.yaml"), "utf8"),
    );
    const ignores = configuration.getIn(["paths", ".github/workflows/*.{yaml,yml}", "ignore"]);
    if (!isSeq(ignores)) throw new Error("Expected self-repository compatibility patterns");
    const patterns = ignores.items.map((item) => {
      if (!isScalar(item) || typeof item.value !== "string") {
        throw new Error("Expected an ignore pattern");
      }
      return new RegExp(item.value);
    });
    const actionError = (reference: string) =>
      `specifying action "${reference}" in invalid format because ref is missing.`;
    const workflowError = (reference: string) =>
      `reusable workflow call "${reference}" at "uses" is not following the format "owner/repo/path/to/workflow.yml@ref"`;
    const ignored = (message: string) => patterns.some((pattern) => pattern.test(message));

    expect(ignored(actionError("$/.github/actions/setup-node-install-deps"))).toBe(true);
    expect(ignored(workflowError("$/.github/workflows/_reusable-set-check-status.yaml"))).toBe(
      true,
    );
    for (const message of [
      actionError("actions/checkout"),
      actionError("$/.github/actions/unknown-action"),
      actionError("$/.github/actions/setup-node-install-deps@main"),
      actionError("$/.github/actions/../setup-node-install-deps"),
      workflowError("$/.github/workflows/missing.yaml"),
      workflowError("$/.github/workflows/_reusable-set-check-status.yaml@main"),
      'undefined variable "unknown_context"',
      'input "unknown" is not defined in action "$/.github/actions/setup-node-install-deps"',
      'reusable workflow call "$/.github/workflows/_reusable-set-check-status.yaml" has an unknown input',
    ]) {
      expect(ignored(message), message).toBe(false);
    }
  });
});
