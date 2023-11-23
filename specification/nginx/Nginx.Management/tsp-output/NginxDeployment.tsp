import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Nginx.NginxPlus;

model NginxDeployment is TrackedResource<NginxDeploymentProperties> {
  @doc("The name of targeted Nginx deployment")
  @path
  @key("deploymentName")
  @segment("nginxDeployments")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface NginxDeployments {
  @doc("Get the Nginx deployment")
  get is ArmResourceRead<NginxDeployment>;
  @doc("Create or update the Nginx deployment")
  create is ArmResourceCreateOrUpdateAsync<NginxDeployment>;
  @doc("Update the Nginx deployment")
  update is ArmResourcePatchAsync<NginxDeployment, NginxDeploymentProperties>;
  @doc("Delete the Nginx deployment resource")
  delete is ArmResourceDeleteAsync<NginxDeployment>;
  @doc("List all Nginx deployments under the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<NginxDeployment>;
  @doc("List the Nginx deployments resources")
  list is ArmListBySubscription<NginxDeployment>;
}
