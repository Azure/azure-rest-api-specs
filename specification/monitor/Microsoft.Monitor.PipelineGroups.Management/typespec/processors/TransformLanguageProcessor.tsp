/*
  Definitions of elements defined for Transform language processor.
*/

using TypeSpec.Versioning;

namespace Microsoft.Monitor;

@doc("Transform language processor.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model TransformLanguageProcessor {
  @doc("Transform statement to execute over the data passing through the processor.")
  @minLength(1)
  @maxLength(10000)
  transformStatement: string;
}
