import "@typespec/versioning";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("""
A specific representation of configurable options for Azure Machine Learning index when using it as an Azure OpenAI chat
extension.
""")
model AzureMachineLearningIndexChatExtensionConfiguration
  extends AzureChatExtensionConfiguration {

  @doc("""
  The type label to use when configuring Azure OpenAI chat extensions. This should typically not be changed from its
  default value for Azure Machine Learning index.
  """)
  type: AzureChatExtensionType.azureMachineLearningIndex;

  @doc("The parameters for the Azure Machine Learning index chat extension.")
  parameters: AzureMachineLearningIndexChatExtensionParameters;
}

@added(ServiceApiVersions.v2023_12_01_Preview)
model AzureMachineLearningIndexChatExtensionParameters {
  ...OnYourDataCommonChatExtensionConfiguration;

  @doc("The resource id of the Azure Machine Learning project.")
  @projectedName("csharp", "ProjectResourceId")
  projectResourceId: string;

  @doc("The Azure Machine Learning index name.")
  @projectedName("csharp", "Name")
  name: string;

  @doc("The version of the Azure Machine Learning index.")
  @projectedName("csharp", "Version")
  version: string;

  @doc("Search filter. Only supported if the MLIndex is of type AzureSearch.")
  @projectedName("csharp", "Filter")
  filter?: string;
}
