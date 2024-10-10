import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.App.DynamicSessions;
using OpenAPI;

@doc("The optional execution id header.")
model ExecutionIdHeader {
  @header
  @doc("The operation id.")
  executionId?: string;
}

@doc("Session identifier query parameter.")
model SessionIdentifier {
  @doc("The identifier of the session.")
  @query
  sessionId: string;
}

@doc("Session code execution identifier query parameter.")
model CodeExecutionIdentifier {
  @doc("The identifier of code execution.")
  @path
  executionId: string;
}

@doc("The session resource file path parameter.")
model SessionResourceFilePathQueryParameter {
  @doc("The path of the file after uploaded.")
  @query
  path: string;
}

@doc("The session resource file name parameter.")
model SessionResourceFileNamePathParameter {
  @doc("The name of the file.")
  @path
  name: string;
}
