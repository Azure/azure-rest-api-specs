import "./common.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.App;

@doc("The request to execute code.")
model SessionCodeExecutionRequest {
  @doc("The properties for executing code.")
  properties: SessionCodeExecutionRequestProperties;
}

@doc("The response containing the result of the code execution.")
model SessionCodeExecutionResponse {
  @doc("The properties of the code execution response.")
  properties: SessionCodeExecutionResponseProperties;
}

@doc("The properties of the code execution request.")
model SessionCodeExecutionRequestProperties {
  @doc("The code input type of the code execution request.")
  codeInputType: CodeInputType;

  @doc("The execution type of the code execution request.")
  executionType: ExecutionType;

  @doc("The string of the code to execute, based on CodeInputType.")
  code: string;

  @doc("Code execution timeout in seconds.")
  timeoutInSeconds: int64;
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
}

@doc("The properties of the code execution result.")
model SessionCodeExecutionResponseProperties {
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

@doc("Code execution status.")
union CodeExecutionStatus {
  string,

  @doc("The code execution succeeded.")
  Success: "Success",

  @doc("The code execution failed.")
  Failure: "Failure",
}
