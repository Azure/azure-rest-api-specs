import "@typespec/versioning";
import "./chat.completions.tsp";
import "./azure.cognitive.search.options.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

// Explanatory notes for Azure OpenAI chat extensions (as of 2023-08-01-preview):
//  - Although the REST API serves this capability via a distinct /extensions/chat/completions route, client libraries
//    should abstract that detail and dynamically dispatch this on the normal chat completions path, using the
//    specification of extensions in the options (request body payload) as the decision mechanism
//  - A future service API version will merge /extensions/chat/completions into /chat/completions and, at that time,
//    the above ensures there's no customer-facing change or disruption
//  - The current schema for specifying extensions uses a supplementary `dataSources` array at the top level of the
//    request payload. This can be problematic for dynamic selection in some languages (minimally, ambiguous or
//    confusing) and so libraries should instead wrap this in a custom "sub-options" type: wire format will realize as
//    ChatCompletionsOptions.DataSources, but libraries should present that instead as
//    ChatCompletionsOptions.AzureExtensionsOptions.Extensions
//  - Another future service API version (TBD, perhaps the same that merges into /chat/completions) should reflect the
//    structural and naming changes in the wire format

@added(ServiceApiVersions.v2023_08_01_Preview)
@doc("""
  A representation of configuration data for a single Azure OpenAI chat extension. This will be used by a chat
  completions request that should use Azure OpenAI chat extensions to augment the response behavior.
  The use of this configuration is compatible only with Azure OpenAI.
""")
enum AzureChatExtensionType {
  @doc("Represents the use of Azure Cognitive Search as an Azure OpenAI chat extension.")
  azureCognitiveSearch: "AzureCognitiveSearch",
}

@added(ServiceApiVersions.v2023_08_01_Preview)
@doc("""
  A representation of configuration data for a single Azure OpenAI chat extension. This will be used by a chat
  completions request that should use Azure OpenAI chat extensions to augment the response behavior.
  The use of this configuration is compatible only with Azure OpenAI.
""")
model AzureChatExtensionConfiguration {
  @doc("""
    The label for the type of an Azure chat extension. This typically corresponds to a matching Azure resource.
    Azure chat extensions are only compatible with Azure OpenAI.
  """)
  type: AzureChatExtensionType;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "API explicitly uses arbitrary JSON structure"
  @doc("""
    The configuration payload used for the Azure chat extension. The structure payload details are specific to the
    extension being configured.
    Azure chat extensions are only compatible with Azure OpenAI.
  """)
  parameters: unknown;
}

@added(ServiceApiVersions.v2023_08_01_Preview)
@doc("""
  A representation of the additional context information available when Azure OpenAI chat extensions are involved
  in the generation of a corresponding chat completions response. This context information is only populated when
  using an Azure OpenAI request configured to use a matching extension.
""")
model AzureChatExtensionsMessageContext {
  @doc("""
    The contextual message payload associated with the Azure chat extensions used for a chat completions request.
    These messages describe the data source retrievals, plugin invocations, and other intermediate steps taken in the
    course of generating a chat completions response that was augmented by capabilities from Azure OpenAI chat
    extensions.
  """)
  messages?: ChatMessage[];
}
