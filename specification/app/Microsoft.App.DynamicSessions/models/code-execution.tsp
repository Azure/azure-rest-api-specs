import "./common.tsp";
using Azure.Core;
using TypeSpec.Http;
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
  timeoutInSeconds: int64;
}

@doc("The response containing the result of the code execution.")
model SessionCodeExecutionResponse {
  @visibility("read")
  @doc("Session code execution id.")
  id: string;

  @doc("The status of the code execution, indicates whether succeeded or not.")
  status: CodeExecutionStatus;

  @doc("The standard output of the code execution.")
  stdout: string;

  @doc("The standard error of the code execution.")
  stderr: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" ""
  @doc("The result of the code execution. The type of this field is same as the type of actual result of the code execution after being Json serialized.")
  result: unknown;

  @doc("The execution time of the code in milliseconds.")
  executionTimeInMilliseconds: int64;
}

@doc("The response of the async code execution.")
model SessionCodeExecutionAsyncResponse {
  ...SessionCodeExecutionResponse;

  @header
  @doc("The async code execution operation id.")
  operationId: string;

  ...Foundations.LongRunningStatusLocation;
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

@doc("Code execution status.")
union CodeExecutionStatus {
  string,

  @doc("The code execution succeeded.")
  Succeeded: "Succeeded",

  @doc("The code execution failed.")
  Failed: "Failed",

  @doc("The code execution canceled.")
  Canceled: "Canceled",
}
