import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;

namespace Microsoft.App.DynamicSessions;

@doc("The optional execution id header.")
model ExecutionOperationIdHeader {
  @header
  @doc("The id of this execution operation.")
  operationId?: string;
}

@doc("Session identifier query parameter.")
model SessionIdentifier {
  @doc("The user-assigned identifier of the session.")
  @query
  @minLength(1)
  @maxLength(256)
  @pattern("^[a-zA-Z0-9_|}{\\[\\]\\:\"\";'<>?\\/.,@#$%\\^&*()_\\-+=!~`]{4,128}$")
  identifier: string;
}

@doc("Session code execution identifier path parameter.")
model CodeExecutionIdentifier {
  @doc("The identifier of code execution.")
  @path
  executionId: string;
}

@doc("The session resource file path parameter.")
model SessionResourceFilePathQueryParameter {
  @doc("The path of the file after uploaded.")
  @query
  path?: string;
}

@doc("The session resource file name parameter.")
model SessionResourceFileNamePathParameter {
  @doc("The name of the file.")
  @path
  name: string;
}
