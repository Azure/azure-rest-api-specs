import "../Common/StandardizedContracts/AssessedWorkloadProperties.tsp";
import "../Common/StandardizedContracts/CostComponent.tsp";
import "../Common/CommonModels.tsp";
import "./NetworkAssessment.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Assessed load balancer web model class.")
@parentResource(NetworkAssessment)
model AssessedLoadBalancer is ProxyResource<AssessedLoadBalancerProperties> {
  @doc("Network assessment assessed load balancer ARM name.")
  @key("assessedLoadBalancerName")
  @segment("assessedLoadBalancers")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AssessedLoadBalancer doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Assessed load balancer properties web model.")
model AssessedLoadBalancerProperties
  is AssessedWorkloadProperties<Linkages, NetworkEntityRecommendations> {
  @doc("The resource name.")
  @visibility(Lifecycle.Read)
  resourceName?: string;

  @doc("The load balancer extended details.")
  @visibility(Lifecycle.Read)
  extendedDetails?: LoadBalancerExtendedDetails;

  @doc("When was assessed load balancer first created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("When was assessed load balancer last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

@doc("Load balancer extended details.")
model LoadBalancerExtendedDetails {
  @doc("The frontend IP configurations of the load balancer.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  frontendIpConfigurations?: LbFrontendIpConfig[];

  @doc("The health checks (probes) of the load balancer.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  healthChecks?: LbHealthCheck[];

  @doc("The name of the load balancer SKU.")
  @visibility(Lifecycle.Read)
  sku?: LbSkuName;

  @doc("The tier of the load balancer SKU.")
  @visibility(Lifecycle.Read)
  skuTier?: LbSkuTier;

  @doc("The backend address pools of the load balancer.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  backendAddressPools?: LbBackendAddressPool[];

  @doc("The outbound rules of the load balancer. Applicable only for public load balancers.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  outboundRules?: LbOutboundRule[];

  @doc("The scope of the load balancer indicating external (Public) or internal (Internal).")
  @visibility(Lifecycle.Read)
  type?: LbType;
}

@doc("Load balancer frontend IP configuration details.")
model LbFrontendIpConfig {
  @doc("The name of the frontend IP configuration.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The name of the public IP address associated with this frontend IP configuration. Applicable for public load balancers.")
  @visibility(Lifecycle.Read)
  publicIpAddressName?: string;

  @doc("The virtual network associated with the frontend IP configuration. Applicable for internal load balancers.")
  @visibility(Lifecycle.Read)
  virtualNetwork?: string;

  @doc("The subnet associated with the frontend IP configuration. Applicable for internal load balancers.")
  @visibility(Lifecycle.Read)
  subnet?: string;

  @doc("The IP address of the frontend IP configuration in IPv4 or IPv6 format.")
  @visibility(Lifecycle.Read)
  ipAddress?: string;

  @doc("The private IP address allocation method.")
  @visibility(Lifecycle.Read)
  ipAllocationMethod?: LbIpAllocationMethod;
}

@doc("Load balancer health check (probe) details.")
model LbHealthCheck {
  @doc("The name of the health check.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The protocol of the health check.")
  @visibility(Lifecycle.Read)
  protocol?: LbProbeProtocol;

  @doc("The port for communicating the health check.")
  @visibility(Lifecycle.Read)
  port?: int32;

  @doc("The URI used for requesting health status from the VM.")
  @visibility(Lifecycle.Read)
  requestPath?: string;

  @doc("The interval, in seconds, for how frequently to probe the endpoint for health status.")
  @visibility(Lifecycle.Read)
  intervalInSeconds?: int32;

  @doc("The number of probes where if no response, will result in stopping further traffic from being delivered to the endpoint.")
  @visibility(Lifecycle.Read)
  numberOfProbes?: int32;

  @doc("The number of consecutive successful or failed probes in order to allow or deny traffic from being delivered to this endpoint.")
  @visibility(Lifecycle.Read)
  probeThreshold?: int32;
}

@doc("Load balancer backend address pool details.")
model LbBackendAddressPool {
  @doc("The name of the backend address pool.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The resource IDs of the backend pool members (VMs, VMSS instances, or IP addresses).")
  @visibility(Lifecycle.Read)
  memberResourceIds?: armResourceIdentifier[];
}

@doc("Load balancer outbound rule details.")
model LbOutboundRule {
  @doc("The name of the outbound rule.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The protocol for the outbound rule.")
  @visibility(Lifecycle.Read)
  protocol?: LbTransportProtocol;

  @doc("The frontend IP configurations associated with this outbound rule.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  frontendIpConfigurations?: LbRuleFrontendIpConfig[];

  @doc("The backend address pool associated with this outbound rule.")
  @visibility(Lifecycle.Read)
  backendAddressPool?: string;

  @doc("The number of outbound ports to be used for NAT.")
  @visibility(Lifecycle.Read)
  allocatedOutboundPorts?: int32;

  @doc("The timeout for the TCP idle connection in minutes.")
  @visibility(Lifecycle.Read)
  idleTimeoutInMinutes?: int32;

  @doc("Receive bidirectional TCP Reset on TCP flow idle timeout or unexpected connection termination.")
  @visibility(Lifecycle.Read)
  enableTcpReset?: boolean;
}
