import "@typespec/openapi";
import "@typespec/versioning";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

@doc("PDU session type (IPv4/IPv6).")
union PduSessionType {
  @doc("PDU session type IPv4.")
  IPv4: "IPv4",

  @doc("PDU session type IPv6.")
  IPv6: "IPv6",

  string,
}

@doc("SIM policy properties. Must be created in the same location as its parent mobile network.")
model SimPolicyPropertiesFormat {
  @doc("The provisioning state of the SIM policy resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("A dictionary of sites to the provisioning state of this SIM policy on that site.")
  @visibility("read")
  siteProvisioningState?: SiteProvisioning;

  @doc("Aggregate maximum bit rate across all non-GBR QoS flows of all PDU sessions of a given UE. See 3GPP TS23.501 section 5.7.2.6 for a full description of the UE-AMBR.")
  ueAmbr: Ambr;

  @doc("The default slice to use if the UE does not explicitly specify it. This slice must exist in the `sliceConfigurations` map. The slice must be in the same location as the SIM policy.")
  defaultSlice: SliceResourceId;

  @doc("RAT/Frequency Selection Priority Index, defined in 3GPP TS 36.413. This is an optional setting and by default is unspecified.")
  rfspIndex?: RfspIndex;

  @doc("UE periodic registration update timer (5G) or UE periodic tracking area update timer (4G), in seconds.")
  @minValue(30)
  registrationTimer?: int32 = 3240;

  @doc("The allowed slices and the settings to use for them. The list must not contain duplicate items and must contain at least one item.")
  @minItems(1)
  @extension("x-ms-identifiers", ["slice"])
  sliceConfigurations: SliceConfiguration[];

  @removed(Versions.v2024_06_01)
  @doc("The name of the endpoint security group to use for this SIM policy.")
  endpointSecurityGroup?: EndpointSecurityGroup;
}

@doc("Per-slice settings")
model SliceConfiguration {
  @doc("A reference to the slice that these settings apply to. The slice must be in the same location as the SIM policy.")
  slice: SliceResourceId;

  @doc("The default data network to use if the UE does not explicitly specify it. Configuration for this object must exist in the `dataNetworkConfigurations` map. The data network must be in the same location as the SIM policy.")
  defaultDataNetwork: DataNetworkResourceId;

  @doc("The allowed data networks and the settings to use for them. The list must not contain duplicate items and must contain at least one item.")
  @minItems(1)
  @extension("x-ms-identifiers", ["dataNetwork"])
  dataNetworkConfigurations: DataNetworkConfiguration[];
}

@doc("Settings controlling data network use")
model DataNetworkConfiguration {
  @doc("A reference to the data network that these settings apply to. The data network must be in the same location as the SIM policy.")
  dataNetwork: DataNetworkResourceId;

  @doc("Aggregate maximum bit rate across all non-GBR QoS flows of a given PDU session. See 3GPP TS23.501 section 5.7.2.6 for a full description of the Session-AMBR.")
  sessionAmbr: Ambr;

  @doc("Default 5G QoS Flow Indicator value. The 5QI identifies a specific QoS forwarding treatment to be provided to a flow. See 3GPP TS23.501 section 5.7.2.1 for a full description of the 5QI parameter, and table 5.7.4-1 for the definition the 5QI values.")
  @encodedName("application/json", "5qi")
  fiveQi?: FiveQi = 9;

  @doc("Default QoS Flow allocation and retention priority (ARP) level. Flows with higher priority preempt flows with lower priority, if the settings of `preemptionCapability` and `preemptionVulnerability` allow it. 1 is the highest level of priority. If this field is not specified then `5qi` is used to derive the ARP value. See 3GPP TS23.501 section 5.7.2.2 for a full description of the ARP parameters.")
  allocationAndRetentionPriorityLevel?: ArpPriorityLevel = 9;

  @doc("Default QoS Flow preemption capability. The preemption capability of a QoS Flow controls whether it can preempt another QoS Flow with a lower priority level. See 3GPP TS23.501 section 5.7.2.2 for a full description of the ARP parameters.")
  preemptionCapability?: PreemptionCapability = PreemptionCapability.NotPreempt;

  @doc("Default QoS Flow preemption vulnerability. The preemption vulnerability of a QoS Flow controls whether it can be preempted by a QoS Flow with a higher priority level. See 3GPP TS23.501 section 5.7.2.2 for a full description of the ARP parameters.")
  preemptionVulnerability?: PreemptionVulnerability = PreemptionVulnerability.Preemptable;

  @doc("The default PDU session type, which is used if the UE does not request a specific session type.")
  defaultSessionType?: PduSessionType = PduSessionType.IPv4;

  @doc("Allowed session types in addition to the default session type. Must not duplicate the default session type.")
  @maxItems(1)
  additionalAllowedSessionTypes?: PduSessionType[];

  @doc("List of services that can be used as part of this SIM policy. The list must not contain duplicate items and must contain at least one item. The services must be in the same location as the SIM policy.")
  @minItems(1)
  allowedServices: ServiceResourceId[];

  @doc("The maximum number of downlink packets to buffer at the user plane for High Latency Communication - Extended Buffering. See 3GPP TS29.272 v15.10.0 section 7.3.188 for a full description. This maximum is not guaranteed because there is a internal limit on buffered packets across all PDU sessions.")
  @minValue(0)
  maximumNumberOfBufferedPackets?: int32 = 10;
}
