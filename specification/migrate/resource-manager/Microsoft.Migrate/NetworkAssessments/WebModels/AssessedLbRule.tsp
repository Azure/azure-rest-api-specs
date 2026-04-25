import "../Common/StandardizedContracts/AssessedWorkloadProperties.tsp";
import "../Common/StandardizedContracts/CostComponent.tsp";
import "../Common/CommonModels.tsp";
import "./AssessedLoadBalancer.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Assessed load balancer rule web model class.")
@parentResource(AssessedLoadBalancer)
model AssessedLbRule is ProxyResource<AssessedLbRuleProperties> {
  @doc("Network assessment assessed load balancer rule ARM name.")
  @key("assessedLbRuleName")
  @segment("assessedLbRules")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AssessedLbRule doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Assessed load balancer rule properties web model.")
model AssessedLbRuleProperties
  is AssessedWorkloadProperties<Linkages, NetworkEntityRecommendations> {
  @doc("The resource name.")
  @visibility(Lifecycle.Read)
  resourceName?: string;

  @doc("The load balancer rule extended details.")
  @visibility(Lifecycle.Read)
  extendedDetails?: LbRuleExtendedDetails;

  @doc("When was assessed load balancer rule first created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("When was assessed load balancer rule last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

@doc("Load balancer rule extended details.")
model LbRuleExtendedDetails {
  @doc("The transport protocol used by the load balancing rule.")
  @visibility(Lifecycle.Read)
  protocol?: LbTransportProtocol;

  @doc("The frontend IP configuration associated with this rule.")
  @visibility(Lifecycle.Read)
  frontendIpConfiguration?: LbRuleFrontendIpConfig;

  @doc("The port for the external endpoint. Port numbers for each rule must be unique within the Load Balancer.")
  @visibility(Lifecycle.Read)
  frontendPort?: int32;

  @doc("The port used for internal connections on the endpoint.")
  @visibility(Lifecycle.Read)
  backendPort?: int32;

  @doc("The backend address pool associated with this rule.")
  @visibility(Lifecycle.Read)
  backendPool?: string;

  @doc("The health probe associated with this rule.")
  @visibility(Lifecycle.Read)
  healthProbe?: LbRuleHealthProbe;

  @doc("The timeout for the TCP idle connection in minutes.")
  @visibility(Lifecycle.Read)
  idleTimeoutInMinutes?: int32;

  @doc("Configures a virtual machine's endpoint for the floating IP capability.")
  @visibility(Lifecycle.Read)
  enableFloatingIp?: boolean;

  @doc("Receive bidirectional TCP Reset on TCP flow idle timeout or unexpected connection termination.")
  @visibility(Lifecycle.Read)
  enableTcpReset?: boolean;
}
