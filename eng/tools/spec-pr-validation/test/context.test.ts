import { defaultLogger } from "@azure-tools/specs-shared/logger";
import { join } from "pathe";
import { describe, expect, it } from "vitest";
import { createContext } from "../src/context.ts";
import { createRepo } from "./repo.ts";

describe("comparison context", () => {
  it("resolves the root from a subdirectory and rejects invalid commit references", async () => {
    const { root } = await createRepo({ "specification/foo/Project/tspconfig.yaml": "{}" }, {});
    const context = await createContext(
      join(root, "specification/foo"),
      "HEAD^",
      "HEAD",
      defaultLogger,
    );
    expect(context.root).toBe(root);
    expect(context.baseCommitish).toMatch(/^[a-f0-9]{40}$/);
    expect(context.headCommitish).toMatch(/^[a-f0-9]{40}$/);
    await expect(createContext(root, "missing-ref", "HEAD", defaultLogger)).rejects.toThrow();
    await expect(createContext(root, "HEAD^", "--help", defaultLogger)).rejects.toThrow();
  });
});
