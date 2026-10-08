import { d } from "@azure-tools/specs-shared/testing";
import { ChildProcess, spawn } from "node:child_process";
import { mkdirSync, readFileSync, unlinkSync, writeFileSync } from "node:fs";
import { access, mkdir, mkdtemp, readFile, realpath, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, relative, resolve } from "pathe";
import { PassThrough } from "node:stream";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, expect, it, vi } from "vitest";
import { formatRuleSummary } from "../src/diagnostics.ts";
import { runAll } from "../src/run-projects.ts";

vi.mock("node:child_process", async (importOriginal) => ({
  ...(await importOriginal()),
  spawn: vi.fn(),
}));

function exitingChild(
  code: number | null = 0,
  signal: NodeJS.Signals | null = null,
  output?: string,
) {
  const child = new ChildProcess();
  const stdout = new PassThrough();
  const stderr = new PassThrough();
  Object.assign(child, { stdout, stderr });
  queueMicrotask(() => {
    if (output) stdout.write(output);
    child.emit("close", code, signal);
  });
  return child;
}

function segmentedChild(segments: { stream: "stdout" | "stderr"; text: string }[]) {
  const child = new ChildProcess();
  const stdout = new PassThrough();
  const stderr = new PassThrough();
  Object.assign(child, { stdout, stderr });
  queueMicrotask(() => {
    for (const segment of segments) {
      (segment.stream === "stdout" ? stdout : stderr).write(segment.text);
    }
    child.emit("close", 0, null);
  });
  return child;
}

let root: string;
let patchFolder: string;

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
  patchFolder = await mkdtemp(join(tmpdir(), "tsv-diff-test-"));
  vi.stubEnv("GITHUB_ACTIONS", "false");
  vi.spyOn(console, "log").mockImplementation(() => {});
  vi.spyOn(console, "error").mockImplementation(() => {});
  vi.mocked(spawn)
    .mockReset()
    .mockImplementation(() => exitingChild());
});

afterEach(async () => {
  vi.restoreAllMocks();
  vi.unstubAllEnvs();
  await rm(root, { recursive: true, force: true });
  await rm(patchFolder, { recursive: true, force: true });
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

  expect(vi.mocked(spawn).mock.calls.map((call) => call[1]?.[1])).toEqual([
    first,
    nested,
    afterNested,
    last,
  ]);
  expect(spawn).toHaveBeenCalledWith(
    process.execPath,
    [expect.stringMatching(/[/\\]cmd[/\\]tsv\.js$/), first, '{"checkingAllSpecs":true}'],
    { stdio: ["ignore", "pipe", "pipe"], env: expect.any(Object) as unknown },
  );
  expect(console.error).not.toHaveBeenCalled();
});

it("forwards --verbose to child projects without changing their suppression context", async () => {
  const project = await addProject("a");
  await expect(runAll(root, { verbose: true })).resolves.toBe(true);
  expect(vi.mocked(spawn).mock.calls[0][1]).toEqual([
    expect.stringMatching(/[/\\]cmd[/\\]tsv\.js$/),
    project,
    '{"checkingAllSpecs":true}',
    "--verbose",
  ]);
});

it("forwards --allow-generated-changes to child projects through their context", async () => {
  const project = await addProject("a");
  await expect(runAll(root, { allowGeneratedChanges: true })).resolves.toBe(true);
  expect(vi.mocked(spawn).mock.calls[0][1]).toEqual([
    expect.stringMatching(/[/\\]cmd[/\\]tsv\.js$/),
    project,
    '{"checkingAllSpecs":true,"allowGeneratedChanges":true}',
  ]);
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
  expect(vi.mocked(spawn).mock.calls[0][1]?.[1]).toBe(project);
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
  vi.mocked(spawn)
    .mockImplementationOnce(() => exitingChild(1, null, "validation failed"))
    .mockImplementationOnce(() => exitingChild(0, null, "validation passed"));

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
  vi.mocked(spawn).mockImplementationOnce(() =>
    segmentedChild([
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
  vi.mocked(spawn).mockImplementationOnce(() =>
    segmentedChild([{ stream: "stderr", text: "local warning\n" }]),
  );

  await expect(runAll(root)).resolves.toBe(true);
  expect(console.error).toHaveBeenCalledWith("local warning");
});

it("appends all failed projects to the GitHub job summary", async () => {
  await addProject("specification/a");
  await addProject("specification/b");
  await addProject("specification/c");
  await simpleGit(root).init();
  vi.mocked(spawn)
    .mockImplementationOnce(() => exitingChild(1))
    .mockImplementationOnce(() => exitingChild())
    .mockImplementationOnce(() => exitingChild(1));
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
  vi.mocked(spawn).mockImplementationOnce(() => exitingChild(1));

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
      vi.mocked(spawn).mockClear();
      await expect(runAll(root, { shard: `${index}/${count}` })).resolves.toBe(true);
      const expected = projects.slice(selected.length, selected.length + sizes[index - 1]);
      expect(vi.mocked(spawn).mock.calls.map((call) => call[1]?.[1])).toEqual(expected);
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
  expect(vi.mocked(spawn).mock.calls.map((call) => call[1]?.[1])).toEqual([second]);
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

it("waits for each child to exit before starting the next project", async () => {
  await addProject("a");
  await addProject("b");
  let active = 0;
  let peak = 0;
  vi.mocked(spawn).mockImplementation(() => {
    const child = new ChildProcess();
    peak = Math.max(peak, ++active);
    setTimeout(() => {
      active--;
      child.emit("close", 0, null);
    }, 50);
    return child;
  });

  await expect(runAll(root)).resolves.toBe(true);
  expect(spawn).toHaveBeenCalledTimes(2);
  expect(peak).toBe(1);
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
  expect(vi.mocked(spawn).mock.calls.map((call) => call[1]?.[1])).toEqual([rule, subRule]);
  expect(console.log).toHaveBeenCalledWith("Suppressed: whole tool");
});

it("succeeds when all discovered projects are suppressed", async () => {
  await addProject("skip");
  await writeFile(
    join(root, "suppressions.yaml"),
    "- tool: TypeSpecValidationAll\n  paths: [skip]\n  reason: skipped\n",
  );

  await expect(runAll(root)).resolves.toBe(true);
  expect(spawn).not.toHaveBeenCalled();
  expect(console.error).not.toHaveBeenCalled();
});

it("continues after validation failures and reports every failed project", async () => {
  await addProject("a");
  await addProject("b");
  await addProject("c");
  await simpleGit(root).init();
  vi.mocked(spawn)
    .mockImplementationOnce(() => exitingChild(1))
    .mockImplementationOnce(() => exitingChild(0))
    .mockImplementationOnce(() => exitingChild(2));

  await expect(runAll(root)).resolves.toBe(false);
  expect(spawn).toHaveBeenCalledTimes(3);
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
  const error = new Error("Cannot start node");
  vi.mocked(spawn).mockImplementationOnce(() => {
    const child = new ChildProcess();
    queueMicrotask(() => child.emit("error", error));
    return child;
  });

  await expect(runAll(root)).rejects.toBe(error);
  expect(spawn).toHaveBeenCalledOnce();
  expect(console.log).not.toHaveBeenCalledWith(expect.stringMatching(/^::(?:end)?group::/));
});

it("stops when a child is terminated by a signal, surfacing any output captured first", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  vi.stubEnv("NO_COLOR", "1");
  const project = await addProject("a");
  await addProject("b");
  vi.mocked(spawn).mockImplementationOnce(() =>
    exitingChild(null, "SIGTERM", "partial diagnostic"),
  );

  await expect(runAll(root)).rejects.toThrow(`${project} terminated by SIGTERM`);
  expect(spawn).toHaveBeenCalledOnce();
  const groupTitle = vi
    .mocked(console.log)
    .mock.calls.map((call) => String(call[0]))
    .find((line) => line.startsWith("::group::"));
  expect(groupTitle).toMatch(/^::group::fail .*[/\\]a$/);
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
  vi.mocked(spawn).mockImplementationOnce(() => exitingChild(0, null, bigOutput));

  await expect(runAll(root)).resolves.toBe(true);
  const printed = vi
    .mocked(console.log)
    .mock.calls.map((call) => String(call[0]))
    .join("\n");
  expect(printed).toContain("[output truncated: exceeded 10 MiB]");
  expect(printed.length).toBeLessThan(bigOutput.length);
});

it("leaves existing and generated changes alone without --git-clean", async () => {
  await addProject("a");
  await commitFixture();
  await writeFile(join(root, "tracked.txt"), "local edits");
  vi.mocked(spawn).mockImplementationOnce(() => {
    writeFileSync(join(root, "generated.txt"), "generated");
    return exitingChild(1);
  });

  await expect(runAll(root)).resolves.toBe(false);
  expect(await readFile(join(root, "tracked.txt"), "utf8")).toBe("local edits");
  expect(await readFile(join(root, "generated.txt"), "utf8")).toBe("generated");
});

it("cleans the entire checkout after failed and successful projects, retaining ignored files", async () => {
  await addProject("specification/a");
  await addProject("specification/b");
  const git = await commitFixture();
  vi.mocked(spawn)
    .mockImplementationOnce(() => {
      writeFileSync(join(root, "tracked.txt"), "changed");
      mkdirSync(join(root, "generated"));
      writeFileSync(join(root, "generated", "output.txt"), "generated");
      return exitingChild(1);
    })
    .mockImplementationOnce(() => {
      expect(readFileSync(join(root, "tracked.txt"), "utf8")).toBe("original");
      writeFileSync(join(root, "tracked.txt"), "changed again");
      return exitingChild();
    });

  await expect(runAll(join(root, "specification"), { gitClean: true })).resolves.toBe(false);
  expect((await git.status()).isClean()).toBe(true);
  await expect(access(join(root, "generated"))).rejects.toMatchObject({ code: "ENOENT" });
  expect(await readFile(join(root, "cache.tmp"), "utf8")).toBe("keep");
});

it("saves each project's changes as an applicable patch before cleanup", async () => {
  await addProject("specification/a");
  await addProject("specification/b");
  const git = await commitFixture();
  const patch = join(patchFolder, "changes.patch");
  vi.mocked(spawn)
    .mockImplementationOnce(() => {
      writeFileSync(join(root, "tracked.txt"), "changed");
      writeFileSync(join(root, "specification", "a", "new.json"), "{}");
      return exitingChild(1);
    })
    .mockImplementationOnce(() => exitingChild());

  await expect(
    runAll(join(root, "specification"), { gitClean: true, diffOutput: patch }),
  ).resolves.toBe(false);
  expect((await git.status()).isClean()).toBe(true);

  await git.raw(["apply", patch]);
  expect(await readFile(join(root, "tracked.txt"), "utf8")).toBe("changed");
  expect(await readFile(join(root, "specification", "a", "new.json"), "utf8")).toBe("{}");
});

it.each(["tracked", "new", "deleted", "binary"])(
  "deduplicates repeated %s shared-file changes in an applicable patch",
  async (kind) => {
    await addProject("specification/service/a");
    await addProject("specification/service/b");
    const shared = join(root, "specification/service/shared file.tsp");
    const original = kind === "binary" ? Buffer.from([0, 1, 2]) : "unformatted\n";
    const generated = kind === "binary" ? Buffer.from([0, 3, 4]) : "formatted\n";
    if (kind !== "new") await writeFile(shared, original);
    const git = await commitFixture();
    const patch = join(patchFolder, "changes.patch");
    let project = 0;
    vi.mocked(spawn).mockImplementation(() => {
      if (kind === "deleted") unlinkSync(shared);
      else writeFileSync(shared, generated);
      writeFileSync(join(root, `output-${project++}.json`), "{}");
      return exitingChild();
    });

    await expect(runAll(root, { gitClean: true, diffOutput: patch })).resolves.toBe(true);
    expect((await git.status()).isClean()).toBe(true);
    expect((await readFile(patch, "utf8")).match(/diff --git/g)).toHaveLength(3);
    await git.raw(["apply", "--check", patch]);
    await git.raw(["apply", patch]);
    expect(await readFile(join(root, "output-0.json"), "utf8")).toBe("{}");
    expect(await readFile(join(root, "output-1.json"), "utf8")).toBe("{}");
    if (kind === "deleted") await expect(access(shared)).rejects.toMatchObject({ code: "ENOENT" });
    else expect(await readFile(shared)).toEqual(Buffer.from(generated));
  },
);

it("merges independent edits to the same shared file", async () => {
  await addProject("a");
  await addProject("b");
  const shared = join(root, "shared.tsp");
  const original = Array.from({ length: 15 }, (_, index) => `line ${index}`).join("\n") + "\n";
  await writeFile(shared, original);
  const git = await commitFixture();
  const patch = join(patchFolder, "changes.patch");
  vi.mocked(spawn)
    .mockImplementationOnce(() => {
      writeFileSync(shared, original.replace("line 0\n", "first\n"));
      return exitingChild();
    })
    .mockImplementationOnce(() => {
      writeFileSync(shared, original.replace("line 14\n", "last\n"));
      return exitingChild();
    });
  await expect(runAll(root, { gitClean: true, diffOutput: patch })).resolves.toBe(true);
  await git.raw(["apply", patch]);
  expect(await readFile(shared, "utf8")).toBe(
    original.replace("line 0\n", "first\n").replace("line 14\n", "last\n"),
  );
});

it("fails on inconsistent shared-file generation while still cleaning the checkout", async () => {
  await addProject("a");
  await addProject("b");
  const git = await commitFixture();
  const patch = join(patchFolder, "changes.patch");
  vi.mocked(spawn)
    .mockImplementationOnce(() => {
      writeFileSync(join(root, "tracked.txt"), "first");
      return exitingChild();
    })
    .mockImplementationOnce(() => {
      writeFileSync(join(root, "tracked.txt"), "second");
      return exitingChild();
    });
  await expect(runAll(root, { gitClean: true, diffOutput: patch })).rejects.toThrow("conflicts");
  expect((await git.status()).isClean()).toBe(true);
  await git.raw(["apply", patch]);
  expect(await readFile(join(root, "tracked.txt"), "utf8")).toBe("first");
});

it("overwrites stale patch output even when no projects generate changes", async () => {
  await addProject("a");
  const git = await commitFixture();
  const patch = join(patchFolder, "changes.patch");
  await writeFile(patch, "stale changes");
  await expect(runAll(root, { gitClean: true, diffOutput: patch })).resolves.toBe(true);
  expect(await readFile(patch, "utf8")).toBe("");
  expect((await git.status()).isClean()).toBe(true);
});

it("rejects patch files inside the checkout before running validation", async () => {
  await addProject("a");
  await commitFixture();
  await expect(
    runAll(root, { gitClean: true, diffOutput: join(root, "changes.patch") }),
  ).rejects.toThrow("--diff-output must be outside the checkout");
  expect(spawn).not.toHaveBeenCalled();
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

it("stops if cleanup fails rather than contaminating the next project", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  await addProject("a");
  await addProject("b");
  await commitFixture();
  vi.mocked(spawn).mockImplementationOnce(() => {
    writeFileSync(join(root, ".git", "index.lock"), "");
    return exitingChild();
  });

  await expect(runAll(root, { gitClean: true })).rejects.toThrow("index.lock");
  expect(spawn).toHaveBeenCalledOnce();
  expect(console.log).toHaveBeenLastCalledWith("::endgroup::");
});

it("rejects cleanup outside a Git repository before running validation", async () => {
  await addProject("a");
  await expect(runAll(root, { gitClean: true })).rejects.toThrow();
  expect(spawn).not.toHaveBeenCalled();
});
