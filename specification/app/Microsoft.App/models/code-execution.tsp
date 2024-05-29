import "./common.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.App;

@doc("The request to execute code.")
model CodeExecutionRequest {
  @doc("The properties for executing code.")
  properties: CodeExecutionRequestProperties;
}

@doc("The response containing the result of the code execution.")
model CodeExecutionResponse {
  @doc("The properties of the code execution response.")
  properties: CodeExecutionresponseProperties;
}

@doc("The properties of the code execution request.")
model CodeExecutionRequestProperties {
  @doc("The code input type of the code execution request.")
  codeInputType: CodeInputType;

  @doc("The execution type of the code execution request.")
  executionType: ExecutionType;

  @doc("The code to execute.")
  code: string;

  @doc("Code execution timeout in seconds.")
  timeoutInSeconds: int64;
}

@doc("Code input type.")
union CodeInputType {
  string,

  @doc("Inline.")
  inline: "inline",

  @doc("InlineBase64.")
  inlineBase64: "inlineBase64",

  @doc("InlineText.")
  inlineText: "inlineText",
}

@doc("Execution Type")
union ExecutionType {
  string,

  @doc("Synchronous")
  synchronous: "synchronous",
}

@doc("The properties of the code execution result.")
model CodeExecutionresponseProperties {
  @doc("The status of the code execution, indicates whether succeeded or not.")
  status: CodeExecutionStatus;

  @doc("The standard output of the code execution.")
  stdout: string;

  @doc("The standard error of the code execution.")
  stderr: string;

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

@doc("A widget.")
@resource("widgets")
model Widget {
  @key("widgetName")
  @doc("The widget name.")
  @visibility("read")
  name: string;

  @doc("The ID of the manufacturer.")
  manufacturerId: string;

  @doc("The faked shared model.")
  sharedModel?: FakedSharedModel;
}

@doc("Faked shared model")
model FakedSharedModel {
  @doc("The tag.")
  tag: string;

  @doc("The created date.")
  createdDate: utcDateTime;
}
