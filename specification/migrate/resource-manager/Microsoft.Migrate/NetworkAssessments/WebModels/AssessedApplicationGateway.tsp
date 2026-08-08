import "../Common/StandardizedContracts/AssessedWorkloadProperties.tsp";
import "../Common/StandardizedContracts/CostComponent.tsp";
import "../Common/CommonModels.tsp";
import "./NetworkAssessment.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Assessed application gateway web model class.")
@parentResource(NetworkAssessment)
model AssessedApplicationGateway
  is ProxyResource<AssessedApplicationGatewayProperties> {
  @doc("Network assessment assessed application gateway ARM name.")
  @key("assessedApplicationGatewayName")
  @segment("assessedApplicationGateways")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AssessedApplicationGateway doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Assessed application gateway properties web model.")
model AssessedApplicationGatewayProperties
  is AssessedWorkloadProperties<Linkages, NetworkEntityRecommendations> {
  @doc("The resource name.")
  @visibility(Lifecycle.Read)
  resourceName?: string;

  @doc("The application gateway extended details.")
  @visibility(Lifecycle.Read)
  extendedDetails?: ApplicationGatewayExtendedDetails;

  @doc("When was assessed application gateway first created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("When was assessed application gateway last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

@doc("Application gateway extended details.")
model ApplicationGatewayExtendedDetails {
  @doc("The name of the application gateway SKU.")
  @visibility(Lifecycle.Read)
  sku?: AppGwSku;

  @doc("The scope of the application gateway indicating external (Public) or internal (Private).")
  @visibility(Lifecycle.Read)
  type?: AppGwType;

  @doc("The dedicated subnet name for the application gateway.")
  @visibility(Lifecycle.Read)
  subnetName?: string;

  @doc("Frontend IP configurations of the application gateway resource.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  frontendIpConfigurations?: AppGwFrontendIpConfig[];

  @doc("Backend address pools of the application gateway resource.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  backendAddressPools?: AppGwBackendAddressPool[];

  @doc("Backend settings of the application gateway resource.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  backendSettingsCollection?: AppGwBackendSettings[];

  @doc("Listeners of the application gateway resource.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  listeners?: AppGwListener[];

  @doc("Health probes of the application gateway resource.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  probes?: AppGwHealthProbe[];

  @doc("Autoscale configuration of the application gateway resource.")
  @visibility(Lifecycle.Read)
  autoscaleConfiguration?: AppGwAutoscaleConfiguration;
}
