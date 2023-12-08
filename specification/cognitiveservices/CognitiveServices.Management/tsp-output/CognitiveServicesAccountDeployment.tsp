import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./CognitiveServicesAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CognitiveServices;
@doc("Cognitive Services account deployment.")
@parentResource(CognitiveServicesAccount)
model CognitiveServicesAccountDeployment
  is ProxyResource<DeploymentProperties> {
  @doc("The name of the deployment associated with the Cognitive Services Account")
  @path
  @key("deploymentName")
  @segment("deployments")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface CognitiveServicesAccountDeployments {
  @doc("Gets the specified deployments associated with the Cognitive Services account.")
  get is ArmResourceRead<CognitiveServicesAccountDeployment>;
  @doc("Update the state of specified deployments associated with the Cognitive Services account.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CognitiveServicesAccountDeployment>;
  @doc("Deletes the specified deployment associated with the Cognitive Services account.")
  delete is ArmResourceDeleteAsync<CognitiveServicesAccountDeployment>;
  @doc("Gets the deployments associated with the Cognitive Services account.")
  list is ArmResourceListByParent<CognitiveServicesAccountDeployment>;
}
