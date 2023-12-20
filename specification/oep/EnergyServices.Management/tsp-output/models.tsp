import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

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
