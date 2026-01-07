import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./rack.tsp";

using Rest;
using Azure.ResourceManager;

namespace Microsoft.SupercomputerInfrastructure;

/** A switch in the network. */
@parentResource(Supercomputer)
model Switch is ProxyResource<SwitchProperties> {
  ...ResourceNameParameter<Switch>;
}

/** The properties of a switch. */
model SwitchProperties {
  /** The status of the last operation on this switch */
  @visibility(Lifecycle.Read)
  provisioningState?: TopologicalProvisioningState;

  /** The SKU of the switch hardware. */
  @visibility(Lifecycle.Read)
  hardwareSku?: string;

  /** The network type of the switch. */
  @visibility(Lifecycle.Read)
  networkType?: SwitchNetworkType;

  /** The Azure resource ID of the cluster that the switch is associated with, if any. */
  @visibility(Lifecycle.Read)
  clusterId?: ClusterResourceId;

  /** The Azure resource ID of the rack that the switch is associated with, if any. */
  @visibility(Lifecycle.Read)
  rackId?: RackResourceId;
}

/** The type of the network the switch resides in. */
union SwitchNetworkType {
  /** The switch is within a scale-up backend network. */
  BackendScaleUp: "BackendScaleUp",

  /** The switch is within a scale-out backend network. */
  BackendScaleOut: "BackendScaleOut",

  /** The switch is within a frontend network. */
  Frontend: "Frontend",

  string,
}

/** The request body for a packet capture action over a switch. */
model SwitchPacketCaptureRequest {
  /** The location to store captured packets, such as a Storage Account Blob URI. */
  destinationLocation: string;

  /** The duration of the packet capture in seconds. */
  durationInSeconds: int32;

  /** The interfaces over which to capture packets. */
  interfaces: string[];

  /** The match rules to apply to the packet capture. */
  @identifiers(#[])
  matchRules: SwitchPacketCaptureMatchRule[];

  /** The traffic direction to capture. */
  trafficDirection: SwitchPacketCaptureTrafficDirection;
}

/** A match rule to filter packets upon capture. */
model SwitchPacketCaptureMatchRule {
  /** The allowed destination prefix of the packets to capture. */
  destinationIpPrefix?: string;

  /** The allowed destination port of the packets to capture. */
  destinationPort?: int32;

  /** The differentiated services code point (DSCP) of the packets to match. */
  dscp?: int32;

  /** The header protocol of the packets to capture. */
  protocol?: SwitchPacketCaptureMatchRuleProtocol;

  /** The allowed source prefix of the packets to capture. */
  sourceIpPrefix?: string;

  /** The allowed source port of the packets to capture. */
  sourcePort?: int32;

  /** The TCP flags of the packets to capture. */
  tcpFlags?: int32;
}

/** The available header protocols for packet captures. */
union SwitchPacketCaptureMatchRuleProtocol {
  /** Match over IPv4 headers. */
  Ipv4: "Ipv4",

  /** Match over IPv6 headers. */
  Ipv6: "Ipv6",

  /** Match over TCP headers. */
  Tcp: "Tcp",

  /** Match over UDP headers. */
  Udp: "Udp",

  /** Match over ICMP headers. */
  Icmp: "Icmp",

  string,
}

/** The traffic directions to filter over when performing packet capture. */
union SwitchPacketCaptureTrafficDirection {
  /** Match all traffic. */
  All: "All",

  /** Match only egress traffic from the switch. */
  Egress: "Egress",

  /** Match only ingress traffic to the switch. */
  Ingress: "Ingress",

  string,
}

/** The result of a packet capture action over a switch. */
model SwitchPacketCaptureResult {
  /** The fault code, if the operation failed. */
  faultCode?: string;

  /** The fault message, if the operation failed. */
  faultMessage?: string;

  /** The status of the packet capture action. */
  status: SwitchPacketCaptureResultStatus;
}

/** The status of a packet capture action over a switch. */
union SwitchPacketCaptureResultStatus {
  /** The packet capture request has been accepted. */
  Accepted: "Accepted",

  /** The packet capture is still in progress. */
  Running: "Running",

  /** The packet capture completed successfully. */
  Succeeded: "Succeeded",

  /** The packet capture failed. */
  Failed: "Failed",

  string,
}

/** The request body a retrieve data action over a switch. */
model SwitchRetrieveDataRequest {
  /** The gNMI paths of the read operation. */
  paths: string[];
}

/** The result of a retrieve data action over a switch. */
model SwitchRetrieveDataResult {
  /** The value of the retrieve data action. */
  @identifiers(#["path", "value"])
  value: SwitchRetrieveDataOutput[];
}

/** The output of a retrieve data action over a switch. */
model SwitchRetrieveDataOutput {
  /** The fault code, if the operation failed. */
  faultCode?: string;

  /** The fault message, if the operation failed. */
  faultMessage?: string;

  /** The gNMI path of the read operation. */
  path: string;

  /** The value of the read operation. */
  value: string;
}

@armResourceOperations
interface Switches {
  get is ArmResourceRead<Switch>;
  listBySupercomputer is ArmResourceListByParent<Switch>;
  packetCapture is ArmResourceActionAsync<
    Switch,
    SwitchPacketCaptureRequest,
    SwitchPacketCaptureResult
  >;
  retrieveData is ArmResourceActionAsync<
    Switch,
    SwitchRetrieveDataRequest,
    SwitchRetrieveDataResult
  >;
}
