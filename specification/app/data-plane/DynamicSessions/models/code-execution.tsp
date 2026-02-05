import "./common.tsp";
using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.App.DynamicSessions;

/** The request to execute code. */
model SessionCodeExecutionRequest {
  /** The code input type of the code execution request. */
  @madeOptional(Versions.v2025_10_02_preview)
  codeInputType?: CodeInputType;

  /** The execution type of the code execution request. */
  @madeOptional(Versions.v2025_10_02_preview)
  executionType?: ExecutionType;

  /** The string of the code to execute, based on CodeInputType. */
  @madeOptional(Versions.v2025_10_02_preview)
  code?: string;

  /** Execution timeout in seconds. */
  timeoutInSeconds: int32;

  /** The maximum length of the output streams. Default value is 4096. */
  @added(Versions.v2025_10_02_preview)
  outputStreamsMaxLength?: int32;

  /** Whether to use empty kernel for this execution. Default is false. */
  @added(Versions.v2025_10_02_preview)
  useEmptyKernel?: boolean;

  /** Whether to formats primitive Python results (bool, int, float, string, None) as JSON strings or null. Default to false. */
  @added(Versions.v2025_10_02_preview)
  returnJupyterFormatExecutionResult?: boolean;

  /** Shell command to execute in Bash. Only available for a `Shell` typed session pool. Cannot coexist with `execCommandAndArgs`. */
  @added(Versions.v2025_10_02_preview)
  shellCommand?: string;

  /** The executable and its arguments. Only available for a `Shell` typed session pool. Cannot coexist with `shellCommand`. */
  @added(Versions.v2025_10_02_preview)
  execCommandAndArgs?: string[];

  /** The standard input of the shell command execution. Only available for a `Shell` typed session pool. */
  @added(Versions.v2025_10_02_preview)
  stdin?: string;
}

/** The result of the code execution. */
model SessionCodeExecutionResult {
  /** The standard output of the code execution. */
  stdout?: string;

  /** The standard error of the code execution. */
  stderr?: string;

  /** The result of the code execution. The type of this field is same as the type of actual result of the code execution after being Json serialized. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "The type of this field depends on the code execution result."
  executionResult?: unknown;

  /** The execution time of the code in milliseconds. */
  executionTimeInMilliseconds?: int64;
}

/** The session code execution resource. */
@resource("executions")
model SessionCodeExecutionResource {
  /** Session code execution id. */
  @visibility(Lifecycle.Read)
  @key("executionId")
  id: string;

  /** The identifier of the session. */
  identifier: string;

  /** The execution type of the code execution request. */
  @madeOptional(Versions.v2025_10_02_preview)
  executionType?: ExecutionType;

  /** The status of the code execution operation, indicates whether succeeded or not. */
  status: Foundations.OperationState;

  /** The error of this code execution if failed. */
  error?: Foundations.ErrorResponse;

  /** The result of this code execution operation. */
  result?: SessionCodeExecutionResult;
}

/** Code input type. */
union CodeInputType {
  string,

  /** Inline. */
  inline: "Inline",

  /** InlineBase64. */
  inlineBase64: "InlineBase64",

  /** InlineText. */
  inlineText: "InlineText",
}

/** Execution Type */
union ExecutionType {
  string,

  /** Synchronous */
  synchronous: "Synchronous",

  /** Asynchronous */
  asynchronous: "Asynchronous",
}
