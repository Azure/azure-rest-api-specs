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
 * Device Update Device Class Subgroup properties.
 */
model DeviceClassSubgroupProperties {
  /**
   * Provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * This is the ID of the parent Group resource
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  groupId: string;

  /**
   * This is the Device Class ID of this Subgroup
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  deviceClassId: string;

  /**
   * Active deployment ID for this Subgroup
   */
  @visibility(Lifecycle.Read)
  activeDeploymentId?: string;
}
