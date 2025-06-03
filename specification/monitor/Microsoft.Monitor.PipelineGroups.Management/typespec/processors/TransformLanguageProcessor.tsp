/*
  Definitions of elements defined for Transform language processor.
*/

using TypeSpec.Versioning;

namespace Microsoft.Monitor;

@doc("Transform language processor.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model TransformLanguageProcessor {
  @doc("Query to execute on data passing through the processor")
  query: string;
}
