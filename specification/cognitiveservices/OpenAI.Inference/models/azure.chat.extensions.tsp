import "@typespec/versioning";
import "./chat.completions.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

@added(ServiceApiVersions.v2023_08_01_Preview)
@doc("""
  A representation of configuration data for a single Azure OpenAI data source as used with chat extensions to
  augment the behavior of a chat completions request. The use of this configuration is compatible only with
  Azure OpenAI.
""")
model AzureChatDataSourceConfiguration {
  @doc("""
    The label for the type of an Azure chat extension data source, corresponding to a matching Azure resource.
  """)
  type: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "API explicitly uses arbitrary JSON structure"
  @doc("""
    The configuration payload used for the data source, with structure and payload details specific to the data source
    being specified.
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
    The contextual message payload associated with the Azure Extensions used for a Chat Completions request.
    These messages describe the data source retrievals, plugin invocations, and other intermediate steps taken in the
    course of generating a Chat Completions request augmented by Azure capabilities.
  """)
  messages?: ChatMessage[];
}