import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.OpenEnergyPlatform;

@doc("The provisioning state of the resource.")
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Resource is being created.")
  Creating: "Creating",

  @doc("Resource is being deleted.")
  Deleting: "Deleting",

  @doc("Resource is being updated.")
  Updating: "Updating",

  @doc("Resource state is unknown.")
  Unknown: "Unknown",
}

@doc("The properties of an Energy service resource.")
model EnergyServiceProperties {
  @doc("The DNS name of the energy service resource.")
  @visibility(Lifecycle.Read)
  dnsName?: string;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The authentication application ID.")
  authAppId?: string;

  @doc("The list of data partition names.")
  dataPartitionNames?: DataPartitionNames[];
}

@doc("The data partition name.")
model DataPartitionNames {
  @doc("The name of the data partition.")
  name?: string;
}

@doc("The resource model definition used for updating a tracked ARM resource.")
model EnergyResourceUpdate {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Defines the partition add or remove action properties.")
model DataPartitionAddOrRemoveRequest {
  @doc("The data partition name.")
  name?: DataPartitionNames;
}

@doc("Defines the properties of an individual data partition.")
model DataPartitionProperties {
  @doc("Name of the data partition.")
  name?: string;

  @doc("Provisioning state of the data partition.")
  provisioningState?: string;
}

@doc("List of data partitions.")
model DataPartitionsListResult {
  @doc("List of data partitions along with their properties in a given OEP resource.")
  dataPartitionInfo?: DataPartitionProperties[];
}

@doc("Empty request body for list partitions action.")
model ListPartitionsRequest {}
