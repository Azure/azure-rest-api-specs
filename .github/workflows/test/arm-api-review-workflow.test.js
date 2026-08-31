import { readFile, readdir } from "fs/promises";
import { load } from "js-yaml";
import { join } from "path";
import { beforeAll, describe, expect, it, vi } from "vitest";
import { runInNewContext } from "vm";

// cspell:ignore REPOST vally

/** Repo root, from .github/workflows/test. */
const ROOT = join(import.meta.dirname, "..", "..", "..");
const SOURCE_FILE = ".github/workflows/arm-api-review.md";
const LOCK_FILE = ".github/workflows/arm-api-review.lock.yml";
const AGENT_FILE = ".github/agents/arm-api-reviewer.agent.md";
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

/**
 * Collapse runs of whitespace so prose assertions do not depend on where
 * Prettier happens to wrap a Markdown paragraph.
 *
 * @param {string} text
 */
function collapseWhitespace(text) {
  return text.replace(/\s+/g, " ");
}

/**
 * @param {unknown} value
 * @returns {value is Record<string, unknown>}
 */
function isRecord(value) {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

/**
 * @param {string} content
 * @returns {Record<string, unknown>}
 */
function parseJsonRecord(content) {
  const parsed = /** @type {unknown} */ (JSON.parse(content));
  if (!isRecord(parsed)) {
    throw new Error("Expected a JSON object");
  }
  return parsed;
}

/**
 * Remove XML/HTML comments the same way gh-aw does, so the stripping tests
 * model the real behavior rather than an approximation of it.
 *
 * A lazy `/<!--[\s\S]*?-->/g` replace is NOT equivalent and must not be used
 * here: it consumes only the innermost pair, so a nested opening tag such as
 * `<!-- <!-- --> PAYLOAD -->` leaves `PAYLOAD -->` behind, and a single pass
 * can even reassemble a fresh `<!--` out of the surrounding text. That is the
 * incomplete-multi-character-sanitization pattern CodeQL rejects. gh-aw's own
 * `removeXmlComments` (actions/setup/js/sanitize_content_core.cjs) therefore
 * scans with a depth counter and treats every `<!--` as a nesting level,
 * emitting characters only at depth zero. This mirrors that scanner.
 *
 * @param {string} text
 * @returns {string} text with every comment region removed
 */
function stripXmlComments(text) {
  let result = "";
  let depth = 0;
  let position = 0;

  while (position < text.length) {
    if (text.startsWith("<!--", position)) {
      depth++;
      position += 4;
    } else if (depth > 0 && text.startsWith("--!>", position)) {
      depth--;
      position += 4;
    } else if (depth > 0 && text.startsWith("-->", position)) {
      depth--;
      position += 3;
    } else {
      if (depth === 0) {
        result += text[position];
      }
      position++;
    }
  }

  return result;
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
    expect(collapseWhitespace(source)).toContain(
      "call `report_incomplete` and stop. Do not call `noop` for target-resolution or infrastructure failures.",
    );

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

    const statusCommentStart = compiled.indexOf("- name: Add comment with workflow run link");
    const statusCommentEnd = compiled.indexOf("\n      - name:", statusCommentStart + 1);
    const statusCommentStep = compiled.slice(statusCommentStart, statusCommentEnd);
    expect(statusCommentStep).toContain("github.event_name == 'issue_comment'");
    expect(statusCommentStep).not.toContain("pull_request_target");
    expect(statusCommentStep).not.toContain("workflow_dispatch");
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

  it("reconciles duplicates and contradictions across every review entry point", async () => {
    const [
      [source, compiled],
      reviewer,
      critic,
      protocol,
      inputTemplate,
      parity,
      skill,
      evalReadme,
    ] = await Promise.all([
      readWorkflowFiles(),
      readFile(join(ROOT, ".github/agents/arm-api-reviewer.agent.md"), "utf8"),
      readFile(join(ROOT, ".github/agents/arm-api-review-critic.agent.md"), "utf8"),
      readFile(join(ROOT, ".github/agents/protocols/arm-api-review-critic.protocol.md"), "utf8"),
      readFile(
        join(ROOT, ".github/agents/protocols/arm-api-review-critic-inputs.template.md"),
        "utf8",
      ),
      readFile(
        join(ROOT, ".github/skills/azure-api-review/references/reviewer-posted-parity.md"),
        "utf8",
      ),
      readFile(join(ROOT, ".github/skills/azure-api-review/SKILL.md"), "utf8"),
      readFile(join(ROOT, ".github/skills/evals/arm-api-reviewer/README.md"), "utf8"),
    ]);

    expect(parity).toContain("A human invokes the ARM API Reviewer in chat");
    expect(parity).toContain("The automated workflow runs when a PR is ready");
    expect(parity).toContain("posts `/arm-review`");
    expect(parity).toContain("top-level PR conversation comments");
    expect(parity).toContain("pull request review bodies");
    expect(parity).toContain("Match findings by semantic identity");
    expect(parity).toContain("Contradictions MUST use `CLARIFY-CONFLICT`");
    expect(collapseWhitespace(parity)).toContain(
      "Line movement does not make the finding new, but it does select the reconciliation action",
    );
    expect(collapseWhitespace(parity)).toContain(
      "Therefore `SKIP-COVERED` applies only when no matching inline anchor shifted",
    );
    expect(collapseWhitespace(skill)).toContain(
      "`SKIP-COVERED` for other actionable coverage, then `POST-NEW`",
    );

    expect(reviewer).toContain("Fetch the complete existing discussion inventory");
    expect(reviewer).toContain("**CLARIFY-CONFLICT.**");
    expect(collapseWhitespace(reviewer)).toContain(
      "Scenario B or C for a shifted inline anchor, Scenario A for other actionable coverage",
    );
    expect(reviewer).toContain("`reconciliation: clarification` marker");
    expect(reviewer).toContain("(<verification-status>, <N> iteration(s), <outcome>)");
    expect(reviewer).toMatch(/Critic unavailable;\s+reviewer self-check only/);
    expect(reviewer).not.toContain("(critic-verified, <N> iteration(s), <outcome>)");
    expect(critic).toContain("`FAIL: duplicate-missed`");
    expect(critic).toContain("`FAIL: conflict-unclarified`");
    expect(critic).toContain("inventory-incomplete");
    expect(critic).toContain("the canonical protocol permits a validated override");
    expect(protocol).toContain("`downstream-ci-conflict`");
    expect(protocol).not.toContain("documentation/arm-api-reviewer-insights.md");
    expect(collapseWhitespace(protocol)).toContain(
      "A = SKIP-COVERED when no matching inline anchor shifted",
    );
    expect(evalReadme).toContain(
      "per-stimulus timeout (duration; unit suffix required; default 2m)",
    );
    expect(protocol).toMatch(/`downstream-ci-conflict`[^\n]+Override allowed/);
    expect(protocol).toContain("**11 non-overridable reasons**");
    expect(protocol).toContain("review target, Session SHA, Step 6 findings report, or Step 5.5");
    expect(inputTemplate).toContain(
      "Review target, Session SHA, the Step 6 findings\nreport, and the Step 5.5 reconciliation plan or explicit sentinel are required",
    );
    expect(inputTemplate).toMatch(/\| Iteration\s+\| No\s+\| `1`/);
    expect(protocol).toContain("critic: pass|warn|override|unknown");
    expect(protocol).toContain("<RULE-ID-or-summary>");
    expect(protocol).toMatch(/`duplicate-missed`[^\n]+\*\*Yes\*\*/);
    expect(protocol).toMatch(/`conflict-unclarified`[^\n]+\*\*Yes\*\*/);
    expect(reviewer).toContain("at least one Blocking POST-NEW");
    expect(reviewer).toContain("clarification-only plans");

    expect(source).toContain("`get_review_comments` for inline threads/comments");
    expect(source).toContain("`get_comments` for top-level");
    expect(source).toContain("`get_reviews` for pull request review bodies");
    const collapsedWorkflow = collapseWhitespace(source);
    expect(collapsedWorkflow).toContain("Immediately pin both full 40-character commit SHAs");
    expect(collapsedWorkflow).toContain("Previous version: None - new service; Base SHA:");
    expect(protocol).toMatch(/Previous-version source\s+\| \*\*Required -- no default\*\*/);
    expect(critic).toContain("Inputs #1, #2, #3, #5, and #6");
    expect(source).toContain("Match by semantic finding identity");
    expect(collapseWhitespace(source)).toContain(
      "Same semantic finding, actionable coverage, no shifted inline anchor",
    );
    expect(source).toContain("author login is exactly `github-actions[bot]`");
    expect(protocol).toContain("A marker is attribution, not authentication");
    expect(collapseWhitespace(protocol)).toContain(
      "A marker-bearing comment from any other author still participates in semantic coverage",
    );
    expect(source).not.toContain("Both are agent-owned");
    expect(source).toContain("call `report_incomplete` and stop");
    for (const action of [
      "SKIP-COVERED",
      "RESOLVE-AND-REPOST",
      "REPLY-LINE-SHIFT",
      "CLARIFY-CONFLICT",
      "THANK-AND-RESOLVE",
      "PROPOSE-HUMAN-RESOLVE",
      "POST-NEW",
    ]) {
      expect(source).toContain(`| \`${action}\``);
    }
    expect(source).toContain("(<verification-status>, N iteration(s), <outcome>)");
    expect(source).toContain("Critic unavailable; reviewer self-check only");
    expect(source).not.toContain("(critic-verified, N iteration(s), <outcome>)");
    expect(compiled).toContain("reply_to_pull_request_review_comment");
    expect(compiled).toContain("resolve_pull_request_review_thread");
    expect(compiled).toContain('"add_comment"');
  });

  it("keeps the agent read-only and preserves the human queue after a clean review", async () => {
    const [source, compiled] = await readWorkflowFiles();

    expect(source).toContain("permissions:\n    pull-requests: read\n  steps:");
    expect(source).toContain(
      "**At least one Blocking `POST-NEW` or Blocking `RESOLVE-AND-REPOST` queued",
    );
    expect(source).toContain("_and_ the Critic returned a verdict**");
    expect(source).toContain("**No Blocking finding queued for publication**");
    expect(source).toContain(
      "clean, covered,\n  clarification-only, Critic-dropped, or overflow-only",
    );
    expect(source).not.toContain("**Blocking findings found**");

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

describe("ARM API review posting reliability", () => {
  it("requires a non-empty review body", async () => {
    const source = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));

    expect(source).toContain(
      "The `submit-pull-request-review` body is **REQUIRED and MUST be non-empty**.",
    );
    expect(source).toContain(
      "Never submit a review whose body is empty, whitespace-only, or a placeholder.",
    );
    // A missing field must degrade the value, never the whole body.
    expect(source).toContain("substitute `unknown` for that one value");
    expect(source).toContain(
      "Dropping the body is never an acceptable fallback for a missing field.",
    );
  });

  it("requires telemetry on standalone outputs and bans the one-field form", async () => {
    const source = await readFile(join(ROOT, SOURCE_FILE), "utf8");
    const collapsed = collapseWhitespace(source);

    expect(source).toContain(
      "### Telemetry Marker: Required on Findings, Summaries, and Clarifications",
    );
    // Every standalone output surface must be named; reply-only reconciliation
    // messages remain inside an existing marked thread.
    for (const surface of ["create-pull-request-review-comment", "add-comment"]) {
      expect(source).toContain(surface);
    }
    expect(source).not.toContain("| Reconciliation reply |");
    expect(collapsed).toContain(
      "Reply-only reconciliation messages stay inside an existing thread and do not need a finding marker.",
    );
    expect(collapsed).toContain(
      "A marker that carries only `posted-by: arm-api-reviewer-agent` and no other field is **not** a valid marker on a posted body.",
    );
    expect(collapsed).toContain("It is a defect, not a fallback");
    // Ordered degradation path, so a missing field never silently drops telemetry.
    expect(collapsed).toContain("Omit the optional fields");
    expect(collapsed).toContain("Set `critic: unknown`");
    expect(collapsed).toContain("`telemetry: degraded` field and a `reason:` field");
    expect(source).toContain(
      "_posted-by: arm-api-reviewer-agent | telemetry: degraded | reason: <one-line-summary-of-what-failed>_",
    );
  });

  it("leaves no metadata-driven exception to the ARMChangesRequested label rule", async () => {
    const source = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));

    expect(source).toContain("These three rules are **exhaustive**.");
    expect(source).toContain(
      "draft status, a `[Test]` or `[Do-Not-Merge]` title, a revert, a bot-authored PR, or the author's stated intent not to merge are **not** grounds to skip a label change",
    );
    // The decision now has exactly two inputs, not one: a Blocking finding must
    // be queued AND the Critic must have verified it. PR metadata still may not
    // influence the outcome.
    expect(source).toContain(
      "There are exactly **two** inputs to this decision: whether a Blocking finding was queued for publication, and whether the Critic verified it.",
    );
    expect(source).toContain(
      "Nothing else, and in particular nothing read from PR metadata, may change the outcome.",
    );
  });

  it("withholds ARMChangesRequested when the Critic could not verify the findings", async () => {
    const source = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));

    // Severity is preserved when the Critic is unavailable, so the label rule is
    // the compensating control: unverified Blocking findings still publish, but
    // they must not move the human ARM review queue.
    expect(source).toContain(
      "leave all three labels unchanged, **even when Blocking findings were queued**",
    );
  });

  it("preserves finding severity when the Critic is unavailable", async () => {
    const source = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));

    expect(source).toContain("**preserve each finding's original severity**");
    // The old auto-downgrade must be gone, not merely supplemented: severity may
    // not depend on which review context the PR happened to go through.
    expect(source).not.toContain("downgrade Blocking findings to Warning");
  });

  it("makes the Step 8 summary comment unconditional", async () => {
    const source = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));

    expect(source).toContain("This is **unconditional**:");
    // Reconciliation-only runs previously posted replies and resolutions but no summary.
    expect(source).toContain(
      "including runs whose only other outputs were reconciliation replies and thread resolutions",
    );
    expect(source).toContain(
      "A run that queues replies, resolutions or inline findings but no summary comment is a defect.",
    );
  });

  it("pins the scoped-review disclosure above the approval labels line", async () => {
    const source = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));

    expect(source).toContain(
      "Fill the scoped-review disclosure slot whenever **either** a scoped review ran",
    );
    expect(source).toContain("The summary block order is fixed");
    expect(source).toContain(
      "Placing the disclosure after the approval labels or after the counts table is a template violation even when its content is correct.",
    );
  });

  it("tells the agent to wrap at-mentions exactly once", async () => {
    const source = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));

    expect(source).toContain("**Autolink hygiene (REQUIRED).**");
    expect(source).toContain("in a **single** pair of backticks");
    expect(source).toContain(
      "Wrap each token exactly once: do not nest backticks, do not repeat them, and do not combine backticks with a backslash escape.",
    );
    expect(source).toContain(
      "Doubly-escaped tokens render as visible garbage in the posted comment.",
    );
  });

  it("keeps the reviewer agent consistent with the workflow's summary mandate", async () => {
    const agent = await readFile(join(ROOT, AGENT_FILE), "utf8");
    const collapsed = collapseWhitespace(agent);

    // The forbidden one-field marker must never appear verbatim in a prompt:
    // a live run reproduced exactly this shape after it was shown as an
    // anti-example.
    expect(agent).not.toContain("<!-- posted-by: arm-api-reviewer-agent -->");
    expect(collapsed).toContain("Emitting the **one-field marker form**");

    // The agent previously claimed summaries are not posted by default, which
    // contradicted the workflow's unconditional Step 8 mandate.
    expect(collapsed).not.toContain("the agent does not post summary comments by default");
    expect(collapsed).toContain("its Step 8 posts a summary comment on **every** run");
  });
});

describe("ARM API review consistency and hardening", () => {
  it("detects a truncated pull request file list", async () => {
    const source = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));

    // Pagination alone does not make the count reliable: the files endpoint is
    // hard-capped at 3,000 entries and returns no truncation flag.
    expect(source).toContain(
      "hard-caps `GET /repos/{owner}/{repo}/pulls/{number}/files` at **3,000 entries**",
    );
    expect(source).toContain("the returned entry count is exactly **3,000**");
    // A zero `changed_files` alongside a non-empty list is its own signal,
    // because GitHub zeroes the PR counters on very large diffs.
    expect(source).toContain(
      "`changed_files` is **0** while `get_files` returned a non-empty list",
    );
    expect(source).toContain("files-truncated: true");
    expect(source).toContain(
      "Never present the returned entry count as the size of the pull request.",
    );
  });

  it("reports the authoritative total in the scoped-review disclosure", async () => {
    const source = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));

    expect(source).toContain(
      "**`N` is the authoritative total PR file count, never a specification-file count and never the truncated count.**",
    );
    expect(source).toContain('write "an undetermined number of total PR files."');
    // The disclosure must name where coverage actually stopped.
    expect(source).toContain("coverage stops at <last-covered-path> in path order");
  });

  it("documents review-context parity in both prompts", async () => {
    const workflow = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));
    const agent = collapseWhitespace(await readFile(join(ROOT, AGENT_FILE), "utf8"));

    for (const source of [workflow, agent]) {
      expect(source).toContain("Review context parity");
      expect(source).toContain("**Output budgets**");
      expect(source).toContain("**Severity policy**");
      expect(source).toContain("**Default finding set**");
      expect(source).toContain("**Label policy**");
      // The human approval gate is the single intentional difference.
      expect(source).toContain("human approval gate");
    }

    // Both repositories run this workflow, so the two copies must stay
    // identical or feedback diverges by repository.
    expect(workflow).toContain("Treat any divergence between the two copies as a defect.");
  });

  it("gives the reviewer agent the same output budget as the workflow", async () => {
    const workflow = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));
    const agent = collapseWhitespace(await readFile(join(ROOT, AGENT_FILE), "utf8"));

    // One session-scoped policy guardrail.
    for (const source of [workflow, agent]) {
      expect(source).toContain("Inline comment limit: 20 per session");
      expect(source).toContain("There are no per-category caps");
      // Per-category caps gave the smallest allowance to the rarest category,
      // which is security, and bound on reviews far below any real limit.
      expect(source).toContain("security is the rarest");
      expect(source).toContain("Frequency is not importance");
    }

    expect(agent).toContain("**Output budget (identical to the automated workflow).**");
    expect(agent).toContain("disclosed **only as a count and themes**");
  });

  it("requires a non-empty review body and a visible attribution preamble in the agent", async () => {
    const agent = collapseWhitespace(await readFile(join(ROOT, AGENT_FILE), "utf8"));

    // Ported from the workflow, which already enforced this. Empty-body reviews
    // left findings with no provenance but a hidden HTML marker.
    expect(agent).toContain("This body is **REQUIRED and MUST be non-empty**");
    expect(agent).toContain("substitute `unknown` for that one value");
    expect(agent).toContain(
      "Dropping the body is never an acceptable fallback for a missing field.",
    );

    // Post-condition: re-fetch and confirm a visible preamble actually landed.
    expect(agent).toContain("**Visible-attribution post-condition (MANDATORY");
    expect(agent).toContain("does **not** satisfy this check");
    expect(agent).toContain("post the preamble template above as a **top-level PR comment**");
  });

  it("teaches PowerShell-safe gh fallbacks and caps shell-syntax retries", async () => {
    const agent = collapseWhitespace(await readFile(join(ROOT, AGENT_FILE), "utf8"));

    expect(agent).toContain("Shell fallback discipline");
    expect(agent).toContain("**Never interpolate a PR path into command text.**");
    expect(agent).toContain("[uri]::EscapeDataString");
    expect(agent).toContain("**Never inline a `jq` filter or a GraphQL query.**");
    expect(agent).toContain("[IO.Path]::GetTempPath()");
    expect(agent).toContain("remove that exact file in a `finally` block");
    expect(agent).not.toContain("Get-Content -Raw filter.jq");
    expect(agent).toContain("bare `|` inside double quotes is a **pipeline operator**");
    expect(agent).toContain("**`gh pr diff` has no `-- <pathspec>` filter.**");

    // Loop-breaker: a shell parse error is client-side and must force a tool
    // switch instead of another quoting permutation.
    expect(agent).toContain("**Shell parse error** (any step)");
    expect(agent).toContain("Cap `gh`-syntax attempts at **2 total** per objective.");

    // The agent must not prescribe the very pattern it forbids. A live session
    // looped on exactly this recipe from its own Failure Modes table.
    expect(agent).not.toContain("--jq '.[-5:][]");
  });
  it("scopes the Blocking-consensus rule so it cannot cap severity when the Critic is unavailable", async () => {
    const workflow = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));
    const agent = collapseWhitespace(await readFile(join(ROOT, AGENT_FILE), "utf8"));

    // Both files require High/Medium Critic confidence to post Blocking. With
    // the downgrade removed, an unscoped version of that rule would cap every
    // Blocking finding at Warning on a Critic-unavailable run, contradicting the
    // parity rule that severity is preserved.
    expect(workflow).toContain("When the Critic returned a verdict, post a Blocking finding only");
    expect(agent).toContain("This rule applies **only when the Critic returned a verdict**");
    expect(agent).toContain(
      "this consensus rule does **not** apply and severity is **preserved unchanged**",
    );
  });

  it("gives the label rules a single unambiguous outcome per case", async () => {
    const source = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));

    // Rule 1 and the Critic-unavailable rule both matched the case
    // (Blocking queued AND Critic unavailable) with opposite outcomes and no
    // stated precedence. Rule 1 now carries the Critic condition itself.
    expect(source).toContain(
      "**At least one Blocking `POST-NEW` or Blocking `RESOLVE-AND-REPOST` queued _and_ the Critic returned a verdict**",
    );
  });

  it("checks truncation before deciding there is nothing to review", async () => {
    const source = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));

    // `specification/` sorts after documentation/, eng/, profile/, profiles/, so
    // a >3,000-file PR can fill the window with non-spec paths. Calling noop on
    // that would silently skip a PR the agent never actually looked at.
    expect(source).toContain("**Check whether it was truncated before deciding anything**");
    expect(source).toContain("`files-truncated` is true, do **not** call `noop`");
    expect(source).toContain("call `report_incomplete`");
  });

  it("gives the Critic-unavailable disclosure a slot in the fixed summary template", async () => {
    const source = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));

    // This disclosure is the compensating control for preserving Blocking
    // severity while withholding the label, so it needs a real slot in a
    // template whose order is declared fixed.
    expect(source).toContain("<critic-unavailable caution block");
    expect(source).toContain("**Independent Critic verification did not run.**");
    expect(source).toContain("then the Critic-unavailable caution block when applicable");

    // Truncation must be able to trigger the disclosure on its own, since a PR
    // can be truncated without exceeding the size cap.
    expect(source).toContain(
      "whenever **either** a scoped review ran (Trigger Validation step 4) **or** Trigger Validation step 3 recorded `files-truncated: true`",
    );
  });

  it("keeps the agent's overflow disclosure on a surface that actually exists", async () => {
    const [workflow, agent, protocol] = await Promise.all([
      readFile(join(ROOT, SOURCE_FILE), "utf8"),
      readFile(join(ROOT, AGENT_FILE), "utf8"),
      readFile(join(ROOT, ".github/agents/protocols/arm-api-review-critic.protocol.md"), "utf8"),
    ]);
    const collapsedAgent = collapseWhitespace(agent);

    // The interactive agent posts no summary comment by default, so the
    // review-body preamble is the only always-present surface. Over-cap
    // candidates also need a legal action token, or they get posted (breaking
    // the cap) or dropped (breaking the disclosure).
    expect(collapsedAgent).toContain("OVERFLOW-NOT-POSTED");
    expect(collapsedAgent).toContain("this agent does not post a summary comment by default");
    expect(collapsedAgent).toContain("never rendered as canonical finding bodies");
    expect(collapsedAgent).toContain(
      "<overflow disclosure -- include only when candidates were excluded by the 20-comment limit; omit otherwise>",
    );
    expect(workflow.match(/<overflow disclosure -- include only/g)).toHaveLength(2);

    // There is one 20-comment limit. These phrases belonged to the discarded
    // 50-comment/per-category design and would create a second overflow path.
    const allSurfaces = [workflow, agent, protocol].join("\n");
    expect(allSurfaces).not.toContain("50-comment budget");
    expect(allSurfaces).not.toContain("excluded by a category cap");
    expect(allSurfaces).not.toContain("beyond a per-category cap");
    expect(allSurfaces).not.toContain("per-category output budgets");
    expect(allSurfaces).not.toContain("cap bucket");
  });

  it("limits the oversized interactive agent to local interactive hosts", async () => {
    const agent = await readFile(join(ROOT, AGENT_FILE), "utf8");
    const frontmatterEnd = agent.indexOf("\n---\n", 4);
    expect(frontmatterEnd).toBeGreaterThan(4);
    const frontmatter = agent.slice(4, frontmatterEnd);
    const body = agent.slice(frontmatterEnd + 5);

    // GitHub.com rejects custom-agent bodies over 30,000 characters. The
    // vscode target is used by VS Code and local GitHub Copilot app sessions;
    // advertising github-copilot would expose a profile the cloud host cannot
    // load until #45843 extracts this workflow.
    expect(body.length).toBeGreaterThan(30_000);
    expect(frontmatter).toMatch(/^target: vscode$/m);
    expect(frontmatter).toContain("GitHub Copilot app");
    expect(frontmatter).toContain("GitHub.com Copilot cloud");
  });

  it("supports full local specification reviews across Reviewer and Critic", async () => {
    const [reviewer, critic, protocol, template] = await Promise.all([
      readFile(join(ROOT, AGENT_FILE), "utf8"),
      readFile(join(ROOT, ".github/agents/arm-api-review-critic.agent.md"), "utf8"),
      readFile(join(ROOT, ".github/agents/protocols/arm-api-review-critic.protocol.md"), "utf8"),
      readFile(
        join(ROOT, ".github/agents/protocols/arm-api-review-critic-inputs.template.md"),
        "utf8",
      ),
    ]);
    const normalizedReviewer = collapseWhitespace(reviewer);
    const normalizedCritic = collapseWhitespace(critic);
    const combined = collapseWhitespace(`${reviewer}\n${critic}\n${protocol}\n${template}`);

    expect(reviewer).toContain("### Local workspace review mode");
    expect(reviewer).toContain("A directory request is a full review");
    expect(reviewer).toContain("Include untracked and uncommitted files");
    expect(reviewer).toContain("local-sha256:<64-lowercase-hex>");
    expect(normalizedReviewer).toContain(
      "every reviewed file, every previous-version source, and every applicable blob from the recorded Git `HEAD`",
    );
    expect(normalizedReviewer).toContain(
      "When the target modifies an API version already present at Git `HEAD`, also inspect the read-only `git diff` against `HEAD`",
    );
    expect(normalizedReviewer).toContain("Step 5.5 input is the literal `reconciliation skipped`");
    expect(normalizedReviewer).toContain(
      "Omit approval-context paragraphs, posting actions, reconciliation tables, and per-comment telemetry markers",
    );
    expect(reviewer).toContain("Do not show the Step 8 posting menu");

    expect(critic).toContain("For `Review target: local workspace: <absolute-target>`");
    expect(normalizedCritic).toContain("compute each SHA-256 content hash");
    expect(normalizedCritic).toContain("approval labels and approval-context paragraphs are");
    expect(protocol).toContain("### Local source binding");
    expect(protocol).toContain("`<role>\\t<repo-relative-path>\\t<lowercase-file-sha256>`");
    expect(protocol).toContain("`metadata\\trepository-head\\t<full-40-char-HEAD-sha>`");
    expect(protocol).toContain("join them with LF and");
    expect(protocol).toContain("the `pr` field in both markers is `local:<target-path-digest>`");
    expect(protocol).toContain("`local:<64-lowercase-hex>`");
    expect(normalizedReviewer).toContain(
      "The previous API version is authoritative for `[NEW]` versus `[EXISTING]`",
    );
    expect(normalizedCritic).toContain("The previous-version result is authoritative");
    expect(normalizedCritic).toContain(
      "require the current path/role set to exactly match the supplied manifest",
    );
    expect(normalizedCritic).toContain("current Git `HEAD` equals the recorded Input #5 value");
    expect(template).toContain("Repository HEAD: <full-40-char-sha>");
    expect(template).toContain(
      "Source manifest: <reviewed|previous-version|head>:<source>@sha256:<hash>",
    );
    expect(collapseWhitespace(template)).toContain(
      "For a local compact dispatch, use `Review target: local workspace: <absolute-target>`",
    );
    expect(collapseWhitespace(template)).toContain(
      "Previous version: <path or None - new service>; Base SHA: <full-40-char-base-sha>",
    );
    expect(collapseWhitespace(template)).toContain(
      "repeat `Previous version: <path/hash or None - new service>; Repository HEAD: <full-40-char-sha>`",
    );
    expect(normalizedReviewer).toContain(
      "This replacement overrides every mutation instruction in the remainder of Step 10",
    );
    expect(normalizedReviewer).toContain(
      "After a local review, use only Step 10's read-only snapshot verification and never remove branches, worktrees, or files",
    );
    expect(normalizedReviewer).toContain("Branch names are mutable and are not valid bindings");
    expect(reviewer).toContain("**Template A, local review variant:**");
    expect(reviewer).toContain(
      "re-run from Step 1 against the current on-disk content and pin a fresh local snapshot",
    );
    expect(template).toContain("Review target: local workspace: <absolute-file-or-directory>");
    expect(combined).toContain("session-sha-moved");
  });

  it("documents VS Code and GitHub Copilot app interactive review when docs are checked out", async () => {
    let docs;
    try {
      docs = await readFile(join(ROOT, "documentation/api-reviewer-agent.md"), "utf8");
    } catch (error) {
      // The .github CI job uses sparse checkout and intentionally omits
      // documentation/**. Other repository checks validate the docs.
      if (isRecord(error) && error.code === "ENOENT") return;
      throw error;
    }

    expect(docs).toContain(
      "interactive custom agent for Visual Studio Code\nand the GitHub Copilot app",
    );
    expect(docs).toContain("## Reviewing a Local Specification");
    expect(docs).toContain(
      String.raw`Review C:\repos\azure-rest-api-specs\specification\contoso\resource-manager\Microsoft.Contoso`,
    );
    expect(docs).not.toMatch(/AzureArcData|azurearcdata/);
    expect(docs).not.toContain("@reviewer");
    expect(docs).toContain("Uncommitted files are included");
    expect(docs).toContain(
      "performs the same\n   breaking-change and `[NEW]`/`[EXISTING]` analysis used for PR reviews",
    );
    expect(docs).toContain(
      "Invokes the ARM API Review Critic to independently re-read the same local",
    );
    expect(docs).not.toContain(
      "Review local files or uncommitted changes -- it operates on PRs only",
    );
  });

  it("supports rule guidance without starting a review session", async () => {
    const reviewer = await readFile(join(ROOT, AGENT_FILE), "utf8");

    expect(reviewer).toContain("**Rule guidance:**");
    expect(reviewer).toContain(
      "Do not start the review workflow or invoke the Critic unless the answer",
    );
  });

  it("carves the post-condition out of the Step 8 no-re-fetch rule", async () => {
    const agent = collapseWhitespace(await readFile(join(ROOT, AGENT_FILE), "utf8"));

    // Step 8 declares its own exception list exhaustive, so the new
    // post-condition needed an explicit carve-out the way the session-SHA
    // recheck already has one.
    expect(agent).toContain("A second exception is the **Visible-attribution post-condition**");
    expect(agent).toContain("a verification read, not plan re-derivation");
  });

  it("names both recorded human deviations in the parity sections", async () => {
    const workflow = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));
    const agent = collapseWhitespace(await readFile(join(ROOT, AGENT_FILE), "utf8"));

    // MANUAL DECISION REQUIRED lets a human approve posting a finding the
    // automated run would drop, without an override marker. Claiming the
    // override is the only deviation was inaccurate.
    for (const source of [workflow, agent]) {
      expect(source).toContain("escalate to `MANUAL DECISION REQUIRED`");
      expect(source).toContain("Both are explicit, recorded human actions");
    }
  });
  it("pins the model so every run reviews with the same one", async () => {
    const [source, compiled] = await readWorkflowFiles();

    // Left unpinned the model resolves to `... || 'auto'`, which can pick a
    // different model per run, so identical specs could get different feedback.
    // The value has to be one the AWF api-proxy prices: an unpriced model is
    // rejected with a 400 before the agent runs at all, which took down every
    // run when this was briefly pinned to claude-opus-5.
    expect(source).toMatch(/^model: gpt-5\.6-sol\?effort=high$/m);

    // The compiled lock must carry literals, not a `vars.` fallback expression.
    expect(compiled).toContain("COPILOT_MODEL: gpt-5.6-sol?effort=high");
    expect(compiled).not.toContain("COPILOT_MODEL: ${{ vars.GH_AW_MODEL_AGENT_COPILOT");
  });

  it("keeps the eval suite on the same model as production", async () => {
    const dir = join(ROOT, ".github/skills/evals/arm-api-reviewer/vally");
    const files = (await readdir(dir)).filter((f) => f.endsWith(".yaml"));
    expect(files.length).toBeGreaterThan(0);

    for (const file of files) {
      const text = await readFile(join(dir, file), "utf8");
      // The agent under test must match the production model, or eval results
      // describe a model that never reviews a real PR. Anchored to the line
      // start because plain `model:` also matches `judge_model:`.
      expect(text, `${file} agent model`).toMatch(/^\s*model: gpt-5\.6-sol\?effort=high$/m);
      // The judge is a separate role and deliberately stays cheaper.
      expect(text, `${file} judge model`).toContain("judge_model: claude-sonnet-4.6");
    }
  });
  it("routes findings to a drop group by recorded category, not by rule ID", async () => {
    const workflow = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));
    const agent = collapseWhitespace(await readFile(join(ROOT, AGENT_FILE), "utf8"));

    // The drop groups are coarser than the tracked categories. The mapping is
    // canonical in the protocol, and the workflow defers to it rather than
    // keeping a second copy that could drift.
    expect(workflow).toContain("Which drop group a finding belongs to");
    expect(workflow).toContain("Finding categories");
    expect(workflow).toContain("never decide it by re-reading the rule ID");
    expect(workflow).toContain("unit of **measurement**");

    expect(workflow).toContain(
      "**Where the limit comes from.** Twenty is a reviewed policy guardrail",
    );
    expect(agent).toContain("reviewed per-session policy guardrail");
  });

  it("documents the limit without unverifiable telemetry claims", async () => {
    const workflow = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));

    expect(workflow).toContain("Inline comment limit: 20 per session");
    expect(workflow).not.toContain("median 2, mean 3.72");
    expect(workflow).not.toContain("pull request 43894");
    expect(workflow).toContain("The limit is per session");
  });

  it("trims only above the limit, and trims security last", async () => {
    const workflow = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));
    const agent = collapseWhitespace(await readFile(join(ROOT, AGENT_FILE), "utf8"));

    // Per-category caps bound on tiny reviews: three security findings and
    // nothing else posted two and buried one, with nothing under pressure.
    for (const source of [workflow, agent]) {
      expect(source).toContain("There are no per-category caps");
      expect(source).toContain("Frequency is not importance");
    }
    expect(workflow).toContain("At 20 or fewer, post every finding");
    expect(workflow).toContain("With more than 20, trim to fit and disclose");
    expect(workflow).not.toContain("Below 20");
    expect(workflow).not.toContain("Above 20");
    expect(workflow).toContain("Do not trim a small review");

    // Drop order must put the rarest, highest-consequence category last.
    const dropOrder = workflow.indexOf("dropping in this order");
    const docsPos = workflow.indexOf("documentation-and-examples", dropOrder);
    const secPos = workflow.indexOf("security-and-secrets", dropOrder);
    expect(docsPos).toBeGreaterThan(-1);
    expect(secPos).toBeGreaterThan(docsPos);
    expect(workflow).toContain("trimmed **last**");
  });
  it("defines a closed category vocabulary and records it on every finding", async () => {
    const protocol = await readFile(
      join(ROOT, ".github/agents/protocols/arm-api-review-critic.protocol.md"),
      "utf8",
    );
    const workflow = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));
    const agent = collapseWhitespace(await readFile(join(ROOT, AGENT_FILE), "utf8"));

    // Categories must be recorded at emit time. Without this field, per-category
    // volume can only be re-derived by hand-classifying rule IDs, which is what
    // made the caps unverifiable in the first place.
    expect(protocol).toContain("### Finding categories");
    for (const slug of [
      "schema-and-property-design",
      "naming-enums-and-identifiers",
      "sdk-and-client-impact",
      "resource-modeling",
      "operations-and-http-semantics",
      "long-running-operations",
      "suppressions-and-tooling",
      "review-readiness-and-ci",
      "documentation-and-examples",
      "versioning-and-compatibility",
      "security-and-secrets",
    ]) {
      expect(protocol, `missing category: ${slug}`).toContain(slug);
    }
    // Closed vocabulary: no escape hatch that would reintroduce uncategorized
    // findings invisible to both the caps and the telemetry.
    expect(protocol).toContain("There is no `other` value");

    // The marker carries it, on both surfaces.
    expect(workflow).toContain("| category: <category-slug> |");
    expect(agent).toContain("| category: <category-slug> |");

    // Bucketing is driven by the category, not by re-reading the rule ID.
    expect(workflow).toContain("never decide it by re-reading the rule ID");
  });
  it("documents that the model is pinned only on the unattended path", async () => {
    const workflow = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));
    const agent = collapseWhitespace(await readFile(join(ROOT, AGENT_FILE), "utf8"));

    // The interactive agent has no `model:` frontmatter field on purpose: it
    // runs on whatever the reviewer has in VS Code, so pinning would fail for
    // anyone without access to that model. Parity must not claim otherwise.
    expect(agent).not.toMatch(/^model:/m);
    for (const source of [workflow, agent]) {
      expect(source).toContain("would simply fail for anyone without access to it");
      expect(source).toContain("runs on whatever model");
    }
    // The workflow states its own side of the difference explicitly.
    expect(workflow).toContain("This workflow pins one, so its runs are reproducible");
  });

  it("keeps the parity budget bullet in step with the actual limit", async () => {
    const workflow = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));
    const agent = collapseWhitespace(await readFile(join(ROOT, AGENT_FILE), "utf8"));

    // The bullet described per-category caps and a 50-comment budget after both
    // had been replaced by a single 20-per-session limit.
    for (const source of [workflow, agent]) {
      expect(source).toContain("the same 20-comment per-session limit");
    }
    expect(workflow).not.toContain("the same per-category inline caps");
    expect(agent).not.toContain("per-category caps and 50-comment inline budget");
  });
});

describe("ARM API review live-run regressions", () => {
  // Every assertion below encodes a deviation observed on live run
  // 31635310062 (`/arm-review` on a fork PR), where the agent job succeeded
  // and emitted a full safe-output set that nonetheless broke the template.

  it("requires the telemetry marker to be a single plain-text line, not an HTML comment", async () => {
    const source = await readFile(join(ROOT, SOURCE_FILE), "utf8");
    const collapsed = collapseWhitespace(source);

    // Originally this asserted the marker must be a single-line HTML comment,
    // to stop the run emitting bare `key: value` lines. Live run 31646990677
    // disproved that premise: the agent emitted a perfect HTML-comment marker
    // and the publisher's sanitizer deleted it outright, so the published
    // comment carried no telemetry at all. Single-line is still required; HTML
    // comment is now forbidden.
    expect(collapsed).toContain("**Marker syntax is literal and non-negotiable.**");
    expect(collapsed).toContain("single plain-text line");
    expect(collapsed).toContain("**Never write the marker as an HTML comment.**");

    // A correct/incorrect pair must exist outside the canonical template so the
    // syntax is stated, not merely demonstrated inside a fenced block.
    expect(collapsed).toContain(
      "Incorrect (HTML comment -- deleted by the sanitizer before publication)",
    );
    expect(collapsed).toContain("Incorrect (fields split across lines -- cannot be parsed)");
  });

  it("requires all seven marker fields on the summary, not a reduced form", async () => {
    const source = await readFile(join(ROOT, SOURCE_FILE), "utf8");
    const collapsed = collapseWhitespace(source);

    // The run's summary marker carried only `rule:` and `posted-by:`.
    expect(collapsed).toContain(
      "All seven fields are **required on every finding and summary marker**",
    );
    expect(collapsed).toContain(
      "`posted-by`, `rule`, `category`, `severity`, `classification`, `critic`, and `head-sha`",
    );
    expect(collapsed).toContain("The summary's marker is not a reduced form");
  });

  it("uses the minimal marker when the full head SHA is unavailable", async () => {
    const protocol = collapseWhitespace(
      await readFile(
        join(ROOT, ".github/agents/protocols/arm-api-review-critic.protocol.md"),
        "utf8",
      ),
    );

    // A full marker without head-sha contradicts the seven-field schema. The
    // agent and protocol eval already use the degraded form for this case.
    expect(protocol).toContain(
      "fall back to the minimal marker with `reason: head-sha-unavailable`",
    );
    expect(protocol).not.toContain("omit `head-sha` rather than violate");
  });

  it("constrains the critic field to pass, warn, or unknown", async () => {
    const source = await readFile(join(ROOT, SOURCE_FILE), "utf8");
    const collapsed = collapseWhitespace(source);

    // The run emitted `critic: verified-high`, which is not a legal value.
    expect(collapsed).toContain("`critic:` accepts exactly one of `pass`, `warn`, or `unknown`");
    expect(collapsed).toContain("for example `verified-high`");
  });

  it("declares a marker surface for the review body", async () => {
    const source = await readFile(join(ROOT, SOURCE_FILE), "utf8");
    const bodyTemplate = source.match(
      /Use this body for `submit-pull-request-review`:[\s\S]*?```text([\s\S]*?)```/,
    )?.[1];

    expect(collapseWhitespace(source)).toContain(
      "| Review body | `submit-pull-request-review` | `summary` |",
    );
    expect(bodyTemplate).toContain(
      "_posted-by: arm-api-reviewer-agent | rule: summary | category: summary",
    );
  });

  it("puts the summary marker inside the interactive review-body template", async () => {
    const agent = await readFile(join(ROOT, AGENT_FILE), "utf8");
    const template = agent.match(/\*\*Review-body preamble[\s\S]*?```markdown([\s\S]*?)```/)?.[1];

    expect(template).toContain(
      "<!-- posted-by: arm-api-reviewer-agent | rule: summary | category: summary",
    );
  });

  it("puts the scoped-review disclosure slot inside the summary template", async () => {
    const source = await readFile(join(ROOT, SOURCE_FILE), "utf8");
    const collapsed = collapseWhitespace(source);

    // Prose alone did not hold: the run appended the disclosure after the
    // counts table. The slot must appear in the fenced template itself, between
    // the "Reviewed PR" line and the "Approval labels observed" line.
    const template = source.slice(
      source.indexOf("## ARM API Review Summary"),
      source.indexOf("<one-sentence summary of key themes"),
    );
    expect(template).toContain("<scoped-review disclosure line");
    expect(template.indexOf("<scoped-review disclosure line")).toBeLessThan(
      template.indexOf("Approval labels observed"),
    );

    // And the lead-in must be the literal `**Scoped review:**`, not a variant.
    expect(collapsed).toContain("for example `**Scope note:**`");
    expect(collapsed).toContain(
      "Placing the disclosure after the approval labels or after the counts table is a template violation",
    );
  });

  it("routes findings on unchanged files to the summary instead of inline", async () => {
    const source = await readFile(join(ROOT, SOURCE_FILE), "utf8");
    const collapsed = collapseWhitespace(source);

    // The live run queued an inline comment on a readme.md that the PR never
    // touched. The publisher dropped it with only a warning and still reported
    // `Failed: 0`, so the Warning finding vanished while the summary counted it.
    expect(collapsed).toContain("**Inline comments must target a file in the PR diff.**");
    expect(collapsed).toContain("silently dropped with a warning");
    expect(collapsed).toContain("**`Findings on unchanged files`**");
    expect(collapsed).toContain(
      "Count it in the summary's category table exactly as if it had been posted inline",
    );
  });

  it("keeps the review body's finding range honest", async () => {
    const source = await readFile(join(ROOT, SOURCE_FILE), "utf8");
    const collapsed = collapseWhitespace(source);

    // The live review body said "See inline comments for findings 1-2" when
    // only finding 1 was ever published.
    expect(collapsed).toContain(
      "must enumerate only findings that were actually queued as inline comments",
    );
    expect(collapsed).toContain("All findings are reported in the summary comment.");
  });

  it("teaches a marker form that survives both prompt rendering and publication", async () => {
    const source = await readFile(join(ROOT, SOURCE_FILE), "utf8");

    // Two independent sanitizers bracket this marker, and they pull in
    // opposite directions:
    //
    //  1. The gh-aw compiler strips HTML comments out of the PROMPT. Live run
    //     31645723290 proved it -- 16 `<!--` in the source, zero in the
    //     rendered prompt -- so a marker template written as a real HTML
    //     comment arrives blank and teaches the agent nothing.
    //  2. The safe-output publisher (`removeXmlComments` in
    //     sanitize_content_core.cjs) strips HTML comments out of every BODY
    //     the agent emits, with no code-fence exemption. Live run
    //     31646990677 proved it: the agent emitted a flawless single-line
    //     HTML-comment marker into safeoutputs.jsonl and the published
    //     comment carried no marker at all.
    //
    // So the marker cannot be an HTML comment on either side. It must be
    // plain text, which survives both.
    const stripped = stripXmlComments(source);
    const collapsedStripped = collapseWhitespace(stripped);

    expect(collapsedStripped).toContain("Never write the marker as an HTML comment.");
    expect(collapsedStripped).toContain("silently discarded");

    // Full marker templates must survive prompt stripping intact and carry all
    // seven fields. The explicit telemetry-degraded fallback has its own
    // smaller schema.
    const templates = [
      ...collapsedStripped.matchAll(/_posted-by: arm-api-reviewer-agent[^`\n]*?_/g),
    ];
    expect(templates.length).toBeGreaterThanOrEqual(3);
    for (const [template] of templates) {
      if (template.includes("telemetry: degraded")) {
        expect(template).toContain("reason:");
        continue;
      }
      for (const field of [
        "rule:",
        "category:",
        "severity:",
        "classification:",
        "critic:",
        "head-sha:",
      ]) {
        expect(template).toContain(field);
      }
      expect(template).not.toContain("<!--");
    }
    expect(collapsedStripped).toContain(
      "_posted-by: arm-api-reviewer-agent | telemetry: degraded | reason:",
    );

    // No marker template may be written as a literal HTML comment anywhere in
    // the source: it would be erased on the way to the agent, and copying it
    // would get the published marker erased too.
    expect(source).not.toContain("<!-- posted-by: arm-api-reviewer-agent");

    // The reconciliation reader must still recognize the legacy HTML form,
    // because interactive agent sessions bypass the publishing sanitizer.
    expect(collapseWhitespace(source)).toContain(
      "accept either the visible workflow form or the interactive HTML-comment form",
    );
  });

  it("strips nested comment tags the way gh-aw actually does", () => {
    // Guards the stripping simulation itself. The obvious lazy regex
    // (`/<!--[\s\S]*?-->/g`) consumes only the innermost pair and leaves the
    // payload exposed, which is why gh-aw counts nesting depth instead. If the
    // simulation ever regresses to the regex, the stripping test above would
    // silently start asserting against content the real sanitizer removes.
    expect(stripXmlComments("<!-- <!-- --> PAYLOAD -->")).toBe("");
    expect(stripXmlComments("keep<!-- drop -->keep")).toBe("keepkeep");
    expect(stripXmlComments("<!-- malformed --!>tail")).toBe("tail");
    expect(stripXmlComments("no comments here")).toBe("no comments here");

    // An unclosed opening tag swallows the rest, exactly as the depth scanner
    // does -- it never re-emits buffered comment text.
    expect(stripXmlComments("head<!-- never closed")).toBe("head");

    // And the result is stable: stripping twice changes nothing.
    const once = stripXmlComments("<!-- <!-- --> PAYLOAD --> visible");
    expect(stripXmlComments(once)).toBe(once);
  });

  it("keeps protocol evals connected to the agent and current marker schema", async () => {
    const evalSpec = await readFile(
      join(ROOT, ".github/skills/evals/arm-api-reviewer/vally/eval-protocol-safety.yaml"),
      "utf8",
    );

    // The protocol-only scenarios used to restate the expected answer without
    // exposing the changed agent files, so they could pass while the agent
    // regressed. The files are now available in each eval workspace.
    expect(evalSpec).toContain('src: "../../../../agents/arm-api-reviewer.agent.md"');
    expect(evalSpec).toContain(
      'src: "../../../../agents/protocols/arm-api-review-critic.protocol.md"',
    );

    // `category` became required after these fixtures were first written. Any
    // literal full-marker example without it teaches and accepts stale output.
    const fullMarkers = [
      ...evalSpec.matchAll(/<!-- posted-by: arm-api-reviewer-agent \| rule:[\s\S]*?-->/g),
    ];
    expect(fullMarkers.length).toBeGreaterThanOrEqual(5);
    for (const [marker] of fullMarkers) {
      expect(marker).toMatch(/\|\s*category:/);
    }
  });
});

describe("API version lifecycle rules", () => {
  const REFERENCE_FILE =
    ".github/skills/azure-api-review/references/api-version-lifecycle-and-branches.md";

  it("wires the reference into the ARM instructions both paths load", async () => {
    // The workflow and the interactive agent never read this reference
    // directly; they reach it through arm-api-review.instructions.md, which
    // both of them load. If the pointer is dropped, the rules become
    // unreachable on every path while the file still sits in the repo.
    const instructions = collapseWhitespace(
      await readFile(join(ROOT, ".github/instructions/arm-api-review.instructions.md"), "utf8"),
    );

    expect(instructions).toContain("api-version-lifecycle-and-branches.md");

    const [workflow, agent] = await Promise.all([
      readFile(join(ROOT, SOURCE_FILE), "utf8"),
      readFile(join(ROOT, AGENT_FILE), "utf8"),
    ]);
    expect(workflow).toContain("arm-api-review.instructions.md");
    expect(agent).toContain("arm-api-review.instructions.md");
  });

  it("keeps only the in-development rule branch-dependent", async () => {
    // A release-* branch is a legitimate home for work that would be a
    // violation on main, and the workflow prompt never names base.ref. Without
    // an explicit skip, an unknown branch defaults to the worst reading and
    // the agent posts a Blocking finding against a perfectly valid PR.
    const reference = collapseWhitespace(await readFile(join(ROOT, REFERENCE_FILE), "utf8"));

    expect(reference).toContain("base.ref");
    expect(reference).toMatch(/skip that rule rather than assuming/i);
    expect(reference).toContain("APIVER-DEV-IN-MAIN");
    expect(reference).toContain("APIVER-PRIVATE-IN-PUBLIC");
    expect(reference).toMatch(/private preview is prohibited from every branch/i);
    expect(reference).toContain("APIVER-PRIVATE-FOLDER");
    expect(reference).toContain(
      "private-preview version in the private repository **MUST** sit under `preview/` and end in `-preview`",
    );
    expect(reference).toMatch(
      /folder rules, APIVER-PRIVATE-FOLDER, APIVER-GA-FOLDER, and\s+APIVER-PREVIEW-FOLDER, need no branch/,
    );
  });

  it("does not treat a private-to-public promotion as a leak", async () => {
    // Copying specs from the private repo to the public repo is exactly how a
    // private preview becomes a public preview, so a bare "this version was
    // private" check would flag every legitimate promotion PR. The carve-out
    // and the fix link have to survive in the instructions text too, because
    // that is what both review paths actually load.
    const [reference, instructions] = await Promise.all([
      readFile(join(ROOT, REFERENCE_FILE), "utf8"),
      readFile(join(ROOT, ".github/instructions/arm-api-review.instructions.md"), "utf8"),
    ]);

    expect(collapseWhitespace(reference)).toMatch(/promotion, not a leak/i);
    expect(reference).toContain("aka.ms/azsdk/move-pr");
    expect(collapseWhitespace(instructions)).toMatch(/not\*{0,2} a violation/i);
    expect(instructions).toContain("aka.ms/azsdk/move-pr");
  });

  it("uses a category slug the Critic marker vocabulary accepts", async () => {
    // Findings carry a category into the telemetry marker, and the Critic
    // rejects any value outside its closed vocabulary. A reference that names
    // a slug the protocol does not define produces findings that fail
    // verification for a reason unrelated to their substance.
    const [reference, protocol] = await Promise.all([
      readFile(join(ROOT, REFERENCE_FILE), "utf8"),
      readFile(join(ROOT, ".github/agents/protocols/arm-api-review-critic.protocol.md"), "utf8"),
    ]);

    const declared = reference.match(/`([a-z-]+)` category/)?.[1];
    expect(declared, "reference must name its category").toBeDefined();
    expect(protocol).toContain(`\`${declared}\``);
  });
});

describe("TypeSpec requirement and version ordering guidance", () => {
  const INSTRUCTIONS = ".github/instructions/arm-api-review.instructions.md";

  it("gives TSP-REQUIRED-V1 a fix path and forecloses the legacy exemption", async () => {
    // TSP-REQUIRED-V1 is Blocking and is resolved by an out-of-band conversion
    // that is invisible in the diff, so a finding without the conversion link
    // leaves the author with no route to comply. The exemption clause exists
    // because "our service is old" is the predictable pushback, and it is not
    // a valid one.
    const instructions = collapseWhitespace(await readFile(join(ROOT, INSTRUCTIONS), "utf8"));

    expect(instructions).toContain("aka.ms/convert-to-typespec");
    expect(instructions).toMatch(/no legacy exemption/i);
  });

  it("requires a new version to post-date every existing version", async () => {
    // The adjacent rules only cover preview-to-GA promotion and edits to a
    // published version, so without this a back-dated brand-new preview passes
    // every date check the reviewer applies.
    const instructions = collapseWhitespace(await readFile(join(ROOT, INSTRUCTIONS), "utf8"));

    expect(instructions).toMatch(/later date than every API version the service already has/i);
  });
});

describe("ARM paging and example enum calibration", () => {
  it("allows RPC paging parameters while preserving point GET strictness", async () => {
    const [instructions, reference, critic, linterCoverage] = await Promise.all([
      readFile(join(ROOT, ".github/instructions/arm-api-review.instructions.md"), "utf8"),
      readFile(
        join(ROOT, ".github/skills/azure-api-review/references/tracked-resource-lifecycle.md"),
        "utf8",
      ),
      readFile(join(ROOT, ".github/agents/arm-api-review-critic.agent.md"), "utf8"),
      readFile(
        join(ROOT, ".github/skills/azure-api-review/references/linter-rule-coverage.md"),
        "utf8",
      ),
    ]);
    const combined = [instructions, reference, critic, linterCoverage].join("\n");

    expect(combined).not.toContain("RPC-Get-V1-15");
    expect(reference).toContain("`$top`");
    expect(reference).toContain("`$skipToken`");
    expect(reference).toMatch(/Other custom query parameters.*\*\*Warning\*\*/s);
    expect(reference).toMatch(/Point GET is unchanged.*\*\*Blocking\*\* RPC-Get-V1-08/s);
    expect(critic).toMatch(/only claim is that either parameter is\s+forbidden/);
    expect(critic).toMatch(/Do not drop a finding about malformed type/);
    expect(linterCoverage).toContain("false-positives on RPC-defined `$top` and `$skipToken`");
  });

  it("uses the four-case EX-PAYLOAD enum severity matrix everywhere", async () => {
    const [instructions, reference, critic] = await Promise.all([
      readFile(join(ROOT, ".github/instructions/openapi-review.instructions.md"), "utf8"),
      readFile(join(ROOT, ".github/skills/azure-api-review/references/example-quality.md"), "utf8"),
      readFile(join(ROOT, ".github/agents/arm-api-review-critic.agent.md"), "utf8"),
    ]);

    for (const source of [instructions, reference]) {
      const collapsed = collapseWhitespace(source);
      expect(collapsed).toMatch(
        /Response body, ordinary property \| `modelAsString: true` \| (?:\*\*)?Warning(?:\*\*)?/,
      );
      expect(collapsed).toMatch(
        /Response body, ordinary property \| `modelAsString: false` \| (?:\*\*)?Blocking(?:\*\*)?/,
      );
      expect(collapsed).toMatch(
        /Required polymorphic discriminator \| Either \| (?:\*\*)?Blocking(?:\*\*)?/,
      );
      expect(collapsed).toMatch(
        /Request path or query parameter \| Either \| (?:\*\*)?Blocking(?:\*\*)?/,
      );
    }
    expect(critic).toMatch(/downgrade to Warning unless the value is a required discriminator/);
  });

  it("keeps all new JSON fixtures parseable", async () => {
    const fixtureRoot = join(ROOT, ".github/skills/evals/arm-api-reviewer/fixtures");
    const fixtures = (await readdir(fixtureRoot, { recursive: true })).filter((file) =>
      file.endsWith(".json"),
    );

    for (const fixture of fixtures) {
      const content = await readFile(join(fixtureRoot, fixture), "utf8");
      expect(() => {
        JSON.parse(content);
      }, fixture).not.toThrow();
    }
  });

  it("keeps the eval catalog counts aligned with 87 scenarios and 57 fixtures", async () => {
    const evalDir = join(ROOT, ".github/skills/evals/arm-api-reviewer/vally");
    const evalFiles = (await readdir(evalDir)).filter((file) => file.endsWith(".yaml"));
    let stimulusCount = 0;

    for (const file of evalFiles) {
      const parsed = /** @type {{ stimuli?: unknown[] }} */ (
        load(await readFile(join(evalDir, file), "utf8"))
      );
      stimulusCount += parsed.stimuli?.length ?? 0;
    }

    const readme = await readFile(
      join(ROOT, ".github/skills/evals/arm-api-reviewer/README.md"),
      "utf8",
    );
    const fixtureEntries = await readdir(
      join(ROOT, ".github/skills/evals/arm-api-reviewer/fixtures"),
      { recursive: true, withFileTypes: true },
    );
    expect(evalFiles).toHaveLength(18);
    expect(stimulusCount).toBe(87);
    expect(
      fixtureEntries.filter((entry) => entry.isFile() && entry.name !== "README.md"),
    ).toHaveLength(57);
    expect(readme).toContain("Total: 87 stimuli across 18 eval files.");
    expect(readme).toContain("All 57 fixture data files");
    expect(readme).toContain("`--timeout <duration>`");
    expect(readme).toContain("`defaults.timeout`");
    expect(readme).not.toContain("`config.timeout`");

    const runner = await readFile(join(ROOT, ".github/skills/evals/run-evals.ps1"), "utf8");
    expect(collapseWhitespace(runner)).toContain(
      "this runner is a regression gate: every configured stimulus must pass.",
    );
    expect(runner).toMatch(
      /if \(\$failed -gt 0 -and \$overallExitCode -eq 0\)[\s\S]{0,200}\$overallExitCode = 1/,
    );
  }, 15_000);

  it("maps every EX-PAYLOAD example reference into each enum eval workspace", async () => {
    const evalSpec =
      /** @type {{ stimuli?: Array<{ tags?: Record<string, string>; environment?: { files?: Array<{ dest: string }> } }> }} */ (
        load(
          await readFile(
            join(ROOT, ".github/skills/evals/arm-api-reviewer/vally/eval-examples.yaml"),
            "utf8",
          ),
        )
      );
    const expectedExamples = [
      "ExtensibleEnum_Get.json",
      "ClosedEnum_Get.json",
      "Discriminator_Get.json",
      "PathParameter_Get.json",
    ];
    const issueStimuli = evalSpec.stimuli?.filter((stimulus) => stimulus.tags?.issue === "43747");

    expect(issueStimuli).toHaveLength(4);
    for (const stimulus of issueStimuli ?? []) {
      const destinations = stimulus.environment?.files?.map((file) => file.dest) ?? [];
      for (const example of expectedExamples) {
        expect(
          destinations.some((destination) => destination.endsWith(`/examples/${example}`)),
        ).toBe(true);
      }
    }
  });
});

describe("ARM Reviewer alignment and dependency consistency", () => {
  const ALIGNED_RULE_FILES = [
    ".github/instructions/arm-api-review.instructions.md",
    ".github/instructions/openapi-review.instructions.md",
    ".github/instructions/typespec-project.instructions.md",
    ".github/instructions/typespec-review.instructions.md",
    ".github/skills/azure-api-review/SKILL.md",
    ".github/skills/azure-api-review/references/api-version-lifecycle-and-branches.md",
    ".github/skills/azure-api-review/references/availability-zones.md",
    ".github/skills/azure-api-review/references/design-decisions.md",
    ".github/skills/azure-api-review/references/downstream-ci-impact.md",
    ".github/skills/azure-api-review/references/enum-best-practices.md",
    ".github/skills/azure-api-review/references/example-quality.md",
    ".github/skills/azure-api-review/references/field-ownership.md",
    ".github/skills/azure-api-review/references/guid-and-uuid-on-arm.md",
    ".github/skills/azure-api-review/references/linter-rule-coverage.md",
    ".github/skills/azure-api-review/references/lro-final-state-via.md",
    ".github/skills/azure-api-review/references/naming-conventions.md",
    ".github/skills/azure-api-review/references/pattern-validation.md",
    ".github/skills/azure-api-review/references/policy-compatibility.md",
    ".github/skills/azure-api-review/references/property-mutability.md",
    ".github/skills/azure-api-review/references/provisioning-state.md",
    ".github/skills/azure-api-review/references/reviewer-posted-parity.md",
    ".github/skills/azure-api-review/references/secret-detection.md",
    ".github/skills/azure-api-review/references/suppression-review-criteria.md",
    ".github/skills/azure-api-review/references/template-deployment.md",
    ".github/skills/azure-api-review/references/think-in-graphs.md",
    ".github/skills/azure-api-review/references/tracked-resource-lifecycle.md",
    ".github/skills/azure-api-review/references/what-if-preflight-compliance.md",
  ];

  it("pins every ARM and cross-cutting rule document to the requested alignment date", async () => {
    for (const file of ALIGNED_RULE_FILES) {
      const content = await readFile(join(ROOT, file), "utf8");
      expect(content, file).toContain("Upstream alignment: 2026-08-15");
    }
  });

  it("keeps graph handling explicit for every no-Mermaid path", async () => {
    const [workflow, reviewer, critic, protocol, template] = await Promise.all([
      readFile(join(ROOT, SOURCE_FILE), "utf8"),
      readFile(join(ROOT, AGENT_FILE), "utf8"),
      readFile(join(ROOT, ".github/agents/arm-api-review-critic.agent.md"), "utf8"),
      readFile(join(ROOT, ".github/agents/protocols/arm-api-review-critic.protocol.md"), "utf8"),
      readFile(
        join(ROOT, ".github/agents/protocols/arm-api-review-critic-inputs.template.md"),
        "utf8",
      ),
    ]);
    const combined = [workflow, reviewer, critic, protocol, template].join("\n");

    for (const mode of ["fast-path", "size-downgrade", "derivation-failed"]) {
      expect(combined).toContain(`graph-mode: ${mode}`);
    }
    expect(protocol).toContain("`size-downgrade` re-derives sensitive data flow");
    expect(critic).toContain("Do not require a failure banner");
  });

  it("requires an explicit reconciliation plan or sentinel", async () => {
    const [reviewer, critic, protocol, template] = await Promise.all([
      readFile(join(ROOT, AGENT_FILE), "utf8"),
      readFile(join(ROOT, ".github/agents/arm-api-review-critic.agent.md"), "utf8"),
      readFile(join(ROOT, ".github/agents/protocols/arm-api-review-critic.protocol.md"), "utf8"),
      readFile(
        join(ROOT, ".github/agents/protocols/arm-api-review-critic-inputs.template.md"),
        "utf8",
      ),
    ]);
    const combined = [reviewer, critic, protocol, template].join("\n");

    expect(combined).toContain("Omission, an empty heading, or an empty string is malformed");
    expect(combined).not.toContain("defaults to the literal sentinel `reconciliation skipped`");
    expect(template).toMatch(/Step 5\.5 reconciliation plan\s+\| \*\*Yes\*\*/);
  });

  it("keeps runtime scope, telemetry, labels, and truncation wording honest", async () => {
    const [workflow, reviewer, protocol] = await Promise.all([
      readFile(join(ROOT, SOURCE_FILE), "utf8"),
      readFile(join(ROOT, AGENT_FILE), "utf8"),
      readFile(join(ROOT, ".github/agents/protocols/arm-api-review-critic.protocol.md"), "utf8"),
    ]);
    const collapsedWorkflow = collapseWhitespace(workflow);
    const collapsedReviewer = collapseWhitespace(reviewer);

    expect(workflow).toContain("`Azure/azure-rest-api-specs-pr`");
    expect(workflow).not.toContain("| Reconciliation reply |");
    expect(workflow).not.toContain("rule: review-body");
    expect(protocol).toContain("Not on reply-only comments");
    expect(protocol).toContain(
      "_posted-by: arm-api-reviewer-agent | reconciliation: clarification",
    );
    expect(collapsedWorkflow).toContain("Exactly **three** things differ, by design");
    expect(collapsedReviewer).toContain("Three things differ, by design");
    expect(collapsedWorkflow).toContain(
      "M in-scope `specification/` files reviewed from N total PR files",
    );
    expect(collapsedWorkflow).toContain(
      "N` is the authoritative total PR file count, never a specification-file count",
    );
    expect(collapsedReviewer).toContain(
      "After all retries fail, enter auto-unavailable and require explicit per-row human approval",
    );
    expect(protocol).toContain("four marker schemas");
    expect(protocol).toContain("State B: all dispatch attempts failed");
    expect(protocol).toContain("State C: Critic returned");
  });

  it("keeps downstream conflicts overridable and overflow rows non-overridable", async () => {
    const [workflow, reviewer, critic, protocol] = await Promise.all([
      readFile(join(ROOT, SOURCE_FILE), "utf8"),
      readFile(join(ROOT, AGENT_FILE), "utf8"),
      readFile(join(ROOT, ".github/agents/arm-api-review-critic.agent.md"), "utf8"),
      readFile(join(ROOT, ".github/agents/protocols/arm-api-review-critic.protocol.md"), "utf8"),
    ]);

    expect(reviewer).not.toMatch(
      /non-overridable[\s\S]{0,80}(?:downstream-ci-conflict|suppression-path-mismatch)/,
    );
    expect(critic).toContain("Both `downstream-ci-conflict` and `suppression-path-mismatch` are");
    expect(protocol).toMatch(/`overflow-posted`[\s\S]{0,120}\*\*Yes\*\*/);
    expect(critic).toContain("**OVERFLOW-NOT-POSTED**");
    expect(workflow).toContain("| `OVERFLOW-NOT-POSTED`");
    expect(workflow).toContain("Append every excluded candidate to the reconciliation plan as an");
  });

  it("keeps generic OpenAPI guidance subordinate to ARM-specific rules", async () => {
    const openapi = collapseWhitespace(
      await readFile(join(ROOT, ".github/instructions/openapi-review.instructions.md"), "utf8"),
    );

    expect(openapi).toContain("`arm-api-review.instructions.md` sections 3-6 are authoritative");
    expect(openapi).toContain(
      "ARM supports operation-specific `If-Match` and `If-None-Match` semantics",
    );
    expect(openapi).toContain("does not define conditional GET behavior");
    expect(openapi).toContain("A closed enum with a documented fixed-set rationale");
    expect(openapi).not.toContain(
      'Every enum **MUST** have the `x-ms-enum` extension with a `name` property and `"modelAsString": true`',
    );
    expect(openapi).toContain("On ARM specs, do **not** suggest `format: uuid`");
    expect(openapi).toContain(
      "The schema must match the canonical ARM shape; a common-types `$ref` is strongly recommended",
    );
    expect(openapi).not.toContain("no ProvisioningState + 202 mixing");
  });

  it("requires TypeSpec emission linkage rather than an unrelated sibling project", async () => {
    const [openapi, arm] = await Promise.all([
      readFile(join(ROOT, ".github/instructions/openapi-review.instructions.md"), "utf8"),
      readFile(join(ROOT, ".github/instructions/arm-api-review.instructions.md"), "utf8"),
    ]);
    const combined = collapseWhitespace(`${openapi}\n${arm}`);

    expect(combined).toContain("both declares the new API version and is configured to emit");
    expect(combined).toContain("unrelated sibling project is not sufficient");
    expect(combined).not.toContain(
      "PR adds or modifies any `.tsp` file under the same service folder? Then **Rule PASSES",
    );
  });

  it("keeps TypeSpec project organization rules compatible with imported files", async () => {
    const instructions = collapseWhitespace(
      await readFile(join(ROOT, ".github/instructions/typespec-project.instructions.md"), "utf8"),
    );

    expect(instructions).toContain("Its order relative to `@server` is not significant.");
    expect(instructions).toContain(
      "They may live in `main.tsp` or files such as `models.tsp` and `operations.tsp`",
    );
    expect(instructions).not.toContain(
      "`@useAuth` decorator **MUST** be defined exactly ONCE, above",
    );
  });

  it("keeps rule mappings and preservation examples accurate", async () => {
    const [coverage, whatIf, ownership] = await Promise.all([
      readFile(
        join(ROOT, ".github/skills/azure-api-review/references/linter-rule-coverage.md"),
        "utf8",
      ),
      readFile(
        join(ROOT, ".github/skills/azure-api-review/references/what-if-preflight-compliance.md"),
        "utf8",
      ),
      readFile(join(ROOT, ".github/skills/azure-api-review/references/field-ownership.md"), "utf8"),
    ]);

    expect(coverage).toMatch(/R2063[\s\S]{0,120}openapi-review §14[\s\S]{0,40}Covered/);
    expect(coverage).toContain("It is not an exhaustive substitute for the pinned");
    expect(coverage).toMatch(/R2001[\s\S]{0,180}Conflict-aware/);
    expect(coverage).toContain("## Coverage Status Meanings");
    for (const rule of [
      "PathForTrackedResourceTypes",
      "SystemDataDefinitionsCommonTypes",
      "ValidQueryParametersForPointOperations",
      "DeleteResponseBodyEmpty",
      "GetMustNotHaveRequestBody",
      "ApiHost",
    ]) {
      expect(coverage).toContain(rule);
    }
    for (const gap of ["GetMustNotHaveRequestBody", "GetResponseCodes", "ApiHost"]) {
      expect(coverage).toMatch(new RegExp(`${gap}[^\\n]+GAP`));
    }
    for (const rule of ["R4006", "R2023", "R1010", "R2006"]) {
      expect(coverage).toContain(rule);
    }
    expect(whatIf).toContain("OAPI018** in\n> `arm-api-review.instructions.md` §8.17");
    expect(whatIf).toContain("| OAPI026 | arm-api-review §8.16");
    expect(whatIf).toContain("| OAPI024 | arm-api-review §8.15");
    expect(whatIf).toContain("| OAPI022 | arm-api-review §8.14");
    expect(ownership).toContain('| `"Test Value"` | `"test value"`          | `"Test Value"`');
  });

  it("keeps clean example references resolvable in every clean-spec eval", async () => {
    const cleanSpec = await readFile(
      join(ROOT, ".github/skills/evals/arm-api-reviewer/fixtures/arm-openapi/clean-spec.json"),
      "utf8",
    );
    const referencedExamples = [...cleanSpec.matchAll(/"\$ref": "\.\/examples\/([^"]+)"/g)].map(
      (match) => match[1],
    );
    expect(referencedExamples).toHaveLength(7);

    const evalDir = join(ROOT, ".github/skills/evals/arm-api-reviewer/vally");
    const evalFiles = (await readdir(evalDir)).filter((file) => file.endsWith(".yaml"));
    for (const evalFile of evalFiles) {
      const evalText = await readFile(join(evalDir, evalFile), "utf8");
      if (!evalText.includes("fixtures/arm-openapi/clean-spec.json")) {
        continue;
      }
      for (const example of referencedExamples) {
        expect(evalText, `${evalFile}: ${example}`).toContain(`/examples/${example}`);
      }
    }
  });

  it("keeps EX-PAYLOAD fixtures isolated from title violations", async () => {
    const evalSpec = /** @type {unknown} */ (
      load(
        await readFile(
          join(ROOT, ".github/skills/evals/arm-api-reviewer/vally/eval-examples.yaml"),
          "utf8",
        ),
      )
    );
    if (!isRecord(evalSpec) || !Array.isArray(evalSpec.stimuli)) {
      throw new Error("Expected eval stimuli");
    }
    const specPath = join(
      ROOT,
      ".github/skills/evals/arm-api-reviewer/fixtures/arm-openapi/ex-payload-enum-cases.json",
    );
    const spec = parseJsonRecord(await readFile(specPath, "utf8"));
    if (!isRecord(spec.paths)) {
      throw new Error("Expected OpenAPI paths");
    }
    /** @type {Map<string | undefined, string | undefined>} */
    const operationByExample = new Map();
    for (const pathItem of Object.values(spec.paths)) {
      if (!isRecord(pathItem)) continue;
      for (const operation of Object.values(pathItem)) {
        if (!isRecord(operation)) continue;
        const operationId =
          typeof operation.operationId === "string" ? operation.operationId : undefined;
        const examples = operation["x-ms-examples"];
        if (!isRecord(examples)) continue;
        for (const example of Object.values(examples)) {
          if (!isRecord(example) || typeof example.$ref !== "string") continue;
          operationByExample.set(example.$ref.split("/").at(-1), operationId);
        }
      }
    }

    const exampleDir = join(ROOT, ".github/skills/evals/arm-api-reviewer/fixtures/examples");
    const sourceFiles = [
      "example-ex-payload-extensible-enum.json",
      "example-ex-payload-closed-enum.json",
      "example-ex-payload-discriminator.json",
      "example-ex-payload-path-param.json",
    ];
    /** @type {Map<string | undefined, string | undefined>} */
    const destinationBySource = new Map();
    for (const stimulus of evalSpec.stimuli) {
      if (!isRecord(stimulus) || !isRecord(stimulus.environment)) continue;
      const files = stimulus.environment.files;
      if (!Array.isArray(files)) continue;
      for (const file of files) {
        if (!isRecord(file) || typeof file.src !== "string" || typeof file.dest !== "string") {
          continue;
        }
        destinationBySource.set(file.src.split("/").at(-1), file.dest.split("/").at(-1));
      }
    }

    for (const file of sourceFiles) {
      const example = parseJsonRecord(await readFile(join(exampleDir, file), "utf8"));
      const destination = destinationBySource.get(file);
      expect(destination, file).toBeTruthy();
      expect(typeof example.title === "string" ? example.title : undefined, file).toBe(
        operationByExample.get(destination),
      );
    }
  });
});

describe("Archived RPC contract reconciliation", () => {
  it("uses relocated RPC links throughout agent-facing .github docs", async () => {
    const roots = [".github/agents", ".github/instructions", ".github/skills/azure-api-review"];
    const markdownFiles = [];

    for (const root of roots) {
      const entries = await readdir(join(ROOT, root), { recursive: true });
      for (const entry of entries) {
        if (entry.endsWith(".md")) {
          markdownFiles.push(join(ROOT, root, entry));
        }
      }
    }

    for (const file of markdownFiles) {
      const content = await readFile(file, "utf8");
      expect(content, file).not.toContain(
        "github.com/cloud-and-ai-microsoft/resource-provider-contract",
      );
    }
  });

  it("matches the RPC resource envelope, singleton, and nested-list contract", async () => {
    const [arm, openapi, lifecycle] = await Promise.all([
      readFile(join(ROOT, ".github/instructions/arm-api-review.instructions.md"), "utf8"),
      readFile(join(ROOT, ".github/instructions/openapi-review.instructions.md"), "utf8"),
      readFile(
        join(ROOT, ".github/skills/azure-api-review/references/tracked-resource-lifecycle.md"),
        "utf8",
      ),
    ]);
    const combined = collapseWhitespace(`${arm}\n${openapi}\n${lifecycle}`);

    expect(openapi).toContain("`kind`, `location`, `extendedLocation`");
    expect(openapi).toContain("`managedBy`, `managedByExtended`, `identity`");
    expect(arm).toContain('`"EdgeZone"` or `"CustomLocation"`');
    expect(combined).toContain("`current` is also valid");
    expect(combined).toContain("A static literal route such as `/default` is allowed");
    expect(combined).toContain(
      "A nested type **MUST** implement collection GET under its immediate parent",
    );
    expect(combined).toContain(
      "A nested type instead requires collection GET under its immediate parent",
    );
    expect(combined).not.toContain("RPC-ConstrainedCollections-V1-04");
  });

  it("keeps query, paging, and conditional behavior at RPC strength", async () => {
    const [arm, openapi] = await Promise.all([
      readFile(join(ROOT, ".github/instructions/arm-api-review.instructions.md"), "utf8"),
      readFile(join(ROOT, ".github/instructions/openapi-review.instructions.md"), "utf8"),
    ]);
    const combined = collapseWhitespace(`${arm}\n${openapi}`);

    expect(combined).toContain("Custom query parameters **SHOULD NOT** be used");
    expect(combined).toContain("DELETE custom query parameters **SHOULD NOT** be used");
    expect(combined).toContain("On the final page its response value may be omitted or `null`");
    expect(openapi).toContain(
      "ARM resource-manager responses may omit `nextLink` or return it as `null`",
    );
    expect(openapi).toContain("Data-plane responses **MUST** omit `nextLink`");
    expect(arm).toContain("PUT supports `If-None-Match: *`");
    expect(arm).toContain("PUT, PATCH, and DELETE support a specific `If-Match` value");
    expect(arm).not.toContain("wildcard values (`*`) are **NOT** supported");
  });

  it("preserves greenfield and brownfield async distinctions", async () => {
    const arm = collapseWhitespace(
      await readFile(join(ROOT, ".github/instructions/arm-api-review.instructions.md"), "utf8"),
    );

    for (const verb of ["PATCH", "DELETE", "POST"]) {
      expect(arm).toMatch(
        new RegExp(
          `Async ${verb}[\\s\\S]{0,700}greenfield RP namespaces \\*\\*MUST\\*\\*[\\s\\S]{0,200}brownfield namespaces are \\*\\*strongly recommended\\*\\*`,
        ),
      );
    }
    expect(arm).not.toContain("service **MUST** return `409 Conflict`");
    expect(arm).toContain("`id` and `name` are optional");
    expect(arm).toContain("`error.message` is required for `Failed` and optional for `Canceled`");
    expect(arm).toContain("root-level resource, not a child of the resource");
    expect(arm).toContain("Operation IDs **MUST** be unique");
    expect(arm).toContain("RPs **MAY** expose a durable proxy resource");
  });

  it("keeps systemData and check-name guidance at current contract strength", async () => {
    const [arm, openapi] = await Promise.all([
      readFile(join(ROOT, ".github/instructions/arm-api-review.instructions.md"), "utf8"),
      readFile(join(ROOT, ".github/instructions/openapi-review.instructions.md"), "utf8"),
    ]);
    const combined = collapseWhitespace(`${arm}\n${openapi}`);

    expect(arm).toContain("The `systemData` shape **MUST** match the canonical ARM contract");
    expect(arm).toContain("strongly recommended");
    expect(arm).toContain("a correctly shaped inline definition is not Blocking solely");
    expect(openapi).toContain("a common-types `$ref` is strongly recommended but not mandatory");
    expect(combined).toContain("individual canonical member value is unavailable");
    expect(combined).not.toContain("inline redefinition of `systemData` is a Blocking violation");
    expect(combined).not.toContain("systemData` must use the canonical common-types definition");
    expect(combined).toContain("`SystemDataDefinitionsCommonTypes` LintDiff rule");
    expect(combined).toContain("repository-CI requirement, not as an RPC rule");
    expect(arm).toContain("When `nameAvailable` is `false`");
    expect(arm).toContain("A correctly shaped inline model is valid");
    expect(arm).toContain("Prefer Common-Types Definitions (CNA-003)");
    expect(arm).toContain("Do not treat the absence of those arrays as a shape incompatibility");
    expect(arm).not.toContain("response body **MUST** reference the common-types");
  });

  it("distinguishes operationResults placement from operationStatuses tracking", async () => {
    const arm = collapseWhitespace(
      await readFile(join(ROOT, ".github/instructions/arm-api-review.instructions.md"), "utf8"),
    );

    expect(arm).toContain("`operationResults` **MUST** be a root-level resource");
    expect(arm).toContain(
      "An `operationStatuses` tracking URI may be under the original request or under subscription-level operations",
    );
    expect(arm).toContain(
      "`operationStatuses` may be under the original request or subscription-level operations (RPC028)",
    );
    expect(arm).not.toContain(
      "`operationResults` and `operationStatuses` **MUST** be root-level resources",
    );
    expect(arm).not.toContain("Operation results/statuses are root-level resources (RPC021)");
  });

  it("keeps common-types and nested-resource checklists advisory and scope-aware", async () => {
    const [arm, openapi] = await Promise.all([
      readFile(join(ROOT, ".github/instructions/arm-api-review.instructions.md"), "utf8"),
      readFile(join(ROOT, ".github/instructions/openapi-review.instructions.md"), "utf8"),
    ]);
    const combined = collapseWhitespace(`${arm}\n${openapi}`);

    expect(combined).toContain("Every tracked resource has GET, PUT, PATCH, and DELETE");
    expect(arm).toContain(
      "Every tracked resource **MUST** implement point GET, PUT, PATCH, and DELETE",
    );
    expect(arm).toContain(
      "All API paths for **tracked resources** (resources with `location` as a required property) **MUST** be scoped under a subscription and resource group",
    );
    expect(arm).not.toContain("Subscription-scoped types use:");
    expect(combined).toContain("top-level tracked types also have ListByRG and ListBySub");
    expect(combined).not.toContain("subscription-scoped top-level types");
    expect(openapi).toContain("nested types have collection GET under their immediate parent");
    expect(openapi).toContain(
      "Every tracked resource **MUST** define GET, PUT, PATCH (update), and DELETE",
    );
    expect(openapi).toContain("compatible inline definitions are allowed");
    expect(openapi).not.toContain("Common-types referenced (not redefined) for ARM standard types");
    expect(arm).not.toContain(
      "Tracked resources have all required operations (GET, PUT, PATCH, DELETE, ListByRG, ListBySub)",
    );
    expect(arm).toContain(
      "Custom PATCH query parameters are avoided; any finding is Warning-level",
    );
    expect(arm).not.toContain("No non-`api-version` query parameters on PATCH");
    expect(arm).not.toContain("Collection GETs at subscription + RG level for tracked resources");
  });

  it("preserves extended-location type-specific name rules", async () => {
    const arm = collapseWhitespace(
      await readFile(join(ROOT, ".github/instructions/arm-api-review.instructions.md"), "utf8"),
    );

    expect(arm).toContain("for `EdgeZone`, the extended location name (max 128 characters");
    expect(arm).toContain("for `CustomLocation`, the fully qualified ARM resource ID");
  });

  it("keeps RPC rule IDs attached to their actual contract rules", async () => {
    const [arm, lifecycle, coverage] = await Promise.all([
      readFile(join(ROOT, ".github/instructions/arm-api-review.instructions.md"), "utf8"),
      readFile(
        join(ROOT, ".github/skills/azure-api-review/references/tracked-resource-lifecycle.md"),
        "utf8",
      ),
      readFile(
        join(ROOT, ".github/skills/azure-api-review/references/linter-rule-coverage.md"),
        "utf8",
      ),
    ]);

    expect(arm).toContain("Resource Provider Namespace Consistency (RPC-Uri-V1-03, R3030)");
    expect(arm).toContain("PUT Response Must Be an ARM Resource (R2062, R2019)");
    expect(arm).toContain("RPC-Patch-V1-04; legacy aggregate rule RPC007");
    expect(lifecycle).toMatch(/GET \(point\)[^\n]+RPC-Get-V1-04/);
    expect(coverage).toContain("R2062");
    expect(coverage).not.toMatch(/R2062[^\n]+RPC-Put-V1-12/);
    expect(arm).not.toContain("RPC-Operations-V1");
    expect(arm).not.toContain("RPC-LIST-VERSIONS");
  });

  it("uses current synchronous and asynchronous TypeSpec operation templates", async () => {
    const instructions = collapseWhitespace(
      await readFile(join(ROOT, ".github/instructions/typespec-project.instructions.md"), "utf8"),
    );

    expect(instructions).toContain("ArmResourceCreateOrReplaceSync<Resource>");
    expect(instructions).toContain("ArmResourceCreateOrReplaceAsync<Resource>");
    expect(instructions).toContain("ArmCustomPatchSync<Resource, PatchRequest>");
    expect(instructions).toContain("ArmCustomPatchAsync<Resource, PatchRequest>");
    expect(instructions).toContain("ArmResourceDeleteWithoutOkAsync<Resource>");
    expect(instructions).toContain("do not use deprecated `ArmResourceDeleteAsync`");
  });

  it("keeps TSP-REQUIRED scoped without claiming active CI enforcement", async () => {
    const [arm, openapi, typespec] = await Promise.all([
      readFile(join(ROOT, ".github/instructions/arm-api-review.instructions.md"), "utf8"),
      readFile(join(ROOT, ".github/instructions/openapi-review.instructions.md"), "utf8"),
      readFile(join(ROOT, ".github/instructions/typespec-review.instructions.md"), "utf8"),
    ]);
    const combined = collapseWhitespace(`${arm}\n${openapi}\n${typespec}`);

    expect(combined).toContain("out of scope for `TSP-REQUIRED-V1`");
    expect(combined).toContain("published-version immutability");
    expect(combined).not.toContain("A deterministic CI check is in development");
    expect(combined).not.toContain("/pull/42823");
  });

  it("maps check-name guidance for OpenAPI and TypeSpec", async () => {
    const [arm, typespec] = await Promise.all([
      readFile(join(ROOT, ".github/instructions/arm-api-review.instructions.md"), "utf8"),
      readFile(join(ROOT, ".github/instructions/typespec-review.instructions.md"), "utf8"),
    ]);

    expect(arm).toContain("Prefer Common-Types Definitions (CNA-003)");
    expect(typespec).toContain("Check Name Availability (CNA-002, CNA-003, CNA-004)");
    expect(typespec).toContain("checkGlobalNameAvailability");
    expect(typespec).toContain("checkLocalNameAvailability");
  });
});
