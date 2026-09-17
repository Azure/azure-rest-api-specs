import { execFile } from "node:child_process";
import { mkdtemp, readFile, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { promisify } from "node:util";
import { describe, expect, it } from "vitest";
import { isExecError } from "../../shared/src/exec.ts";

async function runCommand(command: string, payload: object) {
  const directory = await mkdtemp(join(tmpdir(), "workflow-command-"));
  const event = join(directory, "event.json");
  const output = join(directory, "output");
  try {
    await writeFile(event, JSON.stringify(payload));
    await writeFile(output, "");
    let code: number | string | null | undefined = 0;
    let stdout = "";
    let stderr = "";
    try {
      ({ stdout, stderr } = await promisify(execFile)(
        process.execPath,
        [join(import.meta.dirname, "..", "cmd", command)],
        {
          cwd: directory,
          env: {
            ...process.env,
            GITHUB_TOKEN: "",
            GITHUB_EVENT_NAME: "pull_request",
            GITHUB_REPOSITORY: "owner/repo",
            GITHUB_EVENT_PATH: event,
            GITHUB_OUTPUT: output,
          },
        },
      ));
    } catch (error) {
      if (!isExecError(error)) throw error;
      code = error.code;
      stdout = error.stdout ?? "";
      stderr = error.stderr ?? "";
    }
    return { code, stdout, stderr, output: await readFile(output, "utf8") };
  } finally {
    await rm(directory, { recursive: true, force: true });
  }
}

function readOutput(content: string, name: string) {
  const lines = content.split(/\r?\n/);
  const index = lines.findIndex((line) => line.startsWith(`${name}<<`));
  if (index === -1) return undefined;
  const delimiter = lines[index].slice(name.length + 2);
  const end = lines.indexOf(delimiter, index + 1);
  if (end === -1) throw new Error(`Unterminated output ${name}`);
  return lines.slice(index + 1, end).join("\n");
}

describe("native workflow commands", () => {
  it("runs a context-only command without a token and writes real Actions outputs", async () => {
    const names = ["first", 'quoted "label"', "line\nbreak"];
    const result = await runCommand("sdk-suppressions-context.ts", {
      pull_request: { labels: names.map((name) => ({ name })) },
    });
    expect(result.code).toBe(0);
    expect(readOutput(result.output, "prLabels")).toBe(JSON.stringify(names));
    expect(readOutput(result.output, "result")).toBe("undefined");
  });

  it("fails with an annotation and no result when required context is absent", async () => {
    const result = await runCommand("sdk-suppressions-context.ts", {});
    expect(result.code).toBe(1);
    expect(result.stdout).toContain("::error::");
    expect(result.stderr).toContain("context of a pull request");
    expect(result.output).toBe("");
  });

  it("fails an API command without a token before making a request", async () => {
    const result = await runCommand("update-labels.ts", {});
    expect(result.code).toBe(1);
    expect(result.stdout).toContain("::error::");
    expect(result.stderr).toContain("GITHUB_TOKEN must be set");
    expect(result.output).toBe("");
  });
});
