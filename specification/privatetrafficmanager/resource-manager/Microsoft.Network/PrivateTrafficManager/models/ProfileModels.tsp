import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./EndpointModels.tsp";
import "./TopologyMapModels.tsp";

using Azure.ResourceManager;

namespace Microsoft.Network;

scalar TopologyMapId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/topologyMaps",
    }
  ]>;

@doc("The status of the Traffic Manager profile.")
union ProfileStatus {
  string,

  @doc("The profile is enabled and traffic routing is active.")
  Enabled: "Enabled",

  @doc("The profile is disabled and traffic routing is inactive.")
  Disabled: "Disabled",
}

@doc("The traffic routing method of the Traffic Manager profile.")
union TrafficRoutingMethod {
  string,

  @doc("Routes traffic to endpoints based on priority values, directing to the highest priority available endpoint.")
  Priority: "Priority",

  @doc("Distributes traffic across endpoints based on assigned weight values.")
  Weighted: "Weighted",
}

@doc("The record type of the Traffic Manager profile.")
union RecordType {
  string,

  @doc("IPv4 address record type for DNS resolution.")
  A: "A",

  @doc("IPv6 address record type for DNS resolution.")
  AAAA: "AAAA",

  @doc("Canonical name record type that maps an alias to a domain name.")
  CNAME: "CNAME",
}

@doc("DNS configuration of the Traffic Manager profile.")
model DnsConfig {
  @doc("The record type of the Traffic Manager profile.")
  recordType?: RecordType;

  @doc("The TTL of the DNS records in seconds.")
  ttl?: int64;
}

@doc("The experience level of the Private Traffic Manager profile.")
union CustomTopologyMap {
  string,

  @doc("Basic experience")
  Disable: "Disable",

  @doc("Advanced experience")
  Enable: "Enable",
}

@doc("Class representing the Traffic Manager profile properties.")
model ProfileProperties {
  @doc("The experience level of the Private Traffic Manager profile.")
  customTopologyMap?: CustomTopologyMap;

  @doc("The DNS related configuration properties of the Private Traffic Manager")
  dnsConfig?: DnsConfig;

  @doc("The ARM resource ID of the topology map which has site(s) associated with this probing gateway.")
  topologyMapId?: TopologyMapId;

  @doc("The status of the Private Traffic Manager profile.")
  profileStatus?: ProfileStatus;

  @doc("The traffic routing method of the Private Traffic Manager profile.")
  trafficRoutingMethod?: TrafficRoutingMethod;

  @doc("The list of endpoints in the Private Traffic Manager profile.")
  @identifiers(#["name"])
  endpoints?: ProfileEndpoint[];

  @visibility(Lifecycle.Read)
  @doc("Provisioning state of the resource.")
  provisioningState?: provisioningStateProperties;
}
