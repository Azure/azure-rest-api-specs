import { ChildProcess, spawn } from "node:child_process";
import { mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { access, mkdir, mkdtemp, readFile, realpath, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, relative, sep } from "node:path";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, expect, it, vi } from "vitest";
import { runAll } from "../src/run-all.ts";

vi.mock("node:child_process", async (importOriginal) => ({
  ...(await importOriginal()),
  spawn: vi.fn(),
}));

function exitingChild(code: number | null = 0, signal: NodeJS.Signals | null = null) {
  const child = new ChildProcess();
  queueMicrotask(() => child.emit("close", code, signal));
  return child;
}

let root: string;

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
  root = await realpath(await mkdtemp(join(tmpdir(), "tsv-all-")));
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
    { stdio: "inherit" },
  );
});

it("logs repository-relative paths but passes absolute paths to validation", async () => {
  const project = await addProject("specification/service/Project");
  await simpleGit(root).init();

  await expect(runAll(join(root, "specification/service"))).resolves.toBe(true);

  expect(console.log).toHaveBeenCalledWith(
    "Checking 1 TypeSpec folders:\nspecification/service/Project",
  );
  expect(console.log).toHaveBeenCalledWith("\nValidating specification/service/Project");
  expect(console.log).not.toHaveBeenCalledWith("::endgroup::");
  expect(vi.mocked(spawn).mock.calls[0][1]?.[1]).toBe(project);
});

it("uses cwd-relative paths outside a Git repository", async () => {
  const project = await addProject("project");
  await expect(runAll(root)).resolves.toBe(true);
  const name = relative(process.cwd(), project).split(sep).join("/");
  expect(console.log).toHaveBeenCalledWith(`Checking 1 TypeSpec folders:\n${name}`);
  expect(console.log).toHaveBeenCalledWith(`\nValidating ${name}`);
});

it("groups each project in GitHub Actions, including failures and suppressions", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  await addProject("specification/a");
  await addProject("specification/b");
  await addProject("specification/c");
  await simpleGit(root).init();
  await writeFile(
    join(root, "suppressions.yaml"),
    "- tool: TypeSpecValidationAll\n  paths: [specification/b]\n  reason: skipped\n",
  );
  vi.mocked(spawn)
    .mockImplementationOnce(() => {
      console.log("validation failed");
      return exitingChild(1);
    })
    .mockImplementationOnce(() => {
      console.log("validation passed");
      return exitingChild(0);
    });

  await expect(runAll(join(root, "specification"))).resolves.toBe(false);
  expect(vi.mocked(console.log).mock.calls).toEqual([
    ["Checking 3 TypeSpec folders:\nspecification/a\nspecification/b\nspecification/c"],
    ["::group::Validating specification/a"],
    ["validation failed"],
    ["::endgroup::"],
    ["::group::Validating specification/b"],
    ["Suppressed: skipped"],
    ["::endgroup::"],
    ["::group::Validating specification/c"],
    ["validation passed"],
    ["::endgroup::"],
  ]);
  expect(console.error).toHaveBeenCalledWith("TypeSpec Validation failed for:\nspecification/a");
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
  expect(console.error).toHaveBeenCalledWith("TypeSpec Validation failed for:\na\nc");
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
  expect(console.log).toHaveBeenLastCalledWith("::endgroup::");
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
  expect(console.log).toHaveBeenLastCalledWith("::endgroup::");
});

it("stops when a child is terminated by a signal", async () => {
  vi.stubEnv("GITHUB_ACTIONS", "true");
  const project = await addProject("a");
  await addProject("b");
  vi.mocked(spawn).mockImplementationOnce(() => exitingChild(null, "SIGTERM"));

  await expect(runAll(root)).rejects.toThrow(`${project} terminated by SIGTERM`);
  expect(spawn).toHaveBeenCalledOnce();
  expect(console.log).toHaveBeenLastCalledWith("::endgroup::");
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
