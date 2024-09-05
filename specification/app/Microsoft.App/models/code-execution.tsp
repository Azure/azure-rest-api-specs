import "./common.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.App;

@doc("The request to execute code.")
model SessionCodeExecutionRequest {
  @doc("The code input type of the code execution request.")
  codeInputType: CodeInputType;

  @doc("The execution type of the code execution request.")
  executionType: ExecutionType;

  @doc("The network status of the code execution session.")
  networkStatus: NetworkStatus;

  @doc("The multi array status of the code execution session.")
  multiArrayStatus: MultiArrayStatus;

  @doc("The string of the code to execute, based on CodeInputType.")
  code: string;

  @doc("Code execution timeout in seconds.")
  timeoutInSeconds: int64;
}

@doc("The result containing the result of the code execution.")
model SessionCodeExecutionResult {
  ...SessionCodeExecutionRequest;

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
  @doc("The result of the code execution.")
  result: unknown;

  @doc("The execution time of the code in milliseconds.")
  executionTimeInMilliseconds: int64;
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

@doc("Network status.")
union NetworkStatus {
  string,

  @doc("Session egress enabled.")
  egressEnabled: "EgressEnabled",

  @doc("Session egress disabled.")
  egressDisabled: "EgressDisabled",
}

@doc("Multi array status.")
union MultiArrayStatus {
  string,

  @doc("Multi array enabled")
  multiArrayEnabled: "MultiArrayEnabled",

  @doc("Multi array disabled.")
  multiArrayDisabled: "MultiArrayDisabled",
}

@doc("Code execution status.")
union CodeExecutionStatus {
  string,

  @doc("The code execution succeeded.")
  Success: "Success",

  @doc("The code execution failed.")
  Failure: "Failure",
}
