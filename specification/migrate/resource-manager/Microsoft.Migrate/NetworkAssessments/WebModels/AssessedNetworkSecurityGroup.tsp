import "../Common/StandardizedContracts/AssessedWorkloadProperties.tsp";
import "../Common/StandardizedContracts/CostComponent.tsp";
import "../Common/CommonModels.tsp";
import "./NetworkAssessment.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Assessed network security group web model class.")
@parentResource(NetworkAssessment)
model AssessedNetworkSecurityGroup
  is ProxyResource<AssessedNetworkSecurityGroupProperties> {
  @doc("Network assessment assessed network security group ARM name.")
  @key("assessedNetworkSecurityGroupName")
  @segment("assessedNetworkSecurityGroups")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AssessedNetworkSecurityGroup doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Assessed network security group properties web model.")
model AssessedNetworkSecurityGroupProperties
  is AssessedWorkloadProperties<Linkages, NetworkEntityRecommendations> {
  @doc("The resource name.")
  @visibility(Lifecycle.Read)
  resourceName?: string;

  @doc("The network security group extended details.")
  @visibility(Lifecycle.Read)
  extendedDetails?: NsgExtendedDetails;

  @doc("When was assessed network security group first created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("When was assessed network security group last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

@doc("Network security group extended details.")
model NsgExtendedDetails {
  @doc("The total number of custom security rules in this network security group.")
  @visibility(Lifecycle.Read)
  customRuleCount?: int32;

  @doc("The total number of default security rules in this network security group.")
  @visibility(Lifecycle.Read)
  defaultRuleCount?: int32;

  @doc("The number of subnets associated with this network security group.")
  @visibility(Lifecycle.Read)
  associatedSubnetCount?: int32;

  @doc("The number of network interfaces associated with this network security group.")
  @visibility(Lifecycle.Read)
  associatedNicCount?: int32;
}
