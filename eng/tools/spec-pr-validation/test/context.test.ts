import { defaultLogger } from "@azure-tools/specs-shared/logger";
import { join } from "pathe";
import { describe, expect, it } from "vitest";
import { createContext, findChangedProjects, readFileAtCommit } from "../src/context.ts";
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

  it("distinguishes missing files from Git failures", async () => {
    const path = "specification/foo/service.yaml";
    const { root } = await createRepo(
      { [path]: "versions: []\n" },
      { [path]: "versions:\n  - version: new\n" },
    );
    const context = await createContext(root, "HEAD^", "HEAD", defaultLogger);
    await expect(readFileAtCommit(context, context.baseCommitish, path)).resolves.toBe(
      "versions: []\n",
    );
    await expect(
      readFileAtCommit(context, context.headCommitish, "specification/foo/missing.yaml"),
    ).resolves.toBeUndefined();
    await expect(readFileAtCommit(context, "bad-revision", path)).rejects.toThrow();
  });

  it("includes surviving projects from both rename areas, siblings, and nested projects", async () => {
    const moved = "specification/foo/data-plane/Foo/stable/2026-01-01/openapi.json";
    const { root } = await createRepo(
      {
        [moved]: '{"swagger":"2.0"}',
        "specification/foo/Sibling/tspconfig.yaml": "{}",
        "specification/foo/Sibling/Nested/tspconfig.yaml": "{}",
        "specification/bar/Other/tspconfig.yaml": "{}",
        "specification/deleted/Old/tspconfig.yaml": "{}",
      },
      {
        [moved]: null,
        "specification/bar/data-plane/Bar/stable/2026-01-01/openapi.json": '{"swagger":"2.0"}',
        "specification/deleted/Old/tspconfig.yaml": null,
      },
    );
    const context = await createContext(root, "HEAD^", "HEAD", defaultLogger);
    expect(context.changes.renames).toHaveLength(1);
    expect(await findChangedProjects(context)).toEqual(
      [
        join(root, "specification/bar/Other"),
        join(root, "specification/foo/Sibling"),
        join(root, "specification/foo/Sibling/Nested"),
      ].map((path) => path.replaceAll("\\", "/")),
    );
  });
});
