import "@typespec/versioning";
import "./models_tagger.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "AI Casing style to match OpenAI"
namespace HealthDataAIServices.DeidServices;

@doc("Request body for de-identification operation.")
model DeidentificationContent {
  @doc("Input text to de-identify.")
  @maxLength(48000) // 50k total request size. 2k for other fields.
  inputText: string;

  @doc("Operation to perform on the input documents.")
  @clientName("operationType", "csharp,java,python")
  operation?: DeidentificationOperationType = DeidentificationOperationType.Surrogate;

  @doc("List of PHI entities with simplified single encoding for SurrogateOnly operation. Cannot be used with Entities.")
  @added(Versions.v2024_12_15)
  encodedEntities?: Array<EncodedPhiEntity>;

  @doc("List of PHI entities for SurrogateOnly operation with full encoding information. Cannot be used with EncodedEntities.")
  @added(Versions.v2024_12_15)
  entities?: Array<PhiEntity>;

  @doc("Customization parameters to override default service behaviors.")
  customizations?: DeidentificationCustomizationOptions;
}

@doc("Response body for de-identification operation.")
model DeidentificationResult {
  @doc("Output text after de-identification. Not available for \"Tag\" operation.")
  outputText?: string;

  @doc("Result of the \"Tag\" operation. Only available for \"Tag\" Operation.")
  taggerResult?: PhiTaggerResult;
}

// TODO: Add documentation link for customization options.
@doc("Customizations options to override default service behaviors for synchronous usage.")
model DeidentificationCustomizationOptions {
  ...SharedCustomizationOptions;
}
