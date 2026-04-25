import "../Common/StandardizedContracts/AssessedWorkloadProperties.tsp";
import "../Common/StandardizedContracts/CostComponent.tsp";
import "../Common/CommonModels.tsp";
import "./AssessedApplicationGateway.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Assessed application gateway routing rule web model class.")
@parentResource(AssessedApplicationGateway)
model AssessedAppGwRoutingRule
  is ProxyResource<AssessedAppGwRoutingRuleProperties> {
  @doc("Network assessment assessed application gateway routing rule ARM name.")
  @key("assessedAppGwRoutingRuleName")
  @segment("assessedAppGwRoutingRules")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AssessedAppGwRoutingRule doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Assessed application gateway routing rule properties web model.")
model AssessedAppGwRoutingRuleProperties
  is AssessedWorkloadProperties<Linkages, NetworkEntityRecommendations> {
  @doc("The resource name.")
  @visibility(Lifecycle.Read)
  resourceName?: string;

  @doc("The application gateway routing rule extended details.")
  @visibility(Lifecycle.Read)
  extendedDetails?: AppGwRoutingRuleExtendedDetails;

  @doc("When was assessed application gateway routing rule first created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("When was assessed application gateway routing rule last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

@doc("Application gateway routing rule extended details.")
model AppGwRoutingRuleExtendedDetails {
  @doc("Rule type.")
  @visibility(Lifecycle.Read)
  ruleType?: AppGwRequestRoutingRuleType;

  @doc("Priority of the request routing rule.")
  @visibility(Lifecycle.Read)
  priority?: int32;

  @doc("The listener associated with this rule.")
  @visibility(Lifecycle.Read)
  listener?: AppGwListener;

  @doc("The name of the backend address pool associated with this rule.")
  @visibility(Lifecycle.Read)
  backendAddressPool?: string;

  @doc("The backend settings associated with this rule.")
  @visibility(Lifecycle.Read)
  backendSettings?: AppGwBackendSettings;
}
