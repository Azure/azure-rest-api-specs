import "../Common/StandardizedContracts/AssessedWorkloadProperties.tsp";
import "../Common/StandardizedContracts/CostComponent.tsp";
import "../Common/CommonModels.tsp";
import "./NetworkAssessment.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Assessed network topology web model class.")
@parentResource(NetworkAssessment)
model AssessedNetworkTopology
  is ProxyResource<AssessedNetworkTopologyProperties> {
  @doc("Network assessment assessed topology ARM name.")
  @key("assessedNetworkTopologyName")
  @segment("assessedNetworkTopologies")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AssessedNetworkTopology doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Assessed network topology properties web model.")
model AssessedNetworkTopologyProperties
  is AssessedWorkloadProperties<Linkages, NetworkTopologyRecommendation> {
  @doc("The resource name.")
  @visibility(Lifecycle.Read)
  resourceName?: string;

  @doc("When was assessed network topology first created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("When was assessed network topology last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

@doc("Network topology recommendation details.")
model NetworkTopologyRecommendation is NetworkEntityRecommendations {
  @doc("Gets the summary of recommended network resources and their counts.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  networkResourcesSummary?: NameValuePair<string, int32>[];
}
