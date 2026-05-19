import { EmitterCheckResult } from "./emitter-check.js";
import { ExecutionReport, ExecutionReportPackage, ExecutionResult } from "./types.js";

/**
 * Response shape from `azsdk pkg generate --output json`.
 */
export interface AzsdkGenerateResponse {
  result: "succeeded" | "failed";
  message?: string;
  package_name: string;
  language: string;
  version: string;
  package_type: string;
  typespec_project: string;
  sdk_repo: string;
  operation_status: string;
  next_steps?: string[];
  response_error?: string;
  response_errors?: string[];
  duration?: number;
}

/**
 * Response shape from `azsdk pkg build --output json`.
 */
export interface AzsdkBuildResponse {
  result: "succeeded" | "failed";
  message?: string;
  package_name: string;
  language: string;
  response_error?: string;
  response_errors?: string[];
  duration?: number;
}

/**
 * Response shape from `azsdk pkg pack --output json`.
 */
export interface AzsdkPackResponse {
  result: "succeeded" | "failed";
  message?: string;
  package_name: string;
  language: string;
  version: string;
  package_type: string;
  response_error?: string;
  response_errors?: string[];
  duration?: number;
}

/**
 * Parses JSON output from an azsdk-cli command.
 * The CLI emits log lines before the JSON payload. The JSON object is always
 * the last block in the output, so we search backwards for the opening brace.
 */
export function parseAzsdkResponse<T>(output: string): T {
  // The azsdk CLI emits log lines before the JSON payload.
  // Find the last line that starts with '{' — this is the beginning of the JSON block.
  const lines = output.split("\n");
  let jsonStartLine = -1;
  for (let i = lines.length - 1; i >= 0; i--) {
    if (lines[i].trimStart().startsWith("{")) {
      jsonStartLine = i;
      break;
    }
  }

  if (jsonStartLine === -1) {
    throw new SyntaxError(`No JSON object found in azsdk output: ${output.slice(0, 200)}`);
  }

  const jsonText = lines.slice(jsonStartLine).join("\n");
  return JSON.parse(jsonText) as T;
}

// Deferred: extractArtifactPath will be re-enabled when stagedArtifactsFolder is published as pipeline artifact
// function extractArtifactPath(packResponse: AzsdkPackResponse): string {
//   if (!packResponse.message) {
//     return "";
//   }
//   const artifactPrefix = "Artifact: ";
//   const artifactIndex = packResponse.message.indexOf(artifactPrefix);
//   if (artifactIndex === -1) {
//     return "";
//   }
//   return packResponse.message.slice(artifactIndex + artifactPrefix.length).trim();
// }

/**
 * Builds an ExecutionReport from azsdk-cli generate/pack responses and
 * typespec-metadata emitter output.
 *
 * This adapter bridges the gap between azsdk-cli output and the ExecutionReport
 * format expected by the spec-gen-sdk-runner orchestration logic.
 *
 * @param generateResponse - Response from `azsdk pkg generate`
 * @param packResponse - Response from `azsdk pkg pack` (undefined if pack was skipped)
 * @param emitterCheck - Result from typespec-metadata emitter check
 * @returns ExecutionReport compatible with existing runner logic
 */
export function buildExecutionReport(
  generateResponse: AzsdkGenerateResponse | undefined,
  packResponse: AzsdkPackResponse | undefined,
  emitterCheck: EmitterCheckResult,
  buildResponse?: AzsdkBuildResponse,
): ExecutionReport {
  // If emitter is not enabled, return notEnabled result
  if (!emitterCheck.enabled) {
    return {
      packages: [],
      executionResult: "notEnabled",
      generateFromTypeSpec: true,
    };
  }

  // Map azsdk-cli result to ExecutionResult — fail if any step failed
  let executionResult: ExecutionResult;
  if (!generateResponse || generateResponse.result !== "succeeded") {
    executionResult = "failed";
  } else if (buildResponse && buildResponse.result !== "succeeded") {
    executionResult = "failed";
  } else if (packResponse && packResponse.result !== "succeeded") {
    executionResult = "failed";
  } else {
    executionResult = "succeeded";
  }

  // Build package info from typespec-metadata and pack response
  //const artifactPath = packResponse ? extractArtifactPath(packResponse) : "";
  //const artifactDir = artifactPath ? path.dirname(artifactPath) : undefined;
  const pkg: ExecutionReportPackage = {
    packageName: emitterCheck.packageName ?? generateResponse?.package_name ?? "",
    // Deferring apiview artifact processing until we create it for Rust by azsdk-cli
    apiViewArtifact: undefined,
    // Deferred fields:
    // shouldLabelBreakingChange: undefined,
  };

  return {
    packages: [pkg],
    executionResult,
    // deferred setting stagedArtifactsFolder so that pack output will not be published as pipeline artifact
    // we might emit a markdown summary telling user exactly what to put into their app using https://doc.rust-lang.org/cargo/reference/specifying-dependencies.html
    stagedArtifactsFolder: undefined,
    generateFromTypeSpec: true,
  };
}
