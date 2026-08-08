import "../Common/StandardizedContracts/AssessedWorkloadProperties.tsp";
import "../Common/StandardizedContracts/CostComponent.tsp";
import "../Common/CommonModels.tsp";
import "./NetworkAssessment.tsp";
import "./AssessedNetworkTopology.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Assessed virtual network web model class.")
@parentResource(NetworkAssessment)
model AssessedVirtualNetwork
  is ProxyResource<AssessedVirtualNetworkProperties> {
  @doc("Network assessment assessed virtual network ARM name.")
  @key("assessedVirtualNetworkName")
  @segment("assessedVirtualNetworks")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AssessedVirtualNetwork doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Assessed virtual network properties web model.")
model AssessedVirtualNetworkProperties
  is AssessedWorkloadProperties<Linkages, NetworkEntityRecommendations> {
  @doc("The resource name.")
  @visibility(Lifecycle.Read)
  resourceName?: string;

  @doc("The virtual network extended details.")
  @visibility(Lifecycle.Read)
  extendedDetails?: VirtualNetworkExtendedDetails;

  @doc("When was assessed virtual network first created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("When was assessed virtual network last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

@doc("Virtual network extended details.")
model VirtualNetworkExtendedDetails {
  @doc("The address ranges of the virtual network.")
  @visibility(Lifecycle.Read)
  addressRanges?: string[];
}
