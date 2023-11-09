import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models-shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace DocumentTranslation;

/** Request parameters for the Glossary Formats. */
model GlossaryFormatParameters {
  ...CommonParameters;
}

/** Response for the Glossary Formats. */
model GlossaryFormatResult {
  ...CommonResultHeaders;
  @body
  /** Array of the FileFormat. */
  value: FileFormat[];
}
