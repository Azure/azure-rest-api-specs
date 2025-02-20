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
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * This is the ID of the parent Group resource
   */
  @visibility("read", "create")
  groupId: string;

  /**
   * This is the Device Class ID of this Subgroup
   */
  @visibility("read", "create")
  deviceClassId: string;

  /**
   * Date and time in UTC when the Subgroup was created.
   */
  @visibility("read")
  createdDateTime: utcDateTime;

  /**
   * The list of deployments for this Subgroup
   */
  @visibility("read")
  activeDeployment?: ActiveDeployment;
}
