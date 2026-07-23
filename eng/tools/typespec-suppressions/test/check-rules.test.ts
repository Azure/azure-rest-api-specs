import { mkdtemp, rm, writeFile } from "node:fs/promises";
import os from "node:os";
import path from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { loadCheckRulesFile } from "../src/check-rules.ts";

describe("loadCheckRulesFile", () => {
  const tempDirs: string[] = [];
  let warnSpy: ReturnType<typeof vi.spyOn>;

  beforeEach(() => {
    warnSpy = vi.spyOn(console, "warn").mockImplementation(() => {});
  });

  afterEach(async () => {
    warnSpy.mockRestore();
    await Promise.all(tempDirs.splice(0).map((dir) => rm(dir, { recursive: true, force: true })));
  });

  async function tempFile(name: string, content: string): Promise<string> {
    const dir = await mkdtemp(path.join(os.tmpdir(), "check-rules-"));
    tempDirs.push(dir);
    const filePath = path.join(dir, name);
    await writeFile(filePath, content);
    return filePath;
  }

  it("returns the rules array from a valid file", async () => {
    const filePath = await tempFile(
      "check-rules.json",
      JSON.stringify({ name: "x", rules: ["a/b", "c/d"] }),
    );
    expect(loadCheckRulesFile(filePath)).toEqual(["a/b", "c/d"]);
  });

  it("degrades to [] and warns when the file is missing", () => {
    expect(loadCheckRulesFile(path.join(os.tmpdir(), "does-not-exist-xyz.json"))).toEqual([]);
    expect(warnSpy).toHaveBeenCalledOnce();
  });

  it("degrades to [] and warns on invalid JSON", async () => {
    const filePath = await tempFile("check-rules.json", "{ not json");
    expect(loadCheckRulesFile(filePath)).toEqual([]);
    expect(warnSpy).toHaveBeenCalledOnce();
  });

  it("degrades to [] and warns when rules is missing or wrong type", async () => {
    const filePath = await tempFile("check-rules.json", JSON.stringify({ name: "x" }));
    expect(loadCheckRulesFile(filePath)).toEqual([]);
    expect(warnSpy).toHaveBeenCalledOnce();
  });

  it("degrades to [] and warns when rules contains non-strings", async () => {
    const filePath = await tempFile("check-rules.json", JSON.stringify({ rules: ["a/b", 123] }));
    expect(loadCheckRulesFile(filePath)).toEqual([]);
    expect(warnSpy).toHaveBeenCalledOnce();
  });

  it("returns an empty array (no warning) for an explicitly empty rules list", async () => {
    const filePath = await tempFile("check-rules.json", JSON.stringify({ rules: [] }));
    expect(loadCheckRulesFile(filePath)).toEqual([]);
    expect(warnSpy).not.toHaveBeenCalled();
  });
});
