import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.App.DynamicSessions;
using OpenAPI;

@doc("The code execution name path parameter.")
model SessionResourceFileNameParameter {
  @doc("The name of the file.")
  @path
  fileName: string;
}

@doc("Session identifier query parameter.")
model SessionIdentifier {
  @doc("The identifier of the session.")
  @query
  @extension("x-ms-parameter-location", "client")
  identifier: string;
}

@doc("Session code execution identifier query parameter.")
model CodeExecutionIdentifier {
  @doc("The identifier of code execution.")
  @query
  @extension("x-ms-parameter-location", "client")
  executionId: string;
}
