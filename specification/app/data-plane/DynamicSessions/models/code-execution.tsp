import "./common.tsp";
using Azure.Core;
using TypeSpec.Rest;

namespace Microsoft.App.DynamicSessions;

@doc("The request to execute code.")
model SessionCodeExecutionRequest {
  @doc("The code input type of the code execution request.")
  codeInputType: CodeInputType;

  @doc("The execution type of the code execution request.")
  executionType: ExecutionType;

  @doc("The string of the code to execute, based on CodeInputType.")
  code: string;

  @doc("Code execution timeout in seconds.")
  timeoutInSeconds: int32;
}

@doc("The result of the code execution.")
model SessionCodeExecutionResult {
  @doc("The standard output of the code execution.")
  stdout?: string;

  @doc("The standard error of the code execution.")
  stderr?: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "The type of this field depends on the code execution result."
  @doc("The result of the code execution. The type of this field is same as the type of actual result of the code execution after being Json serialized.")
  executionResult?: unknown;

  @doc("The execution time of the code in milliseconds.")
  executionTimeInMilliseconds?: int64;
}

@doc("The session code execution resource.")
@resource("executions")
model SessionCodeExecutionResource {
  @visibility(Lifecycle.Read)
  @doc("Session code execution id.")
  @key("executionId")
  id: string;

  @doc("The identifier of the session.")
  identifier: string;

  @doc("The execution type of the code execution request.")
  executionType: ExecutionType;

  @doc("The status of the code execution operation, indicates whether succeeded or not.")
  status: Foundations.OperationState;

  @doc("The error of this code execution if failed.")
  error?: Foundations.ErrorResponse;

  @doc("The result of this code execution operation.")
  result?: SessionCodeExecutionResult;
}

@doc("Code input type.")
union CodeInputType {
  string,

  @doc("Inline.")
  inline: "Inline",

  @doc("InlineBase64.")
  inlineBase64: "InlineBase64",

  @doc("InlineText.")
  inlineText: "InlineText",
}

@doc("Execution Type")
union ExecutionType {
  string,

  @doc("Synchronous")
  synchronous: "Synchronous",

  @doc("Asynchronous")
  asynchronous: "Asynchronous",
}
