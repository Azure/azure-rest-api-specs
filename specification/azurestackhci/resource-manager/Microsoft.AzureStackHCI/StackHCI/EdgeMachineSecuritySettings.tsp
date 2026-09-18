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
@added(Versions.v2026_10_01)
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
  @added(Versions.v2026_10_01)
  get is ArmResourceRead<EdgeMachineSecuritySettings>;

  /**
   * Create or update an EdgeMachineSecuritySettings
   */
  @added(Versions.v2026_10_01)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EdgeMachineSecuritySettings>;

  /**
   * Delete an EdgeMachineSecuritySettings
   */
  @added(Versions.v2026_10_01)
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineSecuritySettings>;

  /**
   * List EdgeMachineSecuritySettings by EdgeMachine
   */
  @added(Versions.v2026_10_01)
  listByEdgeMachine is ArmResourceListByParent<EdgeMachineSecuritySettings>;
}
