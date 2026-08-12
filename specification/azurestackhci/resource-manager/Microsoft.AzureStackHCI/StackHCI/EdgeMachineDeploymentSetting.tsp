import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./EdgeMachine.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.AzureStackHCI;

/**
 * Deployment setting resource for an Edge Machine.
 */
@added(Versions.v2026_10_15_preview)
@parentResource(EdgeMachine)
model EdgeMachineDeploymentSetting
  is Azure.ResourceManager.ProxyResource<EdgeMachineDeploymentSettingProperties> {
  /**
   * Name of Edge Machine Deployment Setting.
   */
  @path
  @key("deploymentSettingName")
  @segment("deploymentSettings")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string = "default";
}

@armResourceOperations
interface EdgeMachineDeploymentSettings {
  /**
   * Get an Edge Machine Deployment Setting.
   */
  @added(Versions.v2026_10_15_preview)
  get is ArmResourceRead<EdgeMachineDeploymentSetting>;

  /**
   * Create or update an Edge Machine Deployment Setting.
   */
  @added(Versions.v2026_10_15_preview)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EdgeMachineDeploymentSetting>;

  /**
   * Delete an Edge Machine Deployment Setting.
   */
  @added(Versions.v2026_10_15_preview)
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineDeploymentSetting>;

  /**
   * List Edge Machine Deployment Setting resources by Edge Machine.
   */
  @added(Versions.v2026_10_15_preview)
  listByEdgeMachine is ArmResourceListByParent<EdgeMachineDeploymentSetting>;
}
