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
 * Edge Machine Security Settings proxy resource
 */
@added(Versions.v2026_10_15_preview)
@parentResource(EdgeMachine)
model EdgeMachineSecuritySettings
  is Azure.ResourceManager.ProxyResource<EdgeMachineSecurityProperties> {
  /**
   * Name of the security settings resource
   */
  @path
  @key("securitySettingsName")
  @segment("securitySettings")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@armResourceOperations
interface EdgeMachineSecuritySettingsOperations {
  /**
   * Get an EdgeMachineSecuritySettings
   */
  @added(Versions.v2026_10_15_preview)
  get is ArmResourceRead<EdgeMachineSecuritySettings>;

  /**
   * Create or update an EdgeMachineSecuritySettings
   */
  @added(Versions.v2026_10_15_preview)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EdgeMachineSecuritySettings>;

  /**
   * Delete an EdgeMachineSecuritySettings
   */
  @added(Versions.v2026_10_15_preview)
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineSecuritySettings>;

  /**
   * List EdgeMachineSecuritySettings by EdgeMachine
   */
  @added(Versions.v2026_10_15_preview)
  listByEdgeMachine is ArmResourceListByParent<EdgeMachineSecuritySettings>;

  /**
   * Trigger refresh sync for edge machine security settings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "The final response has no content, so 204 is returned."
  @added(Versions.v2026_10_15_preview)
  refresh is ArmResourceActionNoContentAsync<EdgeMachineSecuritySettings, void>;
}
