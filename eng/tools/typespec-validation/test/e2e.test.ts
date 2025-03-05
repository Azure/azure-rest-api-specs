import { vi, expect, describe, it, afterEach, beforeEach } from "vitest";
import { dirname, resolve } from "path";
import { main } from "../src/index.js";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

describe("TypeSpec Validation with suppression file", async function () {
  let originalArgv: string[];

  beforeEach(() => {
    originalArgv = process.argv;
  });

  afterEach(() => {
    process.argv = originalArgv;
  });

  it("should suppress the whole tool", async function () {
    let lines: string[] = [];
    const logSpy = vi.spyOn(console, "log").mockImplementation((...args: any[]) => {
      const line = args.join("") + "\n";
      lines.push(line);
    });
    process.argv = ["", "", resolve(__dirname, "e2e/suppressTool/")];
    await main();
    logSpy.mockRestore();
    lines = lines.filter((line) => line === "  Suppressed: suppress TypeSpecValidation tool\n");
    expect(lines.length).toBe(1);
  });

  it("should suppress rules", async function () {
    let lines: string[] = [];
    const logSpy = vi.spyOn(console, "log").mockImplementation((...args: any[]) => {
      const line = args.join("") + "\n";
      lines.push(line);
    });
    process.argv = ["", "", resolve(__dirname, "e2e/suppressRules/")];
    await main();
    logSpy.mockRestore();
    lines = lines.filter((line) => line.startsWith("\nExecuting rule: "));
    expect(lines.length).toBe(1);
    expect(lines[0]).toBe("\nExecuting rule: FolderStructure\n");
  });

  it("should suppress sub rules", async function () {
    let lines: string[] = [];
    const logSpy = vi.spyOn(console, "log").mockImplementation((...args: any[]) => {
      const line = args.join("") + "\n";
      lines.push(line);
    });
    process.argv = ["", "", resolve(__dirname, "e2e/suppressSubRules/")];
    await main();
    logSpy.mockRestore();
    lines = lines.filter((line) => line.includes("parameters.service-dir.default"));
    expect(lines.length).toBe(0);
  });
});
