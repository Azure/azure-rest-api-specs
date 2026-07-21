import "../Common/StandardizedContracts/AssessedWorkloadProperties.tsp";
import "../Common/StandardizedContracts/CostComponent.tsp";
import "../Common/CommonModels.tsp";
import "./AssessedLoadBalancer.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Assessed load balancer inbound NAT rule web model class.")
@parentResource(AssessedLoadBalancer)
model AssessedInboundNatRule
  is ProxyResource<AssessedInboundNatRuleProperties> {
  @doc("Network assessment assessed inbound NAT rule ARM name.")
  @key("assessedInboundNatRuleName")
  @segment("assessedInboundNatRules")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AssessedInboundNatRule doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Assessed inbound NAT rule properties web model.")
model AssessedInboundNatRuleProperties
  is AssessedWorkloadProperties<Linkages, NetworkEntityRecommendations> {
  @doc("The resource name.")
  @visibility(Lifecycle.Read)
  resourceName?: string;

  @doc("The inbound NAT rule extended details.")
  @visibility(Lifecycle.Read)
  extendedDetails?: InboundNatRuleExtendedDetails;

  @doc("When was assessed inbound NAT rule first created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("When was assessed inbound NAT rule last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

@doc("Inbound NAT rule extended details.")
model InboundNatRuleExtendedDetails {
  @doc("The transport protocol used by the inbound NAT rule.")
  @visibility(Lifecycle.Read)
  protocol?: LbTransportProtocol;

  @doc("The target type of the inbound NAT rule indicating whether it targets a specific VM or a backend address pool.")
  @visibility(Lifecycle.Read)
  targetType?: InboundNatRuleTargetType;

  @doc("The frontend IP configuration associated with this rule.")
  @visibility(Lifecycle.Read)
  frontendIpConfiguration?: LbRuleFrontendIpConfig;

  @doc("The port for the external endpoint. Port numbers for each rule must be unique within the Load Balancer.")
  @visibility(Lifecycle.Read)
  frontendPort?: int32;

  @doc("The port range start for the external endpoint. Applicable when target type is BackendPool.")
  @visibility(Lifecycle.Read)
  frontendPortRangeStart?: int32;

  @doc("The port range end for the external endpoint. Applicable when target type is BackendPool.")
  @visibility(Lifecycle.Read)
  frontendPortRangeEnd?: int32;

  @doc("The port used for the internal endpoint.")
  @visibility(Lifecycle.Read)
  backendPort?: int32;

  @doc("The name of the target virtual machine. Applicable when target type is AzureVm.")
  @visibility(Lifecycle.Read)
  targetVirtualMachine?: string;

  @doc("The backend address pool associated with this rule. Applicable when target type is BackendPool.")
  @visibility(Lifecycle.Read)
  backendPool?: string;

  @doc("The timeout for the TCP idle connection in minutes. The value can be set between 4 and 30 minutes.")
  @visibility(Lifecycle.Read)
  idleTimeoutInMinutes?: int32;

  @doc("Configures a virtual machine's endpoint for the floating IP capability required to configure a SQL AlwaysOn Availability Group.")
  @visibility(Lifecycle.Read)
  enableFloatingIp?: boolean;

  @doc("Receive bidirectional TCP Reset on TCP flow idle timeout or unexpected connection termination.")
  @visibility(Lifecycle.Read)
  enableTcpReset?: boolean;
}
