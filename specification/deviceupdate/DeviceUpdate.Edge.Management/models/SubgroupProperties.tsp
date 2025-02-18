import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DeviceUpdate;

/**
 * Device Update Subgroup properties.
 */
model SubgroupProperties {
  /**
   * Provisioning state.
   */
  @removed(Versions.v2024_10_01_preview)
  @renamedFrom(Versions.v2024_10_01_preview, "provisioningState")
  provisioningStateOld?: ProvisioningState;

  /**
   * Provisioning state.
   */
  @added(Versions.v2024_10_01_preview)
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * This is the ID of the Group
   */
  @visibility("read", "create")
  groupId: string;

  /**
   * This is the Device Class ID of the Subgroup
   */
  deviceClassId: string;

  /**
   * Date and time in UTC when the Subgroup was created.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime: utcDateTime;

  /**
   * The list of deployments for this Subgroup
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  activeDeployments?: ActiveDeployment[];
}
