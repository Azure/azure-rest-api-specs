import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models-shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace DocumentTranslation;

/** Request parameters for the Document file Formats. */
model DocumentFormatParameters {
  ...CommonParameters;
}

/** Response for the Document Formats. */
model DocumentormatResult {
  ...CommonResultHeaders;
  @body
  /** Array of the FileFormat. */
  value: FileFormat[];
}
