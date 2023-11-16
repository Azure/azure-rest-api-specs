import "@typespec/versioning";
import "./azure_chat_extensions.tsp";
import "./extensions_onyourdata_authentication.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

alias OnYourDataCommonChatExtensionConfiguration = {
  @doc("The authentication option to access the data.")
  @projectedName("csharp", "Authentication")
  authentication?: OnYourDataAuthenticationOptions;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  @doc("The configured top number of documents to feature for the configured query.")
  @projectedName("csharp", "DocumentCount")
  topNDocuments?: int32;

  @doc("Whether queries should be restricted to use of indexed data.")
  @projectedName("csharp", "ShouldRestrictResultScope")
  inScope?: boolean;

  @doc("The configured strictness of the search relevance filtering. The higher of strictness, the higher of the precision but lower recall of the answer.")
  @minValue(1)
  @maxValue(5)
  strictness?: int32;

  @doc("Give the model instructions about how it should behave and any context it should reference when generating a response. You can describe the assistant's personality and tell it how to format responses. There's a 100 token limit for it, and it counts against the overall token limit.")
  roleInformation?: string;
};
