import { readFile } from "fs/promises";
import { load } from "js-yaml";
import { join } from "path";
import { beforeAll, describe, expect, it, vi } from "vitest";
import { runInNewContext } from "vm";

/** Repo root, from .github/workflows/test. */
const ROOT = join(import.meta.dirname, "..", "..", "..");
const SOURCE_FILE = ".github/workflows/arm-api-review.md";
const LOCK_FILE = ".github/workflows/arm-api-review.lock.yml";
const TARGET_EXPRESSION =
  "${{ github.event.pull_request.number || github.event.issue.number || github.event.inputs.pr_number }}";
let resolverScript = "";

/**
 * @typedef {{
 *   on?: {
 *     steps?: Array<{
 *       id?: string;
 *       with?: { script?: string };
 *     }>;
 *   };
 * }} WorkflowFrontmatter
 */

/**
 * @param {string} script
 * @param {{ value: string; eventName?: string; payload?: Record<string, unknown> }} options
 */
function createResolverHarness(script, { value, eventName = "workflow_dispatch", payload = {} }) {
  const get = vi.fn();
  const setOutput = vi.fn();
  const context = {
    eventName,
    payload,
    repo: { owner: "Azure", repo: "azure-rest-api-specs" },
  };
  const resolverValue = /** @type {unknown} */ (
    runInNewContext(`(async ({ github, context, core, process }) => {${script}\n})`)
  );
  const resolver = /** @type {(args: {
   *   github: unknown;
   *   context: unknown;
   *   core: unknown;
   *   process: unknown;
   * }) => Promise<void>} */ (resolverValue);

  return {
    get,
    setOutput,
    run: () =>
      resolver({
        github: { rest: { pulls: { get } } },
        context,
        core: { setOutput },
        process: { env: { TARGET_PR_NUMBER: value } },
      }),
  };
}

async function readWorkflowFiles() {
  return Promise.all([
    readFile(join(ROOT, SOURCE_FILE), "utf8"),
    readFile(join(ROOT, LOCK_FILE), "utf8"),
  ]);
}

beforeAll(async () => {
  const source = await readFile(join(ROOT, SOURCE_FILE), "utf8");
  const match = /^---\r?\n([\s\S]*?)\r?\n---/.exec(source);
  if (!match) {
    throw new Error("ARM API review workflow frontmatter was not found");
  }

  const frontmatter = /** @type {WorkflowFrontmatter} */ (load(match[1]));
  const resolver = frontmatter.on?.steps?.find((step) => step.id === "resolve_target_pr");
  resolverScript = resolver?.with?.script ?? "";
  if (!resolverScript) {
    throw new Error("Resolve target pull request script was not found");
  }
});

describe("ARM API review workflow", () => {
  it("resolves and validates the target PR before agent execution", async () => {
    const [source, compiled] = await readWorkflowFiles();

    expect(source).toContain("- name: Resolve target pull request");
    expect(source).toContain(`TARGET_PR_NUMBER: ${TARGET_EXPRESSION}`);
    expect(source).toContain("const { data: pull } = await github.rest.pulls.get({");
    expect(source).toContain('core.setOutput("target_pr_number", String(pull.number))');
    expect(source).toContain(
      "target_pr_number: ${{ steps.resolve_target_pr.outputs.target_pr_number }}",
    );
    expect(source).toContain(
      "**Authoritative target pull request:** `#${{ needs.pre_activation.outputs.target_pr_number }}`",
    );
    expect(source).toContain("call `report_incomplete` and stop");
    expect(source).toContain("Do not call `noop` for\n   target-resolution");

    const preActivationIndex = compiled.indexOf("\n  pre_activation:\n");
    const resolverIndex = compiled.indexOf(
      "      - name: Resolve target pull request",
      preActivationIndex,
    );
    const safeOutputsIndex = compiled.indexOf("\n  safe_outputs:\n", preActivationIndex);
    expect(preActivationIndex).toBeGreaterThan(-1);
    expect(resolverIndex).toBeGreaterThan(-1);
    expect(safeOutputsIndex).toBeGreaterThan(resolverIndex);
    expect(compiled).toContain("agent:\n    needs: activation");
    expect(compiled).toContain("activation:\n    needs: pre_activation");
    expect(compiled).toContain(
      "GH_AW_NEEDS_PRE_ACTIVATION_OUTPUTS_TARGET_PR_NUMBER: ${{ needs.pre_activation.outputs.target_pr_number }}",
    );
  });

  describe("target PR resolver", () => {
    it("resolves a workflow-dispatch target and publishes the canonical PR number", async () => {
      const harness = createResolverHarness(resolverScript, { value: "44499" });
      harness.get.mockResolvedValue({ data: { number: 44499 } });

      await harness.run();

      expect(harness.get).toHaveBeenCalledOnce();
      expect(harness.get).toHaveBeenCalledWith({
        owner: "Azure",
        repo: "azure-rest-api-specs",
        pull_number: 44499,
      });
      expect(harness.setOutput).toHaveBeenCalledWith("target_pr_number", "44499");
    });

    it("accepts an issue-shaped pull request comment payload", async () => {
      const harness = createResolverHarness(resolverScript, {
        value: "44499",
        eventName: "issue_comment",
        payload: { issue: { pull_request: { url: "https://api.github.com/pulls/44499" } } },
      });
      harness.get.mockResolvedValue({ data: { number: 44499 } });

      await harness.run();

      expect(harness.get).toHaveBeenCalledWith(expect.objectContaining({ pull_number: 44499 }));
      expect(harness.setOutput).toHaveBeenCalledWith("target_pr_number", "44499");
    });

    it("rejects an issue comment that is not attached to a pull request", async () => {
      const harness = createResolverHarness(resolverScript, {
        value: "44499",
        eventName: "issue_comment",
        payload: { issue: {} },
      });

      await expect(harness.run()).rejects.toThrow("Issue #44499 is not a pull request");
      expect(harness.get).not.toHaveBeenCalled();
      expect(harness.setOutput).not.toHaveBeenCalled();
    });

    it.each(["", "0", "-1", "1.5", " 44499", "abc"])(
      "rejects malformed target %j before calling GitHub",
      async (value) => {
        const harness = createResolverHarness(resolverScript, { value });

        await expect(harness.run()).rejects.toThrow("Invalid or missing pull request number");
        expect(harness.get).not.toHaveBeenCalled();
        expect(harness.setOutput).not.toHaveBeenCalled();
      },
    );

    it("rejects a target outside the JavaScript safe integer range", async () => {
      const harness = createResolverHarness(resolverScript, { value: "9007199254740992" });

      await expect(harness.run()).rejects.toThrow(
        "Pull request number is outside the safe integer range",
      );
      expect(harness.get).not.toHaveBeenCalled();
      expect(harness.setOutput).not.toHaveBeenCalled();
    });

    it("propagates a GitHub API failure without publishing a target", async () => {
      const harness = createResolverHarness(resolverScript, { value: "44499" });
      harness.get.mockRejectedValue(new Error("GitHub API unavailable"));

      await expect(harness.run()).rejects.toThrow("GitHub API unavailable");
      expect(harness.setOutput).not.toHaveBeenCalled();
    });
  });

  it("uses precise, observable, and authorized triggers", async () => {
    const [source, compiled] = await readWorkflowFiles();

    expect(source).toContain("github.event.comment.body == '/arm-review'");
    expect(source).not.toContain("contains(github.event.comment.body, '/arm-review')");
    expect(source).toContain('bots: ["github-actions[bot]"]');
    expect(source).toContain("status-comment: true");
    expect(source).toContain(`run-name: "ARM API Review #${TARGET_EXPRESSION}`);

    expect(compiled).toContain('GH_AW_ALLOWED_BOTS: "github-actions[bot]"');
    expect(compiled).toContain("- name: Add comment with workflow run link");
    expect(compiled).toContain("- name: Update reaction comment with completion status");
    expect(compiled).toContain(`run-name: "ARM API Review #${TARGET_EXPRESSION}`);
  });

  it("keeps ineligible comments and label events out of PR-level concurrency", async () => {
    const [source, compiled] = await readWorkflowFiles();

    for (const workflow of [source, compiled]) {
      expect(workflow).toContain("github.event.comment.body != '/arm-review'");
      expect(workflow).toContain("github.event.issue.pull_request == null");
      expect(workflow).toContain("github.event.label.name != 'WaitForARMFeedback'");
      expect(workflow).toContain("&& github.run_id || github.event.issue.number");
    }
  });

  it("wires the mandatory ARM Critic as an inline runtime subagent", async () => {
    const [source, compiled] = await readWorkflowFiles();

    expect(source).toContain(
      "## agent: `arm-api-review-critic-runtime`\n---\ndescription: Independently verifies ARM API Reviewer findings before publication\n---",
    );
    expect(source).toContain("dispatch the inline\n`arm-api-review-critic-runtime` subagent");
    expect(source).toContain("`.github/agents/arm-api-review-critic.agent.md`");
    expect(source).toContain("Never claim that the review was Critic-verified");
    expect(compiled).toContain("- name: Restore inline sub-agents from activation artifact");
    expect(compiled).toContain('GH_AW_SUB_AGENT_DIR: ".github/agents"');
    expect(compiled).toContain('GH_AW_SUB_AGENT_EXT: ".agent.md"');
  });

  it("keeps the agent read-only and preserves the human queue after a clean review", async () => {
    const [source, compiled] = await readWorkflowFiles();

    expect(source).toContain("permissions:\n    pull-requests: read\n  steps:");
    expect(source).toContain("**Blocking findings found** → add `ARMChangesRequested`, remove");
    expect(source).toContain("**No blocking findings** → leave `WaitForARMFeedback`,");
    expect(source).not.toContain("**No blocking findings** → remove `WaitForARMFeedback`");

    const activationStart = compiled.indexOf("\n  activation:\n");
    const agentStart = compiled.indexOf("\n  agent:\n");
    const preActivationStart = compiled.indexOf("\n  pre_activation:\n");
    const safeOutputsStart = compiled.indexOf("\n  safe_outputs:\n");
    const conclusionStart = compiled.indexOf("\n  conclusion:\n", agentStart);
    expect(activationStart).toBeGreaterThan(-1);
    expect(agentStart).toBeGreaterThan(-1);
    expect(preActivationStart).toBeGreaterThan(-1);
    expect(safeOutputsStart).toBeGreaterThan(-1);
    expect(conclusionStart).toBeGreaterThan(agentStart);

    const activationJob = compiled.slice(activationStart, agentStart);
    const agentJob = compiled.slice(agentStart, conclusionStart);
    const preActivationJob = compiled.slice(preActivationStart, safeOutputsStart);
    const safeOutputsJob = compiled.slice(safeOutputsStart);
    expect(activationJob).toContain("issues: write");
    expect(activationJob).not.toContain("pull-requests: write");
    expect(agentJob).toContain("contents: read");
    expect(agentJob).toContain("pull-requests: read");
    expect(agentJob).not.toContain("issues: write");
    expect(agentJob).not.toContain("pull-requests: write");
    expect(preActivationJob).toContain("pull-requests: read");
    expect(preActivationJob).not.toContain("issues: write");
    expect(safeOutputsJob).toContain("issues: write");
    expect(safeOutputsJob).toContain("pull-requests: write");
  });
});
