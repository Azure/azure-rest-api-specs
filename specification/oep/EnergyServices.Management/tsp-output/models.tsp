import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Azure.ResourceManager.EnergyServices;

interface Operations extends Azure.ResourceManager.Operations {}

enum CheckNameAvailabilityReason {
  Invalid,
  AlreadyExists,
}

enum ProvisioningState {
  Unknown,
  Succeeded,
  Failed,
  Canceled,
  Creating,
  Deleting,
  Updating,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

@doc("The check availability request body.")
model CheckNameAvailabilityRequest {
  @doc("The name of the resource for which availability needs to be checked.")
  name?: string;

  @doc("The resource type.")
  type?: string;
}

@doc("The check availability result.")
model CheckNameAvailabilityResponse {
  @doc("Indicates if the resource name is available.")
  nameAvailable?: boolean;

  @doc("The reason why the given name is not available.")
  reason?: CheckNameAvailabilityReason;

  @doc("Detailed reason why the given name is available.")
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

@doc("The list of Energy services resource's Data Partition Names.")
model DataPartitionNames {
  name?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The resource model definition used for updating a tracked ARM resource.")
model EnergyResourceUpdate {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Defines the partition add/ delete action properties.")
model DataPartitionAddOrRemoveRequest {
  @doc("The list of Energy services resource's Data Partition Names.")
  name?: DataPartitionNames;
}

@doc("List of data partitions.")
model DataPartitionsListResult {
  @doc("List of data partitions along with their properties in a given OEP resource.")
  dataPartitionInfo?: DataPartitionProperties[];
}

@doc("Defines the properties of an individual data partition.")
model DataPartitionProperties {
  @doc("Name of the data partition")
  name?: string;

  @doc("Name of the data partition")
  provisioningState?: string;
}

@doc("List of data partitions")
model DataPartitionsList {
  dataPartitionNames?: DataPartitionNames[];
}
