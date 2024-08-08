import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

@added(ServiceApiVersions.v2024_02_15_Preview)
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

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("Parameters for the Azure Machine Learning vector index chat extension. The supported authentication types are AccessToken, SystemAssignedManagedIdentity and UserAssignedManagedIdentity.")
model AzureMachineLearningIndexChatExtensionParameters {
  ...OnYourDataCommonChatExtensionConfiguration;

  @doc("The resource ID of the Azure Machine Learning project.")
  @clientName("ProjectResourceId", "csharp")
  @encodedName("application/json", "project_resource_id")
  projectResourceId: string;

  @doc("The Azure Machine Learning vector index name.")
  @clientName("Name", "csharp")
  name: string;

  @doc("The version of the Azure Machine Learning vector index.")
  @clientName("Version", "csharp")
  version: string;

  @doc("Search filter. Only supported if the Azure Machine Learning vector index is of type AzureSearch.")
  @clientName("Filter", "csharp")
  filter?: string;
}
