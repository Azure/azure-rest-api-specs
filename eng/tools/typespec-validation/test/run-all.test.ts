import { d } from "@azure-tools/specs-shared/testing";
import { ChildProcess, spawn } from "node:child_process";
import { writeFileSync } from "node:fs";
import { mkdir, mkdtemp, readFile, realpath, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, relative, resolve } from "pathe";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, expect, it, vi } from "vitest";
import { formatRuleSummary } from "../src/diagnostics.ts";
import { runAll } from "../src/run-projects.ts";
import type { WorkerRequest } from "../src/worker-protocol.ts";
import { mockProjectWorker, type MockProjectWorker } from "./project-worker-mock.ts";

vi.mock("simple-git", { spy: true });
vi.mock("node:child_process", async (importOriginal) => ({
  ...(await importOriginal()),
  spawn: vi.fn(),
}));

let root: string;
let workers: MockProjectWorker[];
const onRequest = vi.fn<(request: WorkerRequest, worker: MockProjectWorker) => void>();
const requests = () => onRequest.mock.calls.map(([request]) => request);

async function addProject(name: string, config = "tspconfig.yaml") {
  const folder = join(root, name);
  await mkdir(folder, { recursive: true });
  await writeFile(join(folder, config), "");
  return folder;
}

async function commitFixture() {
  await writeFile(join(root, "tracked.txt"), "original");
  await writeFile(join(root, ".gitignore"), "cache.tmp\n");
  await writeFile(join(root, "cache.tmp"), "keep");
  const git = simpleGit(root);
  await git.init();
  await git.add(".");
  await git.raw([
    "-c",
    "user.name=Test",
    "-c",
    "user.email=test@example.com",
    "-c",
    "commit.gpgsign=false",
    "commit",
    "-m",
    "Fixture",
  ]);
  return git;
}

beforeEach(async () => {
  root = resolve(await realpath(await mkdtemp(join(tmpdir(), "tsv-all-"))));
  vi.stubEnv("GITHUB_ACTIONS", "false");
  vi.spyOn(console, "log").mockImplementation(() => {});
  vi.spyOn(console, "error").mockImplementation(() => {});
  vi.spyOn(console, "debug").mockImplementation(() => {});
  workers = [];
  onRequest.mockReset().mockImplementation((_request, worker) => worker.respond(true));
  vi.mocked(spawn)
    .mockReset()
    .mockImplementation(() => {
      const worker = mockProjectWorker(onRequest);
      workers.push(worker);
      return worker.child;
    });
});

afterEach(async () => {
  vi.restoreAllMocks();
  vi.unstubAllEnvs();
  await rm(root, { recursive: true, force: true });
});

it("discovers sorted, unique project folders, including invalid config extensions", async () => {
  const last = await addProject("z");
  const first = await addProject("a", "tspconfig.yml");
  await addProject("a");
  const nested = await addProject("a/nested");
  const afterNested = await addProject("aZ");
  await addProject("node_modules/dependency");
  await addProject("a/node_modules/dependency");
  await mkdir(join(root, "not-a-project", "tspconfig.yaml"), { recursive: true });

  await expect(runAll(root)).resolves.toBe(true);

  expect(requests().map(({ folder }) => folder)).toEqual([first, nested, afterNested, last]);
  expect(spawn).toHaveBeenCalledWith(
    process.execPath,
    [expect.stringMatching(/[/\\]src[/\\]project-worker\.ts$/)],
    { stdio: ["ignore", "pipe", "pipe", "ipc"], env: expect.any(Object) as unknown },
  );
  expect(requests().every(({ context }) => context.checkingAllSpecs)).toBe(true);
  expect(console.error).not.toHaveBeenCalled();
});

it("forwards --verbose to child projects without changing their suppression context", async () => {
  const project = await addProject("a");
  await expect(runAll(root, { verbose: true })).resolves.toBe(true);
  expect(vi.mocked(spawn).mock.calls[0][1]).toEqual([
    expect.stringMatching(/[/\\]src[/\\]project-worker\.ts$/),
    "--verbose",
  ]);
  expect(requests()).toEqual([{ folder: project, context: { checkingAllSpecs: true } }]);
});

it("forwards batch fix mode separately from suppression context", async () => {
  const project = await addProject("a");

  await expect(runAll(root, { fix: true })).resolves.toBe(true);

  expect(vi.mocked(spawn).mock.calls[0][1]).toEqual([
    expect.stringMatching(/[/\\]src[/\\]project-worker\.ts$/),
    "--fix",
  ]);
  expect(requests()).toEqual([{ folder: project, context: { checkingAllSpecs: true } }]);
});

it("logs repository-relative paths but passes absolute paths to validation", async () => {
  const project = await addProject("specification/service/Project");
  await simpleGit(root).init();

  await expect(runAll(join(root, "specification/service"))).resolves.toBe(true);

  expect(console.log).toHaveBeenCalledWith(
    "Checking 1 TypeSpec folders:\nspecification/service/Project",
  );
  expect(console.log).toHaveBeenCalledWith("\npass specification/service/Project");
  expect(console.log).not.toHaveBeenCalledWith("::endgroup::");
  expect(requests()[0].folder).toBe(project);
});

it("uses cwd-relative paths outside a Git repository", async () => {
  const project = await addProject("project");
  await expect(runAll(root)).resolves.toBe(true);
  const name = relative(process.cwd(), project);
  expect(console.log).toHaveBeenCalledWith(`Checking 1 TypeSpec folders:\n${name}`);
  expect(console.log).toHaveBeenCalledWith(`\npass ${name}`);
});

it("groups each project in GitHub Actions, including failures and suppressions", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  vi.stubEnv("NO_COLOR", "1");
  await addProject("specification/a");
  await addProject("specification/b");
  await addProject("specification/c");
  await simpleGit(root).init();
  await writeFile(
    join(root, "suppressions.yaml"),
    "- tool: TypeSpecValidationAll\n  paths: [specification/b]\n  reason: skipped\n",
  );
  onRequest
    .mockImplementationOnce((_request, worker) =>
      worker.respond(false, [{ stream: "stdout", text: "validation failed" }]),
    )
    .mockImplementationOnce((_request, worker) =>
      worker.respond(true, [{ stream: "stdout", text: "validation passed" }]),
    );

  await expect(runAll(join(root, "specification"))).resolves.toBe(false);
  expect(vi.mocked(console.log).mock.calls).toEqual([
    [
      d`
        Checking 3 TypeSpec folders:
        specification/a
        specification/b
        specification/c
      `,
    ],
    ["::group::fail specification/a"],
    [
      "validation failed\n" +
        "::error::TypeSpec Validation failed for project specification/a run the following command locally to validate.%0A" +
        " > pnpm install%0A > pnpm tsv specification/a%0A" +
        "For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation",
    ],
    ["::endgroup::"],
    ["::group::skip specification/b"],
    ["Suppressed: skipped"],
    ["::endgroup::"],
    ["::group::pass specification/c"],
    ["validation passed"],
    ["::endgroup::"],
    [""],
    [formatRuleSummary({ PASS: 1, FAIL: 1, WARN: 0, SKIP: 0, SUPPRESSED: 1 }, 0)],
  ]);
  expect(console.error).toHaveBeenCalledExactlyOnceWith(d`
    TypeSpec Validation failed for some folder to fix run and address any errors:
     > pnpm install
     > pnpm tsv specification/a
    For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation
  `);
});

it("keeps stderr warnings inside GitHub groups by writing grouped output to stdout", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  vi.stubEnv("NO_COLOR", "1");
  await addProject("specification/a");
  await simpleGit(root).init();
  onRequest.mockImplementationOnce((_request, worker) =>
    worker.respond(true, [
      { stream: "stdout", text: "before warning\n" },
      { stream: "stderr", text: "warning tsv/compile-output: additional output\n" },
      { stream: "stdout", text: "after warning\n" },
    ]),
  );

  await expect(runAll(join(root, "specification"))).resolves.toBe(true);
  const output = vi.mocked(console.log).mock.calls.map((call) => String(call[0]));
  const groupStart = output.indexOf("::group::pass specification/a");
  expect(output.slice(groupStart, groupStart + 5)).toEqual([
    "::group::pass specification/a",
    "before warning\n",
    "warning tsv/compile-output: additional output\n",
    "after warning",
    "::endgroup::",
  ]);
  expect(console.error).not.toHaveBeenCalled();
});

it("preserves captured stderr for local runs", async () => {
  await addProject("a");
  onRequest.mockImplementationOnce((_request, worker) =>
    worker.respond(true, [{ stream: "stderr", text: "local warning\n" }]),
  );

  await expect(runAll(root)).resolves.toBe(true);
  expect(console.error).toHaveBeenCalledWith("local warning");
});

it("appends all failed projects to the GitHub job summary", async () => {
  await addProject("specification/a");
  await addProject("specification/b");
  await addProject("specification/c");
  await simpleGit(root).init();
  onRequest
    .mockImplementationOnce((_request, worker) => worker.respond(false))
    .mockImplementationOnce((_request, worker) => worker.respond(true))
    .mockImplementationOnce((_request, worker) => worker.respond(false));
  const summaryFile = join(root, "summary.md");
  await writeFile(summaryFile, "Existing summary\n");

  await expect(runAll(join(root, "specification"), { summaryFile })).resolves.toBe(false);
  expect(await readFile(summaryFile, "utf8")).toBe(
    d`
      Existing summary
      ## TypeSpec Validation

      ❌ **2 of 3 projects failed.**

      ### Failed projects

      - \`specification/a\`
      - \`specification/c\`
    ` + "\n",
  );
});

it("reports successful and suppressed project counts in the GitHub job summary", async () => {
  await addProject("specification/a");
  await addProject("specification/b");
  await simpleGit(root).init();
  await writeFile(
    join(root, "suppressions.yaml"),
    "- tool: TypeSpecValidationAll\n  paths: [specification/b]\n  reason: skipped\n",
  );
  const summaryFile = join(root, "summary.md");

  await expect(runAll(join(root, "specification"), { summaryFile })).resolves.toBe(true);
  expect(await readFile(summaryFile, "utf8")).toBe(
    d`
      ## TypeSpec Validation

      ✅ **No projects failed (1 passed, 1 suppressed).**
    ` + "\n",
  );
});

it("escapes percent signs and newlines in GitHub error annotations", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  await addProject("specification/service%0A/Project");
  await simpleGit(root).init();
  onRequest.mockImplementationOnce((_request, worker) => worker.respond(false));

  await expect(runAll(join(root, "specification"))).resolves.toBe(false);
  expect(console.log).toHaveBeenCalledWith(
    "::error::TypeSpec Validation failed for project specification/service%250A/Project run the following command locally to validate.%0A" +
      " > pnpm install%0A > pnpm tsv specification/service%250A/Project%0A" +
      "For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation",
  );
  expect(console.error).toHaveBeenCalledExactlyOnceWith(d`
    TypeSpec Validation failed for some folder to fix run and address any errors:
     > pnpm install
     > pnpm tsv specification/service%0A/Project
    For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation
  `);
});

it.each([
  { count: 1, sizes: [6] },
  { count: 3, sizes: [2, 2, 2] },
  { count: 4, sizes: [2, 2, 1, 1] },
  { count: 6, sizes: [1, 1, 1, 1, 1, 1] },
])(
  "partitions six projects into $count balanced, non-overlapping shards",
  async ({ count, sizes }) => {
    const projects: string[] = [];
    for (const name of ["f", "b", "d", "a", "e", "c"]) {
      projects.push(await addProject(name));
    }
    projects.sort();
    const selected: string[] = [];
    for (let index = 1; index <= count; index++) {
      onRequest.mockClear();
      await expect(runAll(root, { shard: `${index}/${count}` })).resolves.toBe(true);
      const expected = projects.slice(selected.length, selected.length + sizes[index - 1]);
      expect(requests().map(({ folder }) => folder)).toEqual(expected);
      selected.push(...expected);
    }
    expect(selected).toEqual(projects);
  },
);

it("applies suppressions after sharding without moving projects between shards", async () => {
  await addProject("a");
  const second = await addProject("b");
  await addProject("c");
  await addProject("d");
  await writeFile(
    join(root, "suppressions.yaml"),
    "- tool: TypeSpecValidationAll\n  paths: [a]\n  reason: skipped\n",
  );

  await expect(runAll(root, { shard: "1/2" })).resolves.toBe(true);
  expect(requests().map(({ folder }) => folder)).toEqual([second]);
  expect(console.log).toHaveBeenCalledWith("Shard 1/2: 2 of 4 TypeSpec projects");
  expect(console.log).toHaveBeenCalledWith("Suppressed: skipped");
});

it.each([
  "",
  "1",
  "1/2/3",
  "0/2",
  "1/0",
  "3/2",
  "-1/2",
  "1.5/2",
  "1e0/2",
  " 1/2",
  "1/2\n",
  "1/9007199254740992",
  "9007199254740992/9007199254740992",
])("rejects invalid shard %j before running projects", async (shard) => {
  await addProject("a");
  await expect(runAll(root, { shard })).rejects.toThrow("Invalid --shard");
  expect(spawn).not.toHaveBeenCalled();
});

it("rejects more shards than projects before attempting cleanup", async () => {
  await addProject("a");
  await expect(runAll(root, { shard: "1/2", gitClean: true })).rejects.toThrow(
    "Shard count (2) exceeds the number of TypeSpec projects (1)",
  );
  expect(spawn).not.toHaveBeenCalled();
});

it("waits for each project to finish before reusing its worker", async () => {
  await addProject("a");
  await addProject("b");
  let active = 0;
  let peak = 0;
  onRequest.mockImplementation((_request, worker) => {
    peak = Math.max(peak, ++active);
    setTimeout(() => {
      active--;
      worker.respond(true);
    }, 50);
  });

  await expect(runAll(root)).resolves.toBe(true);
  expect(spawn).toHaveBeenCalledOnce();
  expect(requests()).toHaveLength(2);
  expect(peak).toBe(1);
});

it("rejects parallel fixing without launching a child", async () => {
  await addProject("project");

  await expect(runAll(root, { fix: true, concurrency: 2 })).rejects.toThrow(
    "--fix requires --concurrency=1",
  );
  expect(spawn).not.toHaveBeenCalled();
});

it("bounds concurrent sibling projects and reports failures in discovery order", async () => {
  const first = await addProject("specification/service/a");
  const second = await addProject("specification/service/b");
  const third = await addProject("specification/service/c");
  await simpleGit(root).init();
  const children = new Map<string, MockProjectWorker>();
  onRequest.mockImplementation((request, worker) => {
    children.set(request.folder, worker);
  });
  const result = runAll(root, { concurrency: 2 });
  await vi.waitFor(() => expect(children.size).toBe(2));
  expect(children.has(third)).toBe(false);
  children.get(second)?.respond(false);
  await vi.waitFor(() => expect(children.has(third)).toBe(true));
  children.get(third)?.respond(true);
  children.get(first)?.respond(false);

  await expect(result).resolves.toBe(false);

  expect(console.error).toHaveBeenLastCalledWith(
    expect.stringContaining(
      " > pnpm tsv specification/service/a\n > pnpm tsv specification/service/b",
    ),
  );
});

it("stops scheduling and waits for active children after a fatal termination", async () => {
  const first = await addProject("a");
  await addProject("b");
  await addProject("c");
  const children = new Map<string, MockProjectWorker>();
  let peerClosed = false;
  onRequest.mockImplementation((request, worker) => {
    children.set(request.folder, worker);
    worker.kill.mockImplementation(() => {
      setTimeout(() => {
        peerClosed = true;
        worker.exit(null, "SIGTERM");
      }, 10);
      return true;
    });
  });
  const result = runAll(root, { concurrency: 2 });
  const failure = expect(result).rejects.toThrow(`${first} terminated by SIGKILL`);
  await vi.waitFor(() => expect(children.size).toBe(2));
  children.get(first)?.exit(null, "SIGKILL");

  await failure;
  expect(spawn).toHaveBeenCalledTimes(2);
  expect(peerClosed).toBe(true);
});

it("honors conditional whole-tool suppressions without skipping rule-scoped ones", async () => {
  await addProject("skip");
  const rule = await addProject("rule");
  const subRule = await addProject("sub-rule");
  await writeFile(
    join(root, "suppressions.yaml"),
    `- tool: TypeSpecValidationAll
  paths: [skip]
  if: checkingAllSpecs === true
  reason: whole tool
- tool: TypeSpecValidationAll
  paths: [rule]
  rules: [Compile]
  reason: one rule
- tool: TypeSpecValidationAll
  paths: [sub-rule]
  sub-rules: [ExtraSwagger]
  reason: one sub-rule
`,
  );

  await expect(runAll(root)).resolves.toBe(true);
  expect(requests().map(({ folder }) => folder)).toEqual([rule, subRule]);
  expect(console.log).toHaveBeenCalledWith("Suppressed: whole tool");
});

it("succeeds when all discovered projects are suppressed", async () => {
  await addProject("skip");
  await writeFile(
    join(root, "suppressions.yaml"),
    "- tool: TypeSpecValidationAll\n  paths: [skip]\n  reason: skipped\n",
  );
  await commitFixture();

  await expect(runAll(root, { gitClean: true })).resolves.toBe(true);
  expect(spawn).not.toHaveBeenCalled();
  expect(console.error).not.toHaveBeenCalled();
});

it("continues after validation failures and reports every failed project", async () => {
  await addProject("a");
  await addProject("b");
  await addProject("c");
  await simpleGit(root).init();
  onRequest
    .mockImplementationOnce((_request, worker) => worker.respond(false))
    .mockImplementationOnce((_request, worker) => worker.respond(true))
    .mockImplementationOnce((_request, worker) => worker.respond(false));

  await expect(runAll(root)).resolves.toBe(false);
  expect(requests()).toHaveLength(3);
  expect(vi.mocked(console.error).mock.calls).toEqual([
    [
      d`
        TypeSpec Validation failed for project a run the following command locally to validate.
         > pnpm install
         > pnpm tsv a
        For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation
      `,
    ],
    [
      d`
        TypeSpec Validation failed for project c run the following command locally to validate.
         > pnpm install
         > pnpm tsv c
        For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation
      `,
    ],
    [
      d`
        TypeSpec Validation failed for some folder to fix run and address any errors:
         > pnpm install
         > pnpm tsv a
         > pnpm tsv c
        For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation
      `,
    ],
  ]);
  expect(console.log).not.toHaveBeenCalledWith(expect.stringMatching(/^::error::/));
});

it("fails when no projects are discovered", async () => {
  await expect(runAll(root)).resolves.toBe(false);
  expect(console.error).toHaveBeenCalledWith(`No TypeSpec projects found in ${root}`);
  expect(spawn).not.toHaveBeenCalled();
});

it("rejects a file instead of a directory", async () => {
  const file = join(root, "file");
  await writeFile(file, "");
  await expect(runAll(file)).rejects.toThrow("directory path");
  expect(spawn).not.toHaveBeenCalled();
});

it("surfaces invalid suppressions before starting validation", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  await addProject("a");
  await writeFile(join(root, "suppressions.yaml"), "- tool: TypeSpecValidationAll\n");
  await expect(runAll(root)).rejects.toThrow();
  expect(spawn).not.toHaveBeenCalled();
  expect(console.log).not.toHaveBeenCalledWith(expect.stringMatching(/^::(?:end)?group::/));
});

it("surfaces process launch errors instead of treating them as validation failures", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  await addProject("a");
  await addProject("b");
  const git = await commitFixture();
  const error = new Error("Cannot start node");
  vi.mocked(spawn).mockImplementationOnce(() => {
    const child = new ChildProcess();
    Object.assign(child, { send: vi.fn() });
    queueMicrotask(() => {
      child.emit("error", error);
      child.emit("close", null, null);
    });
    return child;
  });

  await expect(runAll(root, { gitClean: true })).rejects.toBe(error);
  expect(spawn).toHaveBeenCalledOnce();
  expect((await git.status()).isClean()).toBe(true);
  expect(await readFile(join(root, "tracked.txt"), "utf8")).toBe("original");
  expect(console.log).not.toHaveBeenCalledWith(expect.stringMatching(/^::(?:end)?group::/));
});

it("stops when a child is terminated by a signal, surfacing any output captured first", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  vi.stubEnv("NO_COLOR", "1");
  const project = await addProject("a");
  await addProject("b");
  const git = await commitFixture();
  onRequest.mockImplementationOnce((_request, worker) => {
    worker.output([{ stream: "stdout", text: "partial diagnostic" }]);
    worker.exit(null, "SIGTERM");
  });

  await expect(runAll(root, { gitClean: true })).rejects.toThrow(
    `${project} terminated by SIGTERM`,
  );
  expect(spawn).toHaveBeenCalledOnce();
  expect((await git.status()).isClean()).toBe(true);
  expect(await readFile(join(root, "tracked.txt"), "utf8")).toBe("original");
  expect(console.log).toHaveBeenCalledWith("::group::fail a");
  expect(console.log).toHaveBeenCalledWith("partial diagnostic");
  expect(console.log).toHaveBeenCalledWith(
    `TypeSpec Validation for ${project} terminated by SIGTERM`,
  );
  expect(console.error).not.toHaveBeenCalled();
  expect(console.log).toHaveBeenLastCalledWith("::endgroup::");
});

it("caps captured output per project so a runaway diagnostic can't grow memory without bound", async () => {
  await addProject("a");
  const bigOutput = "x".repeat(11 * 1024 * 1024); // 11 MiB, exceeds the 10 MiB cap
  onRequest.mockImplementationOnce((_request, worker) =>
    worker.respond(true, [{ stream: "stdout", text: bigOutput }]),
  );

  await expect(runAll(root)).resolves.toBe(true);
  const printed = vi
    .mocked(console.log)
    .mock.calls.map((call) => String(call[0]))
    .join("\n");
  expect(printed).toContain("[output truncated: exceeded 10 MiB]");
  expect(printed.length).toBeLessThan(bigOutput.length);
});

it("verifies cleanliness once without restoring or cleaning files", async () => {
  await addProject("specification/a");
  await addProject("specification/b");
  await commitFixture();
  const git = simpleGit({ baseDir: root, allowEnvironment: ["GIT_OPTIONAL_LOCKS"] });
  const status = vi.spyOn(git, "status");
  const raw = vi.spyOn(git, "raw");
  const clean = vi.spyOn(git, "clean");
  vi.mocked(simpleGit).mockReturnValueOnce(git);

  await expect(runAll(join(root, "specification"), { gitClean: true })).resolves.toBe(true);

  expect(status).toHaveBeenCalledExactlyOnceWith(["--untracked-files=all"]);
  expect(raw).not.toHaveBeenCalled();
  expect(clean).not.toHaveBeenCalled();
  expect(requests()).toHaveLength(2);
});

it("does not clean a dirty checkout during a dry run", async () => {
  await addProject("a");
  await writeFile(join(root, "local.txt"), "keep");
  await expect(runAll(root, { gitClean: true, dryRun: true })).resolves.toBe(true);

  expect(spawn).not.toHaveBeenCalled();
  expect(await readFile(join(root, "local.txt"), "utf8")).toBe("keep");
});

it("never discards edits made after the initial cleanliness check", async () => {
  await addProject("specification/a");
  await addProject("specification/b");
  const git = await commitFixture();
  onRequest.mockImplementationOnce((_request, worker) => {
    writeFileSync(join(root, "tracked.txt"), "changed");
    writeFileSync(join(root, "generated.txt"), "generated");
    worker.respond(false);
  });

  await expect(runAll(join(root, "specification"), { gitClean: true })).resolves.toBe(false);
  expect((await git.status()).isClean()).toBe(false);
  expect(await readFile(join(root, "tracked.txt"), "utf8")).toBe("changed");
  expect(await readFile(join(root, "generated.txt"), "utf8")).toBe("generated");
  expect(await readFile(join(root, "cache.tmp"), "utf8")).toBe("keep");
});

it.each(["modified", "staged", "untracked"])(
  "refuses cleanup with pre-existing %s files",
  async (state) => {
    await addProject("a");
    const git = await commitFixture();
    const file = join(root, state === "untracked" ? "new.txt" : "tracked.txt");
    await writeFile(file, "local edits");
    if (state === "staged") await git.add(".");

    await expect(runAll(join(root, "a"), { gitClean: true })).rejects.toThrow("clean checkout");
    expect(spawn).not.toHaveBeenCalled();
    expect(await readFile(file, "utf8")).toBe("local edits");
  },
);

it("rejects cleanup outside a Git repository before running validation", async () => {
  await addProject("a");
  await expect(runAll(root, { gitClean: true })).rejects.toThrow();
  expect(spawn).not.toHaveBeenCalled();
});

it("recycles workers after 20 projects while preserving results", async () => {
  const projects: string[] = [];
  for (let i = 0; i < 21; i++) {
    projects.push(await addProject(`p${String(i).padStart(2, "0")}${i === 1 ? "-bad" : ""}`));
  }
  onRequest.mockImplementation((request, worker) =>
    worker.respond(!request.folder.endsWith("-bad"), [
      { stream: "stdout", text: `checked ${request.folder}` },
    ]),
  );

  await expect(runAll(root, { concurrency: 1 })).resolves.toBe(false);

  expect(spawn).toHaveBeenCalledTimes(2);
  expect(workers.map(({ requests }) => requests.map(({ folder }) => folder))).toEqual([
    projects.slice(0, 20),
    projects.slice(20),
  ]);
  expect(workers.every(({ disconnect }) => disconnect.mock.calls.length === 1)).toBe(true);
  expect(console.log).toHaveBeenCalledWith(expect.stringContaining(`checked ${projects[20]}`));
  expect(console.error).toHaveBeenCalledWith(expect.stringContaining("p01-bad"));
});

it("restarts a worker that exits unexpectedly and continues validating projects", async () => {
  await addProject("a");
  const second = await addProject("b");
  onRequest.mockImplementationOnce((_request, worker) => {
    worker.output([{ stream: "stderr", text: "worker diagnostic\n" }]);
    worker.exit(1, null);
  });

  await expect(runAll(root)).resolves.toBe(false);

  expect(spawn).toHaveBeenCalledTimes(2);
  expect(requests().map(({ folder }) => folder)).toContain(second);
  expect(console.error).toHaveBeenCalledWith(
    "worker diagnostic\nTypeSpec Validation worker exited with code 1",
  );
});
