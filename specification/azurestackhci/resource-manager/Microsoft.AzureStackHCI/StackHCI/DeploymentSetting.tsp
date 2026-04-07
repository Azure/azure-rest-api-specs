import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Edge device resource
 */
@parentResource(Cluster)
model DeploymentSetting
  is Azure.ResourceManager.ProxyResource<DeploymentSettingsProperties> {
  @path
  @key("deploymentSettingsName")
  @segment("deploymentSettings")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string = "default";
}

@armResourceOperations
interface DeploymentSettings {
  /**
   * Get a DeploymentSetting
   */
  get is ArmResourceRead<DeploymentSetting>;

  /**
   * Create a DeploymentSetting
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DeploymentSetting>;

  /**
   * Delete a DeploymentSetting
   */
  delete is ArmResourceDeleteWithoutOkAsync<DeploymentSetting>;

  /**
   * List DeploymentSetting resources by Clusters
   */
  listByClusters is ArmResourceListByParent<DeploymentSetting>;
}

@@doc(DeploymentSetting.name, "Name of Deployment Setting");
@@doc(DeploymentSetting.properties,
  "The resource-specific properties for this resource."
);
@@visibility(DeploymentSetting.properties, Lifecycle.Read, Lifecycle.Create);
