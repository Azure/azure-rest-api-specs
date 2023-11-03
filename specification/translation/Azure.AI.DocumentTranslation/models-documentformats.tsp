import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models-shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace DocumentTranslation;

@doc("Request parameters for the Document file Formats.")
model DocumentFormatParameters {
  ...CommonParameters;
}

@doc("Response for the Document Formats.")
model DocumentormatResult {
  ...CommonResultHeaders;
  @body
  @doc("Array of the FileFormat.")
  value: FileFormat[];
}
