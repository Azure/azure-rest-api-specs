import {
  mkdtempSync,
  mkdirSync,
  readdirSync,
  readFileSync,
  rmSync,
  writeFileSync,
  existsSync,
} from "node:fs";
import { tmpdir } from "node:os";
import path from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import type { CopilotClient } from "@github/copilot-sdk";

type SessionOptions = NonNullable<Parameters<CopilotClient["createSession"]>[0]>;
interface MockSession {
  sendAndWait(request: { prompt: string }, timeout: number): Promise<{ data: { content: string } }>;
  disconnect(): Promise<void>;
}

const mocks = vi.hoisted(() => ({
  command: vi.fn<(command: string, args: string[]) => string>(),
  start: vi.fn<() => Promise<void>>(),
  auth: vi.fn<() => Promise<{ isAuthenticated: boolean }>>(),
  createSession: vi.fn<(config?: SessionOptions) => Promise<MockSession>>(),
  send: vi.fn<MockSession["sendAndWait"]>(),
  disconnect: vi.fn<MockSession["disconnect"]>(),
  stop: vi.fn<() => Promise<Error[]>>(),
  extract: vi.fn<(outputDir: string, overwrite: boolean) => void>(),
}));

vi.mock("@github/copilot-sdk", () => ({
  CopilotClient: class {
    start = mocks.start;
    getAuthStatus = mocks.auth;
    createSession = mocks.createSession;
    stop = mocks.stop;
  },
}));

vi.mock("adm-zip", () => ({
  default: class {
    extractAllTo = mocks.extract;
  },
}));

vi.mock("node:child_process", async () => {
  const { EventEmitter } = await import("node:events");
  const { PassThrough } = await import("node:stream");
  return {
    spawn(command: string, args: string[]) {
      const child = Object.assign(new EventEmitter(), {
        stdout: new PassThrough(),
        stderr: new PassThrough(),
      });
      queueMicrotask(() => {
        try {
          child.stdout.end(mocks.command(command, args));
          child.emit("close", 0);
        } catch (error) {
          child.stderr.end(String(error));
          child.emit("close", 1);
        }
      });
      return child;
    },
  };
});

import { main, parseArgs, runPipeline } from "./doc-refinement.ts";

const SHA = "a".repeat(40);
const REPOSITORY = "https://github.com/Azure/azure-rest-api-specs.git";
const SUITES = ["versioning", "armtemplate", "lro", "decorators", "warning", "dataplane"];
const fetchMock = vi.fn<typeof fetch>();
const stdoutMock = vi.fn<(data: string | Uint8Array) => boolean>(() => true);
let temporaryDir: string;
let resultsDir: string;

function defaultCommand(command: string, args: string[]): string {
  if (command === "az") {
    return JSON.stringify({ accessToken: "test-token", expires_on: Date.now() / 1000 + 3600 });
  }
  if (command === "gh") return "12345";
  if (command === "git" && args[0] === "status") return "";
  if (command === "git" && args[0] === "remote") {
    if (args.at(-1) === "upstream") throw new Error("No upstream remote");
    return REPOSITORY;
  }
  if (command === "git" && args[0] === "ls-remote") return `${SHA}\t${args.at(-1)}`;
  if (command === "git" && args[0] === "branch") return "test-refinement";
  if (command === "git" && args[0] === "rev-parse") return SHA;
  throw new Error(`Unexpected command: ${command} ${args.join(" ")}`);
}

function requestUrl(input: string | URL | Request): string {
  return typeof input === "string" ? input : input instanceof URL ? input.href : input.url;
}

function defaultFetch(input: string | URL | Request, init?: RequestInit): Promise<Response> {
  const url = requestUrl(input);
  if (init?.method === "POST") {
    return Promise.resolve(
      Response.json({ id: 42, _links: { web: { href: "https://example.test/build/42" } } }),
    );
  }
  if (url.includes("/builds/42?")) {
    return Promise.resolve(Response.json({ status: "completed", result: "succeeded" }));
  }
  if (url.includes("/artifacts?")) {
    return Promise.resolve(
      Response.json({
        value: [
          {
            name: "eval-results-code-quality-42",
            resource: { downloadUrl: "https://artifacts.example.test/42.zip" },
          },
        ],
      }),
    );
  }
  if (url === "https://artifacts.example.test/42.zip") {
    return Promise.resolve(new Response(new Uint8Array([80, 75])));
  }
  throw new Error(`Unexpected request: ${url}`);
}

function writeResults(outputDir: string, suites = SUITES): void {
  for (const suite of suites) {
    const dir = path.join(outputDir, suite);
    mkdirSync(dir, { recursive: true });
    writeFileSync(
      path.join(dir, "results.jsonl"),
      JSON.stringify({ type: "trial-result", trajectory: { stimulus: { tags: { suite } } } }) +
        "\n",
    );
  }
}

beforeEach(() => {
  vi.clearAllMocks();
  for (const key of [
    "npm_config_model",
    "npm_config_skip_eval",
    "npm_config_skill_ref",
    "npm_config_results_dir",
    "npm_config_idle_timeout",
    "npm_config_update_skill_only",
    "npm_config_skip_docs",
    "npm_config_skip_update",
    "npm_config_skip_report",
    "AGENT_MODEL",
    "AGENT_IDLE_TIMEOUT_SEC",
  ]) {
    vi.stubEnv(key, "");
  }
  temporaryDir = mkdtempSync(path.join(tmpdir(), "doc-refinement-test-"));
  resultsDir = path.join(temporaryDir, "results");
  vi.spyOn(process.stdout, "write").mockImplementation(stdoutMock);
  vi.spyOn(process.stderr, "write").mockImplementation(() => true);
  vi.stubGlobal("fetch", fetchMock);
  fetchMock.mockImplementation(defaultFetch);
  mocks.command.mockImplementation(defaultCommand);
  mocks.start.mockResolvedValue(undefined);
  mocks.auth.mockResolvedValue({ isAuthenticated: true });
  mocks.disconnect.mockResolvedValue(undefined);
  mocks.stop.mockResolvedValue([]);
  mocks.createSession.mockResolvedValue({
    sendAndWait: mocks.send,
    disconnect: mocks.disconnect,
  });
  mocks.send.mockImplementation(({ prompt }) => {
    const output =
      prompt.match(/Write your structured analysis to (.+)\./)?.[1] ??
      prompt.match(/Write the final report to (.+)\./)?.[1];
    if (output) writeFileSync(output, "Mock workflow output\n");
    return Promise.resolve({ data: { content: "Done" } });
  });
  mocks.extract.mockImplementation((outputDir) => writeResults(outputDir));
});

afterEach(() => {
  rmSync(temporaryDir, { recursive: true, force: true });
});

describe("TypeScript CLI options", () => {
  it("preserves phase, model, timeout, ref, and output options", () => {
    expect(
      parseArgs([
        "--skip-eval",
        "--model",
        "test-model",
        "--idle-timeout",
        "2",
        "--skill-ref",
        "refs/heads/main",
        "--results-dir",
        resultsDir,
      ]),
    ).toEqual({
      help: false,
      skipEval: true,
      model: "test-model",
      idleTimeoutMs: 2000,
      skillRef: "refs/heads/main",
      resultsDir,
    });
  });

  it.each([
    [["--idle-timeout", "0"], "positive number"],
    [["--idle-timeout", "invalid"], "positive number"],
    [["--skill-ref"], "requires a value"],
    [["--results-dir"], "requires a value"],
    [["--update-skill-only"], "was removed"],
    [["--skip-docs"], "no longer supported"],
    [["--unknown"], "Unknown argument"],
  ])("rejects invalid arguments %j", (args, message) => {
    expect(() => parseArgs(args)).toThrow(message);
  });

  it("prints help without starting Copilot or evaluation", async () => {
    await main(["--help"]);
    expect(stdoutMock).toHaveBeenCalledWith(expect.stringContaining("doc-refinement.ts"));
    expect(mocks.start).not.toHaveBeenCalled();
    expect(fetchMock).not.toHaveBeenCalled();
  });
});

describe("workflow preservation", () => {
  it("runs only the two maintenance turns for --skip-eval", async () => {
    await main(["--skip-eval", "--results-dir", resultsDir]);
    expect(mocks.send).toHaveBeenCalledTimes(2);
    expect(mocks.createSession).toHaveBeenCalledTimes(1);
    expect(mocks.disconnect).toHaveBeenCalledTimes(1);
    expect(mocks.stop).toHaveBeenCalledTimes(1);
    expect(mocks.command).not.toHaveBeenCalled();
    expect(fetchMock).not.toHaveBeenCalled();
    expect(existsSync(resultsDir)).toBe(false);
  });

  it("runs all five steps and forwards the specs repository and ref", async () => {
    await main(["--skill-ref", "refs/pull/12345/head", "--results-dir", resultsDir]);
    const queue = fetchMock.mock.calls.find(([, options]) => options?.method === "POST");
    if (!queue) throw new Error("Expected a mocked benchmark request");
    const body = queue[1]?.body;
    if (typeof body !== "string") throw new Error("Expected a serialized benchmark request");
    const payload: unknown = JSON.parse(body);
    expect(payload).toEqual({
      definition: { id: 8178 },
      sourceBranch: "refs/heads/main",
      templateParameters: { SkillBranch: "refs/pull/12345/head", SkillRepository: REPOSITORY },
    });
    expect(mocks.send).toHaveBeenCalledTimes(4);
    expect(mocks.createSession).toHaveBeenCalledTimes(2);
    expect(mocks.disconnect).toHaveBeenCalledTimes(2);
    expect(mocks.stop).toHaveBeenCalledTimes(1);
    const runs = readdirSync(resultsDir);
    expect(runs).toHaveLength(1);
    for (const output of ["analysis.md", "document-gaps.md"]) {
      expect(readFileSync(path.join(resultsDir, runs[0], output), "utf8")).toBe(
        "Mock workflow output\n",
      );
    }
  });

  it("resolves fork branches through a specs PR ref", async () => {
    mocks.command.mockImplementation((command, args) => {
      if (
        command === "git" &&
        args[0] === "ls-remote" &&
        args.at(-1) === "refs/heads/test-refinement"
      )
        return "";
      return defaultCommand(command, args);
    });
    await main(["--results-dir", resultsDir]);
    expect(mocks.command).toHaveBeenCalledWith("gh", [
      "pr",
      "view",
      "test-refinement",
      "--repo",
      "Azure/azure-rest-api-specs",
      "--json",
      "number",
      "--jq",
      ".number",
    ]);
  });

  it("does not queue evaluation for uncommitted skill changes", async () => {
    mocks.command.mockImplementation((command, args) =>
      command === "git" && args[0] === "status"
        ? " M .github/skills/azure-typespec-author/SKILL.md"
        : defaultCommand(command, args),
    );
    await expect(main(["--results-dir", resultsDir])).rejects.toThrow(
      "cannot evaluate local changes",
    );
    expect(fetchMock).not.toHaveBeenCalled();
    expect(mocks.disconnect).toHaveBeenCalledTimes(1);
    expect(mocks.stop).toHaveBeenCalledTimes(1);
  });

  it("stops without starting a session when Copilot authentication is absent", async () => {
    mocks.auth.mockResolvedValue({ isAuthenticated: false });
    await expect(main(["--skip-eval"])).rejects.toThrow("not authenticated");
    expect(mocks.createSession).not.toHaveBeenCalled();
    expect(mocks.stop).toHaveBeenCalledTimes(1);
  });

  it("does not analyze incomplete evaluation suites", async () => {
    mocks.extract.mockImplementation((outputDir) => writeResults(outputDir, ["versioning"]));
    await expect(main(["--results-dir", resultsDir])).rejects.toThrow("missing suite results");
    expect(mocks.send).toHaveBeenCalledTimes(2);
    expect(mocks.stop).toHaveBeenCalledTimes(1);
  });

  it("surfaces failed builds without extracting or analyzing results", async () => {
    fetchMock.mockImplementation((input, init) =>
      requestUrl(input).includes("/builds/42?")
        ? Promise.resolve(Response.json({ status: "completed", result: "failed" }))
        : defaultFetch(input, init),
    );
    await expect(main(["--results-dir", resultsDir])).rejects.toThrow("result 'failed'");
    expect(mocks.extract).not.toHaveBeenCalled();
    expect(mocks.send).toHaveBeenCalledTimes(2);
    expect(mocks.stop).toHaveBeenCalledTimes(1);
  });

  it("rejects missing benchmark artifacts explicitly", async () => {
    fetchMock.mockImplementation((input, init) =>
      requestUrl(input).includes("/artifacts?")
        ? Promise.resolve(Response.json({ value: [] }))
        : defaultFetch(input, init),
    );
    await expect(runPipeline("refs/heads/main", resultsDir)).rejects.toThrow(
      "did not publish artifact",
    );
    expect(mocks.extract).not.toHaveBeenCalled();
  });
});
