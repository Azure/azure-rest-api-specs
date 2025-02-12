import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models.tsp";
import "../main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DeviceUpdate;

/**
 * Device Update Group properties.
 */
model GroupProperties {
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
   * This is the Type of the Group
   */
  groupType: GroupType;

  /**
   * Date and time in UTC when the Group was created.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime: utcDateTime;
}

/**
 * Group type
 */
union GroupType {
  string,

  /**
   * Default Group for untagged devices that do not belong to a Group yet
   */
  DefaultNoTag: "DefaultNoTag",

  /**
   * Group type using Azure Resource Tags
   */
  AzureResourceTag: "AzureResourceTag",
}
