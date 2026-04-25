import "../Common/StandardizedContracts/AssessedWorkloadProperties.tsp";
import "../Common/StandardizedContracts/CostComponent.tsp";
import "../Common/CommonModels.tsp";
import "./AssessedVirtualNetwork.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Assessed subnet web model class.")
@parentResource(AssessedVirtualNetwork)
model AssessedSubnet is ProxyResource<AssessedSubnetProperties> {
  @doc("Network assessment assessed subnet ARM name.")
  @key("assessedSubnetName")
  @segment("assessedSubnets")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AssessedSubnet doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Assessed subnet properties web model.")
model AssessedSubnetProperties
  is AssessedWorkloadProperties<Linkages, NetworkEntityRecommendations> {
  @doc("The resource name.")
  @visibility(Lifecycle.Read)
  resourceName?: string;

  @doc("The subnet extended details.")
  @visibility(Lifecycle.Read)
  extendedDetails?: SubnetExtendedDetails;

  @doc("When was assessed subnet first created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("When was assessed subnet last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

@doc("Subnet extended details.")
model SubnetExtendedDetails {
  @doc("The address ranges of the subnet.")
  @visibility(Lifecycle.Read)
  addressRanges?: string[];
}
