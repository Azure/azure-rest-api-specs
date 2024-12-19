import { ESLint } from "eslint";
import { describe, expect, it } from "vitest";

// TODO: Convert e2e tests to vitest

describe("e2e", () => {
  it("/dev/null", async () => {
    const eslint = new ESLint();
    const results = await eslint.lintFiles("/dev/null");
    expect(results).toHaveLength(0);
  });
});
