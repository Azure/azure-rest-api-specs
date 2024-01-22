import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.OpenEnergyPlatform;

interface Operations extends Azure.ResourceManager.Operations {}

enum ProvisioningState {
  Unknown,
  Succeeded,
  Failed,
  Canceled,
  Creating,
  Deleting,
  Updating,
}

/**
 * The check availability request body.
 */
model CheckNameAvailabilityRequest {
  /**
   * The name of the resource for which availability needs to be checked.
   */
  name?: string;

  /**
   * The resource type.
   */
  type?: string;
}

/**
 * The check availability result.
 */
model CheckNameAvailabilityResponse {
  /**
   * Indicates if the resource name is available.
   */
  nameAvailable?: boolean;

  /**
   * The reason why the given name is not available.
   */
  reason?: CheckNameAvailabilityReason;

  /**
   * Detailed reason why the given name is available.
   */
  message?: string;
}

model EnergyServiceProperties {
  @visibility("read")
  dnsName?: string;

  @visibility("read")
  provisioningState?: ProvisioningState;

  authAppId?: string;
  dataPartitionNames?: DataPartitionNames[];
}

/**
 * The list of Energy services resource's Data Partition Names.
 */
model DataPartitionNames {
  name?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The resource model definition used for updating a tracked ARM resource.
 */
model EnergyResourceUpdate {
  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Defines the partition add/ delete action properties.
 */
model DataPartitionAddOrRemoveRequest {
  /**
   * The list of Energy services resource's Data Partition Names.
   */
  name?: DataPartitionNames;
}

/**
 * List of data partitions.
 */
model DataPartitionsListResult {
  /**
   * List of data partitions along with their properties in a given OEP resource.
   */
  dataPartitionInfo?: DataPartitionProperties[];
}

/**
 * Defines the properties of an individual data partition.
 */
model DataPartitionProperties {
  /**
   * Name of the data partition
   */
  name?: string;

  /**
   * Name of the data partition
   */
  provisioningState?: string;
}

/**
 * List of data partitions
 */
model DataPartitionsList {
  dataPartitionNames?: DataPartitionNames[];
}
