import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.App.DynamicSessions;

/** The optional execution id header. */
model ExecutionOperationIdHeader {
  /** The id of this execution operation. */
  @header
  operationId?: string;
}

/** Session identifier query parameter. */
model SessionIdentifier {
  /** The user-assigned identifier of the session. */
  @query
  @minLength(1)
  @maxLength(256)
  @pattern("^[a-zA-Z0-9_|}{\\[\\]\\:\"\";'<>?\\/.,@#$%\\^&*()_\\-+=!~`]{4,128}$")
  identifier: string;
}

/** Session code execution identifier path parameter. */
model CodeExecutionIdentifier {
  /** The identifier of code execution. */
  @path
  executionId: string;
}

/** The session resource file path parameter. */
model SessionResourceFilePathQueryParameter {
  /** The path of the file after uploaded. */
  @query
  path?: string;
}

/** The session resource file recursive list parameter. */
@added(Versions.v2025_10_02_preview)
model SessionResourceFileRecursiveListParameter {
  /** Whether to recursively list files. Default to false that would only list files in the current directory. */
  @query
  @added(Versions.v2025_10_02_preview)
  recursive?: boolean;
}

/** The session resource file name parameter. */
model SessionResourceFileNamePathParameter {
  /** The name of the file. */
  @path
  name: string;
}
