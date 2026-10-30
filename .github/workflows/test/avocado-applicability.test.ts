import { execFileSync } from "node:child_process";
import { mkdtemp, mkdir, rename, rm, writeFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { afterEach, beforeEach, describe, expect, it } from "vitest";
import { checkAvocadoApplicability } from "../src/avocado-applicability.ts";
import { createMockContext, createMockCore } from "./mocks.ts";

describe("Avocado applicability", () => {
  let directory: string;
  let base: string;

  function git(...args: string[]) {
    return execFileSync("git", args, { cwd: directory, encoding: "utf8" }).trim();
  }

  async function write(path: string, content = "content") {
    await mkdir(dirname(join(directory, path)), { recursive: true });
    await writeFile(join(directory, path), content);
  }

  function commit() {
    git("add", ".");
    git("-c", "user.name=Test", "-c", "user.email=test@example.com", "commit", "-qm", "test");
    return git("rev-parse", "HEAD");
  }

  function setup(head = commit()) {
    const context = createMockContext();
    context.eventName = "pull_request";
    context.payload = { pull_request: { number: 1, base: { sha: base }, head: { sha: head } } };
    const core = createMockCore();
    return {
      context,
      core,
      run: () => checkAvocadoApplicability({ context, core, cwd: directory }),
    };
  }

  beforeEach(async () => {
    directory = await mkdtemp(join(process.cwd(), ".avocado-applicability-"));
    git("init", "-q");
    await write(".github/skills/example/SKILL.md");
    await write("service.json");
    base = commit();
  });

  afterEach(async () => {
    await rm(directory, { recursive: true, force: true });
  });

  it.each(["add", "modify", "delete", "rename"])(
    "skips dependency installation and analysis for a skill-only %s",
    async (change) => {
      const path = ".github/skills/example/SKILL.md";
      if (change === "add") await write(".github/skills/new/with spaces.md");
      if (change === "modify") await write(path, "updated");
      if (change === "delete") await rm(join(directory, path));
      if (change === "rename") {
        await rename(join(directory, path), join(directory, ".github/skills/example/renamed.md"));
      }
      const { core, run } = setup();
      await run();
      expect(core.setOutput).toHaveBeenCalledWith("run-avocado", false);
      expect(core.summary.addRaw).toHaveBeenCalledWith(
        expect.stringContaining("Avocado is not applicable"),
      );
      expect(core.summary.write).toHaveBeenCalledOnce();
    },
  );

  it.each(["service.json", ".github/skills-other/SKILL.md", ".github/workflows/test.yaml"])(
    "runs normally for a mixed PR changing %s",
    async (path) => {
      await write(".github/skills/example/SKILL.md", "updated");
      await write(path, "updated");
      const { core, run } = setup();
      await run();
      expect(core.setOutput).toHaveBeenCalledWith("run-avocado", true);
      expect(core.summary.write).not.toHaveBeenCalled();
    },
  );

  it.each(["into", "out of"])("runs for a rename %s skills", async (direction) => {
    const skill = join(directory, ".github/skills/example/SKILL.md");
    const service = join(directory, "service.json");
    if (direction === "into") {
      await rename(service, join(directory, ".github/skills/example/service.json"));
    } else {
      await rename(skill, join(directory, "renamed.md"));
    }
    const { core, run } = setup();
    await run();
    expect(core.setOutput).toHaveBeenCalledWith("run-avocado", true);
  });

  it("runs for a mixed PR deleting a non-skill file", async () => {
    await write(".github/skills/example/SKILL.md", "updated");
    await rm(join(directory, "service.json"));
    const { core, run } = setup();
    await run();
    expect(core.setOutput).toHaveBeenCalledWith("run-avocado", true);
  });

  it("checks all PR commits rather than just the last commit", async () => {
    await write("service.json", "updated");
    commit();
    await write(".github/skills/example/SKILL.md", "updated");
    const { core, run } = setup();
    await run();
    expect(core.setOutput).toHaveBeenCalledWith("run-avocado", true);
  });

  it("ignores changes made only on the base branch after divergence", async () => {
    await write(".github/skills/example/SKILL.md", "updated");
    const head = commit();
    git("checkout", "-q", "--detach", base);
    await write("service.json", "base-only");
    base = commit();
    const { core, run } = setup(head);
    await run();
    expect(core.setOutput).toHaveBeenCalledWith("run-avocado", false);
  });

  it("does not skip an empty diff", async () => {
    const { core, run } = setup(base);
    await run();
    expect(core.setOutput).toHaveBeenCalledWith("run-avocado", true);
  });

  it("fails explicitly if git cannot resolve the PR commits", async () => {
    const { core, run } = setup("f".repeat(40));
    await expect(run()).rejects.toThrow();
    expect(core.setOutput).not.toHaveBeenCalled();
    expect(core.summary.write).not.toHaveBeenCalled();
  });

  it.each(["", "--help", undefined])("rejects a missing or invalid SHA: %s", async (sha) => {
    const { context, core, run } = setup(base);
    context.payload = { pull_request: { number: 1, base: { sha }, head: { sha: base } } };
    await expect(run()).rejects.toThrow("requires valid pull request base and head SHAs");
    expect(core.setOutput).not.toHaveBeenCalled();
  });

  it("rejects non-PR events", async () => {
    const { context, core, run } = setup(base);
    context.eventName = "push";
    await expect(run()).rejects.toThrow("requires a pull_request event");
    expect(core.setOutput).not.toHaveBeenCalled();
  });

  it("rejects missing PR metadata", async () => {
    const { context, core, run } = setup(base);
    context.payload = {};
    await expect(run()).rejects.toThrow("requires valid pull request base and head SHAs");
    expect(core.setOutput).not.toHaveBeenCalled();
  });

  it("does not publish a skip decision if writing the explanation fails", async () => {
    await write(".github/skills/example/SKILL.md", "updated");
    const { core, run } = setup();
    core.summary.write.mockRejectedValueOnce(new Error("Cannot write summary"));
    await expect(run()).rejects.toThrow("Cannot write summary");
    expect(core.setOutput).not.toHaveBeenCalled();
  });
});
