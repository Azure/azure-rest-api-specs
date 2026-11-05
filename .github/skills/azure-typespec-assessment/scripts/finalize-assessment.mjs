import fs from "node:fs";
import path from "node:path";
import { assembleAssessment } from "./assemble-assessment.mjs";
import { isMain, parseArgs, readJsonObject, runMain } from "./cli.mjs";
import { renderAssessmentHtml } from "./render-assessment-html.mjs";
import { validateAssessment } from "./validate-assessment.mjs";
import {
  atomicWriteFile,
  atomicWriteJson,
  hashArtifacts,
  readWorkflowState,
  transitionWorkflowState,
  verifyArtifactHashes,
} from "./workflow-state.mjs";

/** @typedef {import("./runtime-types.js").AssessmentOutput} AssessmentOutput */
/** @typedef {import("./runtime-types.js").DownstreamAnalysis} DownstreamAnalysis */

/** @param {string} file */
function fileTimestamp(file) {
  return fs.existsSync(file) ? fs.statSync(file).mtime.toISOString() : undefined;
}

/** @param {(string | undefined)[]} values */
function earliestTimestamp(values) {
  return values.filter(Boolean).sort()[0];
}

/** @param {unknown} error */
function compactError(error) {
  return (error instanceof Error ? error.message : String(error))
    .split(/\r?\n/)
    .filter(Boolean)
    .slice(0, 12)
    .join("\n");
}

/**
 * @param {{
 *   work: string,
 *   agentFileReads?: string | number,
 *   agentShellCommands?: string | number
 * }} options
 */
export function finalizeAssessment({ work, agentFileReads, agentShellCommands }) {
  const root = path.resolve(work);
  const started = performance.now();
  try {
    const inferenceArtifactAt = fileTimestamp(path.join(root, "inference.json"));
    const guidelineEvidenceAt = fileTimestamp(path.join(root, "compliance-search-evidence.json"));
    const judgmentArtifactAt = fileTimestamp(path.join(root, "assessment-judgment.json"));
    const firstAgentArtifactAt = earliestTimestamp([
      inferenceArtifactAt,
      guidelineEvidenceAt,
      judgmentArtifactAt,
    ]);
    const previousState = readWorkflowState(root);
    const deterministicReadyAt =
      typeof previousState?.telemetry?.deterministicReadyAt === "string"
        ? previousState.telemetry.deterministicReadyAt
        : undefined;
    const state = transitionWorkflowState(root, "agent-artifacts-written", {
      telemetry: {
        inferenceArtifactAt,
        guidelineEvidenceAt,
        judgmentArtifactAt,
        firstAgentArtifactAt,
        ...(deterministicReadyAt && firstAgentArtifactAt
          ? {
              observableWaitBeforeFirstAgentArtifactMs: Math.max(
                0,
                new Date(firstAgentArtifactAt).getTime() - new Date(deterministicReadyAt).getTime(),
              ),
            }
          : {}),
        ...(agentFileReads === undefined ? {} : { agentFileReads: Number(agentFileReads) }),
        ...(agentShellCommands === undefined
          ? {}
          : { agentShellCommands: Number(agentShellCommands) }),
      },
    });
    const hashErrors = verifyArtifactHashes(root, state.artifactHashes);
    if (hashErrors.length) {
      throw new Error(
        `Canonical assessment inputs changed; rerun deterministic analysis.\n${hashErrors.join("\n")}`,
      );
    }
    transitionWorkflowState(root, "finalizing", { failure: undefined });
    const judgmentPath = path.join(root, "assessment-judgment.json");
    if (!fs.existsSync(judgmentPath)) {
      throw new Error("Missing assessment-judgment.json.");
    }
    const assessment = /** @type {AssessmentOutput} */ (
      /** @type {unknown} */ (
        assembleAssessment({
          work: root,
          judgment: judgmentPath,
        })
      )
    );
    const errors = validateAssessment(assessment);
    if (errors.length) throw new Error(errors.join("\n"));
    const downstreamPath = path.join(root, "dimensions", "downstream-breaking-input.json");
    const html = renderAssessmentHtml(assessment, {
      ...(fs.existsSync(downstreamPath)
        ? {
            downstreamInput: /** @type {DownstreamAnalysis} */ (
              /** @type {unknown} */ (readJsonObject(downstreamPath))
            ),
          }
        : {}),
    });
    const assessmentPath = path.join(root, "assessment.json");
    const reportPath = path.join(root, "assessment.html");
    atomicWriteJson(assessmentPath, assessment);
    atomicWriteFile(reportPath, html);
    const finalizationMs = Math.round(performance.now() - started);
    transitionWorkflowState(root, "complete", {
      phaseComplete: true,
      artifacts: {
        ...(state.artifacts ?? {}),
        structuredResult: "assessment.json",
        report: "assessment.html",
      },
      resultHashes: hashArtifacts(root, ["assessment.json", "assessment.html"]),
      failure: undefined,
      telemetry: { finalizationMs },
    });
    return { assessmentPath, reportPath, finalizationMs };
  } catch (error) {
    const message = compactError(error);
    transitionWorkflowState(root, "awaiting-agent-judgment", {
      failure: {
        code: "finalization-failed",
        message,
        recordedAt: new Date().toISOString(),
      },
      telemetry: {
        finalizationMs: Math.round(performance.now() - started),
      },
    });
    throw new Error(message, { cause: error });
  }
}

if (isMain(import.meta.url)) {
  void runMain(() => {
    const args = parseArgs(process.argv.slice(2), { required: ["work"] });
    const work = args.work;
    if (typeof work !== "string") throw new Error("--work must be a path.");
    const agentFileReads = args.agent_file_reads;
    const agentShellCommands = args.agent_shell_commands;
    if (
      agentFileReads !== undefined &&
      typeof agentFileReads !== "string" &&
      typeof agentFileReads !== "number"
    ) {
      throw new Error("--agent-file-reads must be a number.");
    }
    if (
      agentShellCommands !== undefined &&
      typeof agentShellCommands !== "string" &&
      typeof agentShellCommands !== "number"
    ) {
      throw new Error("--agent-shell-commands must be a number.");
    }
    const result = finalizeAssessment({
      work,
      agentFileReads,
      agentShellCommands,
    });
    console.log(
      JSON.stringify({
        structuredResult: result.assessmentPath,
        report: result.reportPath,
        finalizationMs: result.finalizationMs,
      }),
    );
  });
}
