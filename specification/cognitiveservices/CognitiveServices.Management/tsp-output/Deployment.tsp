import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CognitiveServices;
@doc("Cognitive Services account deployment.")
@parentResource(Account)
model Deployment is ProxyResource<DeploymentProperties> {
  @doc("The name of the deployment associated with the Cognitive Services Account")
  @key("deploymentName")
  @segment("deployments")
  name: string;

  @doc("Resource Etag.")
  @visibility("read")
  etag?: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Deployments {
  @doc("Gets the specified deployments associated with the Cognitive Services account.")
  get is ArmResourceRead<Deployment>;
  @doc("Update the state of specified deployments associated with the Cognitive Services account.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Deployment>;
  @doc("Deletes the specified deployment associated with the Cognitive Services account.")
  delete is ArmResourceDeleteAsync<Deployment>;
  @doc("Gets the deployments associated with the Cognitive Services account.")
  list is ArmResourceListByParent<Deployment>;
}
