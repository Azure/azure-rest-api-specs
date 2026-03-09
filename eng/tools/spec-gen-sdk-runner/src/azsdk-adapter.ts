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
  // The JSON block is the last section — find the last top-level '{' that
  // appears either at the start of a line or at the very beginning of output.
  const jsonEnd = output.lastIndexOf("}");
  if (jsonEnd === -1) {
    throw new SyntaxError(`No JSON object found in azsdk output: ${output.slice(0, 200)}`);
  }

  // Walk backwards from jsonEnd to find the matching '{'
  let depth = 0;
  let jsonStart = -1;
  for (let i = jsonEnd; i >= 0; i--) {
    if (output[i] === "}") {
      depth++;
    } else if (output[i] === "{") {
      depth--;
      if (depth === 0) {
        jsonStart = i;
        break;
      }
    }
  }

  if (jsonStart === -1) {
    throw new SyntaxError(`No matching opening brace found in azsdk output: ${output.slice(0, 200)}`);
  }

  return JSON.parse(output.slice(jsonStart, jsonEnd + 1)) as T;
}

/**
 * Extracts the artifact path from an azsdk pkg pack response message.
 * The message format is: "Pack completed successfully. Artifact: /path/to/artifact"
 */
function extractArtifactPath(packResponse: AzsdkPackResponse): string {
  if (!packResponse.message) {
    return "";
  }
  const artifactPrefix = "Artifact: ";
  const artifactIndex = packResponse.message.indexOf(artifactPrefix);
  if (artifactIndex === -1) {
    return "";
  }
  return packResponse.message.slice(artifactIndex + artifactPrefix.length).trim();
}

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
): ExecutionReport {
  // If emitter is not enabled, return notEnabled result
  if (!emitterCheck.enabled) {
    return {
      packages: [],
      executionResult: "notEnabled",
      generateFromTypeSpec: true,
    };
  }

  // Map azsdk-cli result to ExecutionResult
  let executionResult: ExecutionResult;
  if (!generateResponse) {
    executionResult = "failed";
  } else {
    executionResult = generateResponse.result === "succeeded" ? "succeeded" : "failed";
  }

  // Build package info from typespec-metadata and pack response
  const artifactPath = packResponse ? extractArtifactPath(packResponse) : "";
  const pkg: ExecutionReportPackage = {
    packageName: emitterCheck.packageName ?? generateResponse?.package_name ?? "",
    apiViewArtifact: artifactPath || undefined,
    // Deferred fields:
    // shouldLabelBreakingChange: undefined,
  };

  return {
    packages: [pkg],
    executionResult,
    stagedArtifactsFolder: artifactPath || undefined,
    generateFromTypeSpec: true,    
  };
}
