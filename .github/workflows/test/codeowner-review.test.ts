import { beforeEach, describe, expect, it } from "vitest";
import {
  createCodeOwnerReviewGuidance,
  getCodeOwnerReviewGuidance,
  getProtectedFiles,
} from "../src/codeowner-review.ts";
import { createMockCore, createMockGithub } from "./mocks.ts";

const SOURCE_URL = "https://github.com/Azure/azure-rest-api-specs/blob/base-sha/.github/CODEOWNERS";
const CODEOWNERS = [
  "* @maintainers",
  "/specification/",
  "/specification/widgets/ @service-owner",
  "/eng/ @eng-owner @Azure/maintainers",
  "/eng/common/ @Azure/sync-approvers",
  "/eng/tools/special/ @special-owner # override shared tooling ownership",
  "/.github/CODEOWNERS @ownership-admin",
].join("\n");

describe("Protected file scope", () => {
  it.each([
    ".gitignore",
    "cspell.json",
    "cspell.yaml",
    "package.json",
    "pnpm-lock.yaml",
    "pnpm-workspace.yaml",
    ".github/workflows/check.yaml",
    ".github/.hidden.yaml",
    ".github/CODEOWNERS.backup",
    ".github/skills",
    ".vscode/settings.json",
    "eng/tools/example/index.ts",
    "eng/.hidden/config.yaml",
    "eng/common",
    "eng/common/script.ps1",
    ".github/skills/azsdk-common-example",
    ".github/skills/azsdk-common-example/SKILL.md",
    ".github/skills/azsdk-common-example/.hidden/config.yaml",
    "PACKAGE.JSON",
    ".GITHUB/WORKFLOWS/check.yaml",
    ".GITHUB/SKILLS/AZSDK-COMMON-EXAMPLE/skill.md",
  ])("retains the original protected path %s", (file) => {
    expect(getProtectedFiles([file])).toEqual([file]);
  });

  it.each([
    "specification/widgets/main.tsp",
    "specification/widgets/package.json",
    "specification/suppressions.yaml",
    "README.md",
    "documentation/ci-fix.md",
    "tsconfig.json",
    ".github/CODEOWNERS",
    ".github/skills/custom",
    ".github/skills/custom/SKILL.md",
    ".github/skills/custom/azsdk-common-example/SKILL.md",
    ".github/skills/custom/.hidden/config.yaml",
    ".GITHUB/codeowners",
    ".GITHUB/SKILLS/CUSTOM/SKILL.md",
  ])("does not expand protected scope to %s", (file) => {
    expect(getProtectedFiles([file])).toEqual([]);
  });
});

describe("Protected-file code-owner report", () => {
  const core = createMockCore();
  const render = (files: string[], contents = CODEOWNERS) =>
    createCodeOwnerReviewGuidance(contents, files, SOURCE_URL, core);

  beforeEach(() => {
    core.warning.mockClear();
  });

  it("groups touched areas using the last matching entry and tool-specific overrides", () => {
    const summary = render([
      "package.json",
      "eng/tools/ordinary/index.ts",
      "eng/tools/ordinary/test.ts",
      "eng/tools/special/index.ts",
      "specification/widgets/main.tsp",
    ]);
    expect(summary).toContain("[`*`](" + SOURCE_URL + "#L1)");
    expect(summary).toContain("[`/eng/`](" + SOURCE_URL + "#L4)");
    expect(summary).toContain("[`/eng/tools/special/`](" + SOURCE_URL + "#L6)");
    expect(summary).toContain("[`@special-owner`](https://github.com/special-owner)");
    expect(summary).toContain(
      "[`@Azure/maintainers`](https://github.com/orgs/Azure/teams/maintainers)",
    );
    expect(summary).toContain("`eng/tools/ordinary/index.ts`<br />`eng/tools/ordinary/test.ts`");
    expect(summary).toContain("repository maintainers or the applicable tooling owners");
    expect(summary).toContain("outside the scope of a specification contribution");
    expect(summary).toContain("Remove unrelated changes from your specification PR");
    expect(summary).not.toContain("specification/widgets/main.tsp");
    expect(summary).not.toContain("@service-owner");
    expect(summary).not.toContain("# override");
  });

  it("does not invent required code-owner approval for explicit unowned areas", () => {
    const summary = render(["eng/common/unowned.yaml"], CODEOWNERS + "\n/eng/common/unowned.yaml");
    expect(summary).toContain("[`/eng/common/unowned.yaml`](" + SOURCE_URL + "#L8)");
    expect(summary).toContain("No code owner assigned");
    expect(summary).not.toContain("@maintainers");
    expect(summary).toContain("still need normal PR review");
  });

  it("leaves specification-only ownership to GitHub", () => {
    expect(render(["specification/widgets/main.tsp"])).toBe(
      "This PR does not change protected files.",
    );
    expect(render(["specification/unlisted/main.tsp"], "* @default")).toBe(
      "This PR does not change protected files.",
    );
  });

  it("separates protected tools even when they share the default ownership rule", () => {
    const summary = render(
      [
        "package.json",
        ".github/workflows/check.yaml",
        "eng/tools/first/index.ts",
        "eng/tools/second/index.ts",
        "specification/first/main.tsp",
        "specification/second/main.tsp",
      ],
      "* @maintainers",
    );
    for (const area of ["Repository root", ".github/", "eng/tools/first/", "eng/tools/second/"]) {
      expect(summary).toContain(`\`${area}\`<br />[\`*\`]`);
    }
    expect(summary).not.toContain("specification/first/");
    expect(summary).not.toContain("specification/second/");
  });
  it("identifies files with no matching rule", () => {
    const summary = render([".vscode/settings.json"], "/eng/ @eng-owner");
    expect(summary).toContain("No matching CODEOWNERS entry");
    expect(summary).toContain("No code owner assigned");
  });

  it("uses case-sensitive ownership and includes dotfiles", () => {
    const summary = render(
      [".github/config.yaml", ".github/.hidden.yaml", "ENG/tool.ts"],
      CODEOWNERS + "\n/.github/config.yaml @github-owner",
    );
    expect(summary).toContain("@github-owner");
    expect(summary).toContain("`.github/.hidden.yaml`");
    expect(summary).not.toContain("@eng-owner");
  });

  it("adds synchronized-source guidance without blocking mixed changes", () => {
    const summary = render([
      "specification/widgets/main.tsp",
      "eng/common/script.ps1",
      ".github/skills/azsdk-common-example/SKILL.md",
    ]);
    expect(summary).not.toContain("@service-owner");
    expect(summary).not.toContain("specification/widgets/main.tsp");
    expect(summary).toContain("@Azure/sync-approvers");
    expect(summary.match(/Make source changes there/g)).toHaveLength(2);
    expect(summary).toContain("can be overwritten");
    expect(summary).not.toContain("Remove this change");
  });

  it("does not mistake similarly named or nested directories for synchronized copies", () => {
    const summary = render([
      "eng/common-other/script.ps1",
      ".github/skills/custom/azsdk-common-example/SKILL.md",
    ]);
    expect(summary).not.toContain("Synchronized from");
  });

  it("preserves the CODEOWNERS and non-synchronized skill exclusions", () => {
    const summary = render([".github/CODEOWNERS", ".github/skills/custom/SKILL.md"]);
    expect(summary).toBe("This PR does not change protected files.");
  });

  it("keeps gitignore semantics rather than expanding minimatch braces", () => {
    const summary = render(
      ["eng/nested/config.json", "eng/config.ts", "eng/config.{json,ts}"],
      "* @default\neng/config.{json,ts} @literal-owner\n**/config.json @json-owner",
    );
    expect(summary).toContain("`eng/config.ts`");
    expect(summary).toContain("`@literal-owner`");
    expect(summary).toContain("`@json-owner`");
  });

  it("handles escaped spaces, comments, CRLF, and email owners", () => {
    const summary = render(
      ["eng/with spaces/config.json"],
      "# comment\r\n/eng/with\\ spaces/ review@example.com # inline comment\r\n",
    );
    expect(summary).toContain("`review@example.com`");
    expect(summary).not.toContain("No code owner assigned");
  });

  it("warns and skips syntax unsupported by GitHub rather than overriding valid owners", () => {
    const summary = render(
      ["eng/tool.ts"],
      "* @owner\n!eng/ @wrong\neng/[abc]/ @wrong\neng/ not-an-owner",
    );
    expect(core.warning).toHaveBeenCalledTimes(3);
    expect(summary).toContain("`@owner`");
    expect(summary).not.toContain("@wrong");
  });

  it("escapes filename Markdown and HTML and avoids owner mentions in comments", () => {
    const summary = render(["eng/a`|<img src=x>\nconfig.json"]);
    expect(summary).toContain("``eng/a`\\|<img src=x> config.json``");
    expect(summary).toContain("[`@eng-owner`](https://github.com/eng-owner)");
  });

  it("limits file examples within each area and deduplicates paths", () => {
    const files = Array.from({ length: 8 }, (_, index) => `eng/tools/example/${index}.ts`);
    const summary = render([...files, files[0]]);
    expect(summary).toContain("`eng/tools/example/4.ts`");
    expect(summary).not.toContain("`eng/tools/example/5.ts`");
    expect(summary).toContain("3 more files");
  });

  it("bounds large reports without hiding that additional ownership areas were omitted", () => {
    const files = Array.from({ length: 300 }, (_, index) => `eng/tool-${index}/index.ts`);
    const contents = files.map((file, index) => `/${file} @owner-${index}`).join("\n");
    const summary = render(files, contents);
    expect(summary.length).toBeLessThan(50_000);
    expect(summary).toContain("additional areas are not shown");
    expect(summary).toContain("Files changed tab");
    expect(core.warning).toHaveBeenCalledWith(expect.stringContaining("comment limit"));
  });
});

describe("Trusted PR summary review guidance", () => {
  function setup() {
    const github = createMockGithub();
    const core = createMockCore();
    github.rest.pulls.get.mockResolvedValue({
      data: {
        state: "open",
        changed_files: 2,
        head: { sha: "head-sha" },
        base: { sha: "base-sha" },
      },
    });
    github.rest.pulls.listFiles.mockResolvedValue({
      data: [
        { filename: "specification/widgets/main.tsp" },
        { filename: "eng/tools/special/new.ts", previous_filename: "eng/common/old.ts" },
      ],
    });
    github.rest.repos.getContent.mockResolvedValue({
      data: {
        type: "file",
        encoding: "base64",
        content: Buffer.from(CODEOWNERS).toString("base64"),
      },
    });
    return {
      github,
      core,
      run: () =>
        getCodeOwnerReviewGuidance(github, core, "Azure", "azure-rest-api-specs", 1, "head-sha"),
    };
  }

  it("reads PR files and immutable base-branch ownership, including rename sources", async () => {
    const { github, run } = setup();
    const summary = await run();
    expect(summary).toContain("eng/common/old.ts");
    expect(summary).toContain("eng/tools/special/new.ts");
    expect(summary).toContain("@Azure/sync-approvers");
    expect(summary).toContain("@special-owner");
    expect(summary).not.toContain("specification/widgets/main.tsp");
    expect(github.rest.repos.getContent).toHaveBeenCalledExactlyOnceWith({
      owner: "Azure",
      repo: "azure-rest-api-specs",
      path: ".github/CODEOWNERS",
      ref: "base-sha",
    });
    expect(github.rest.pulls.get).toHaveBeenCalledOnce();
    expect(github.rest.pulls.listFiles).toHaveBeenCalledOnce();
  });

  it("omits guidance and CODEOWNERS reads when only specifications changed", async () => {
    const { github, core, run } = setup();
    github.rest.pulls.get.mockResolvedValue({
      data: {
        state: "open",
        changed_files: 1,
        head: { sha: "head-sha" },
        base: { sha: "base-sha" },
      },
    });
    github.rest.pulls.listFiles.mockResolvedValue({
      data: [{ filename: "specification/widgets/main.tsp" }],
    });
    expect(await run()).toBeUndefined();
    expect(github.rest.repos.getContent).not.toHaveBeenCalled();
    expect(core.info).toHaveBeenCalledWith(
      "No changes to protected files; leaving specification ownership to GitHub.",
    );
  });

  it("reports a protected rename source without reporting its specification destination", async () => {
    const { github, run } = setup();
    github.rest.pulls.get.mockResolvedValue({
      data: {
        state: "open",
        changed_files: 1,
        head: { sha: "head-sha" },
        base: { sha: "base-sha" },
      },
    });
    github.rest.pulls.listFiles.mockResolvedValue({
      data: [
        {
          filename: "specification/widgets/new.tsp",
          previous_filename: "eng/tools/special/old.tsp",
        },
      ],
    });
    const summary = await run();
    expect(summary).toContain("eng/tools/special/old.tsp");
    expect(summary).toContain("@special-owner");
    expect(summary).not.toContain("specification/widgets/new.tsp");
  });

  it.each([
    { state: "closed", sha: "head-sha" },
    { state: "open", sha: "newer-sha" },
  ])(
    "does not attribute outdated or closed PR changes to this run: $state $sha",
    async ({ state, sha }) => {
      const { github, core, run } = setup();
      github.rest.pulls.get.mockResolvedValue({ data: { state, head: { sha } } });
      expect(await run()).toBeUndefined();
      expect(core.info).toHaveBeenCalledWith(expect.stringContaining("outdated head SHA"));
      expect(github.rest.pulls.listFiles).not.toHaveBeenCalled();
      expect(github.rest.repos.getContent).not.toHaveBeenCalled();
    },
  );

  it("fails explicitly if GitHub truncates the changed-file list", async () => {
    const { github, run } = setup();
    github.rest.pulls.listFiles.mockResolvedValue({
      data: [{ filename: "eng/common/old.ts" }],
    });
    await expect(run()).rejects.toThrow("incomplete changed-file list");
    expect(github.rest.repos.getContent).not.toHaveBeenCalled();
  });

  it.each([[], { type: "dir" }, { type: "file", encoding: "none", content: "" }])(
    "does not present unreadable CODEOWNERS as successful guidance: %j",
    async (data) => {
      const { github, run } = setup();
      github.rest.repos.getContent.mockResolvedValue({ data });
      await expect(run()).rejects.toThrow("base64-encoded CODEOWNERS file");
    },
  );

  it("propagates API failures", async () => {
    const { github, run } = setup();
    github.rest.repos.getContent.mockRejectedValue(new Error("GitHub unavailable"));
    await expect(run()).rejects.toThrow("GitHub unavailable");
  });
});
