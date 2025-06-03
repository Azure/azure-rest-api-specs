/*
  Definitions of elements defined for Transform language processor.
*/

namespace Microsoft.Monitor;

@doc("Transform language processor.")
model TransformLanguageProcessor {
  @doc("Query to execute on data passing through the processor")
  query: string;
}
