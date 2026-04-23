import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./HealthPolicyModels.tsp";

using Azure.ResourceManager;

namespace Microsoft.Network;

scalar HealthPolicyId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateTrafficManagerProfiles/healthPolicies",
    }
  ]>;

@doc("The status of the endpoint. If the endpoint is Enabled, it is probed for endpoint health and is included in the traffic routing method.")
union AdministrativeStatus {
  string,

  @doc("The endpoint is enabled and is probed for health.")
  Enabled: "Enabled",

  @doc("The endpoint is disabled and is not probed for health.")
  Disabled: "Disabled",
}

@doc("Class representing the kind of the Private Traffic Manager endpoint.")
union EndpointsKind {
  string,

  @doc("Private Traffic Manager Endpoint")
  Endpoint: "Endpoint",
}

@doc("If Always Serve is enabled, probing for endpoint health will be disabled and endpoints will be included in the traffic routing method.")
union AlwaysServe {
  string,

  @doc("Always serve is enabled, endpoint health probing is disabled.")
  Enabled: "Enabled",

  @doc("Always serve is disabled, endpoint health probing is active.")
  Disabled: "Disabled",
}

@doc("Class representing a Traffic Manager endpoint properties.")
model EndpointProperties {
  @doc("The fully-qualified DNS name or IP address of the endpoint. Traffic Manager returns this value in DNS responses to direct traffic to this endpoint.")
  target: string;

  @doc("Monitoring target is where Private Traffic Manager will gather health information.If MonitoringTarget is not configured EndpointTarget will be used instead. If the EndpointTarget is IPv6 then the Monitoring Target MUST be configured. Monitoring Target cannot be an IPv6 address.")
  monitoringTarget?: string;

  @doc("The status of the endpoint. If the endpoint is Enabled, it is probed for endpoint health and is included in the traffic routing method.")
  endpointStatus?: AdministrativeStatus;

  ...ResourceKindProperty<EndpointsKind>;

  @doc("The weight of this endpoint when using the 'Weighted' traffic routing method. Possible values are from 1 to 1000.")
  @minValue(1)
  @maxValue(1000)
  weight?: int64;

  @doc("The priority of this endpoint when using the 'Priority' traffic routing method. Possible values are from 1 to 1000, lower values represent higher priority. This is an optional parameter.  If specified, it must be specified on all endpoints, and no two endpoints can share the same priority value.")
  @minValue(1)
  @maxValue(1000)
  priority?: int64;

  @doc("Indicates whether endpoint is Always Serve or not. Always Serve endpoints are always considered to be healthy.")
  alwaysServe?: AlwaysServe;

  @doc("The health policy associated with this endpoint.")
  healthPolicyId?: HealthPolicyId;

  @visibility(Lifecycle.Read)
  @doc("Provisioning state of the resource.")
  provisioningState?: provisioningStateProperties;
}

@doc("Class representing an inline endpoint within a Traffic Manager profile.")
model ProfileEndpoint {
  @doc("The name of the endpoint.")
  name: string;

  ...EndpointProperties;
}
