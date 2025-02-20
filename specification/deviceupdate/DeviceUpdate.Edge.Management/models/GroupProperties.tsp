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
 * Device Update Group properties.
 */
model GroupProperties {
  /**
   * Provisioning state.
   */
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
  @visibility("read", "create")
  groupType: GroupType;

  /**
   * Date and time in UTC when the Group was created.
   */
  @visibility("read")
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
