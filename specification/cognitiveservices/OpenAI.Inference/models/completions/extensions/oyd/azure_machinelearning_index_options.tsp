import "@typespec/versioning";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("""
A specific representation of configurable options for Azure Machine Learning vector index when using it as an Azure
OpenAI chat extension.
""")
model AzureMachineLearningIndexChatExtensionConfiguration
  extends AzureChatExtensionConfiguration {
  @doc("""
  The type label to use when configuring Azure OpenAI chat extensions. This should typically not be changed from its
  default value for Azure Machine Learning vector index.
  """)
  type: AzureChatExtensionType.azureMachineLearningIndex;

  @doc("The parameters for the Azure Machine Learning vector index chat extension.")
  parameters: AzureMachineLearningIndexChatExtensionParameters;
}

@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("Parameters for the Azure Machine Learning vector index chat extension.")
model AzureMachineLearningIndexChatExtensionParameters {
  ...OnYourDataCommonChatExtensionConfiguration;

  @doc("The resource ID of the Azure Machine Learning project.")
  @projectedName("csharp", "ProjectResourceId")
  projectResourceId: string;

  @doc("The Azure Machine Learning vector index name.")
  @projectedName("csharp", "Name")
  name: string;

  @doc("The version of the Azure Machine Learning vector index.")
  @projectedName("csharp", "Version")
  version: string;

  @doc("Search filter. Only supported if the Azure Machine Learning vector index is of type AzureSearch.")
  @projectedName("csharp", "Filter")
  filter?: string;
}
