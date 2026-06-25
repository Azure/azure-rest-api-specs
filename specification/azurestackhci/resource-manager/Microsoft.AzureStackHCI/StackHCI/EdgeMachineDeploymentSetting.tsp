import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EdgeMachine.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;

/**
 * Deployment setting resource for an Edge Machine.
 */
@added(Versions.v2026_05_01_preview)
@parentResource(EdgeMachine)
model EdgeMachineDeploymentSetting
  is Azure.ResourceManager.ProxyResource<EdgeMachineDeploymentSettingProperties> {
  @path
  @key("deploymentSettingName")
  @segment("deploymentSettings")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string = "default";
}

@added(Versions.v2026_05_01_preview)
@armResourceOperations
interface EdgeMachineDeploymentSettings {
  /**
   * Get an Edge Machine Deployment Setting.
   */
  get is ArmResourceRead<EdgeMachineDeploymentSetting>;

  /**
   * Create or update an Edge Machine Deployment Setting.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EdgeMachineDeploymentSetting>;

  /**
   * Delete an Edge Machine Deployment Setting.
   */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineDeploymentSetting>;

  /**
   * List Edge Machine Deployment Setting resources by Edge Machine.
   */
  listByEdgeMachine is ArmResourceListByParent<EdgeMachineDeploymentSetting>;
}

@@doc(
  EdgeMachineDeploymentSetting.name,
  "Name of Edge Machine Deployment Setting"
);
@@doc(
  EdgeMachineDeploymentSetting.properties,
  "The resource-specific properties for this resource."
);
@@visibility(
  EdgeMachineDeploymentSetting.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
