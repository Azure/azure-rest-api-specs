import "@typespec/versioning";
import "./chat.completions.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

@added(ServiceApiVersions.v2023_08_01_Preview)
@doc("""
  A representation of configuration data for a single Azure OpenAI chat extension as used by a corresponding chat
  completions request that should use Azure OpenAI chat extensions to augment its behavior.
  The use of this configuration is compatible only with Azure OpenAI.
""")
model AzureChatExtensionConfiguration {
  @doc("""
    The label for the type of an Azure chat extension. This typically corresponds to a matching Azure resource.
    Azure chat extensions are only compatible with Azure OpenAI.
  """)
  type: string;

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
    course of generating a chat completions response that was augmented by capabilities from Azure chat extensions.
  """)
  messages?: ChatMessage[];
}
