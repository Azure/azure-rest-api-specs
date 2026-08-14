import { readFile } from "fs/promises";
import { load } from "js-yaml";
import { join } from "path";
import { beforeAll, describe, expect, it, vi } from "vitest";
import { runInNewContext } from "vm";

// cspell:ignore REPOST

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
    const [[source, compiled], reviewer, critic, protocol, inputTemplate, parity] =
      await Promise.all([
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
      ]);

    expect(parity).toContain("A human invokes the ARM API Reviewer in chat");
    expect(parity).toContain("The automated workflow runs when a PR is ready");
    expect(parity).toContain("posts `/arm-review`");
    expect(parity).toContain("top-level PR conversation comments");
    expect(parity).toContain("pull request review bodies");
    expect(parity).toContain("Match findings by semantic identity");
    expect(parity).toContain("Contradictions MUST use `CLARIFY-CONFLICT`");

    expect(reviewer).toContain("Fetch the complete existing discussion inventory");
    expect(reviewer).toContain("**CLARIFY-CONFLICT.**");
    expect(reviewer).toContain("`reconciliation: clarification` marker");
    expect(reviewer).toContain("(<verification-status>, <N> iteration(s), <outcome>)");
    expect(reviewer).toMatch(/Critic unavailable;\s+reviewer self-check only/);
    expect(reviewer).not.toContain("(critic-verified, <N> iteration(s), <outcome>)");
    expect(critic).toContain("`FAIL: duplicate-missed`");
    expect(critic).toContain("`FAIL: conflict-unclarified`");
    expect(critic).toContain("inventory-incomplete");
    expect(critic).toContain("the canonical protocol permits a validated override");
    expect(protocol).toContain("`downstream-ci-conflict`");
    expect(protocol).toMatch(/`downstream-ci-conflict`[^\n]+Override allowed/);
    expect(protocol).toContain("**10 non-overridable reasons**");
    expect(protocol).toContain("PR URL, Session SHA, or Step 6 findings report");
    expect(inputTemplate).toContain(
      "Only PR URL, Session SHA, and the\nStep 6 findings report are required",
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
    expect(source).toContain("Match by semantic finding identity");
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
      "**At least one Blocking `POST-NEW` or Blocking `RESOLVE-AND-REPOST` queued**",
    );
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

  it("requires a telemetry marker on every posted body and bans the one-field form", async () => {
    const source = await readFile(join(ROOT, SOURCE_FILE), "utf8");
    const collapsed = collapseWhitespace(source);

    expect(source).toContain("### Telemetry Marker: Required on Every Posted Body");
    // Each posting surface must be named, so the summary comment cannot be
    // treated as exempt the way it was on earlier runs.
    for (const surface of [
      "create-pull-request-review-comment",
      "reply-to-pull-request-review-comment",
      "add-comment",
    ]) {
      expect(source).toContain(surface);
    }
    expect(collapsed).toContain(
      "A marker that carries only `posted-by: arm-api-reviewer-agent` and no other field is **not** a valid marker on a posted body.",
    );
    expect(collapsed).toContain("It is a defect, not a fallback");
    // Ordered degradation path, so a missing field never silently drops telemetry.
    expect(collapsed).toContain("Omit the optional fields");
    expect(collapsed).toContain("Set `critic: unknown`");
    expect(collapsed).toContain("`telemetry: degraded` field and a `reason:` field");
  });

  it("leaves no exception to the ARMChangesRequested label rule", async () => {
    const source = collapseWhitespace(await readFile(join(ROOT, SOURCE_FILE), "utf8"));

    expect(source).toContain("These two rules are **exhaustive**.");
    expect(source).toContain(
      "draft status, a `[Test]` or `[Do-Not-Merge]` title, a revert, a bot-authored PR, or the author's stated intent not to merge are **not** grounds to skip a label change",
    );
    expect(source).toContain(
      "The only input to this decision is whether a Blocking finding was queued.",
    );
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
      'fill the disclosure slot above -- between the "Reviewed PR" line and the "Approval labels observed" line -- with this line verbatim',
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

  it("requires all six marker fields on the summary, not a reduced form", async () => {
    const source = await readFile(join(ROOT, SOURCE_FILE), "utf8");
    const collapsed = collapseWhitespace(source);

    // The run's summary marker carried only `rule:` and `posted-by:`.
    expect(collapsed).toContain(
      "All six fields are **required on every posted body**, including the Step 8 summary",
    );
    expect(collapsed).toContain("The summary's marker is not a reduced form");
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

    // The section claims "every posted body" but the surface table omitted the
    // review body, and the live run posted a review body with no marker.
    expect(source).toContain("| Review body          | `submit-pull-request-review`");
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

    // Every marker template must survive prompt stripping intact and carry all
    // six fields, and none may be wrapped in HTML-comment delimiters.
    const templates = [
      ...collapsedStripped.matchAll(/_posted-by: arm-api-reviewer-agent[^`\n]*?_/g),
    ];
    expect(templates.length).toBeGreaterThanOrEqual(3);
    for (const [template] of templates) {
      for (const field of ["rule:", "severity:", "classification:", "critic:", "head-sha:"]) {
        expect(template).toContain(field);
      }
      expect(template).not.toContain("<!--");
    }

    // No marker template may be written as a literal HTML comment anywhere in
    // the source: it would be erased on the way to the agent, and copying it
    // would get the published marker erased too.
    expect(source).not.toContain("<!-- posted-by: arm-api-reviewer-agent");

    // The reconciliation reader must still recognize the legacy HTML form,
    // because interactive agent sessions bypass the publishing sanitizer.
    expect(collapseWhitespace(source)).toContain("may still carry it inside an HTML comment");
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
});
