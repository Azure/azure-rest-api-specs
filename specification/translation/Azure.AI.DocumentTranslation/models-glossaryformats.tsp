import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models-shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace DocumentTranslation;

@doc("Request parameters for the Glossary Formats.")
model GlossaryFormatParameters {
  ...CommonParameters;
}

@doc("Response for the Glossary Formats.")
model GlossaryFormatResult {
  ...CommonResultHeaders;
  @body
  @doc("Array of the FileFormat.")
  value: FileFormat[];
}
