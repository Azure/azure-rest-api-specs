import "@typespec/openapi";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Traffic control permission.")
enum TrafficControlPermission {
  @doc("Traffic matching this rule is allowed to flow.")
  Enabled,

  @doc("Traffic matching this rule is not allowed to flow.")
  Blocked,
}

@doc("Service data flow direction.")
enum SdfDirection {
  @doc("Traffic flowing from the UE to the data network.")
  Uplink,

  @doc("Traffic flowing from the data network to the UE.")
  Downlink,

  @doc("Traffic flowing both to and from the UE.")
  Bidirectional,
}

@doc("Service properties.")
model ServicePropertiesFormat {
  @doc("The provisioning state of the service resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("A precedence value that is used to decide between services when identifying the QoS values to use for a particular SIM. A lower value means a higher priority. This value should be unique among all services configured in the mobile network.")
  @minValue(0)
  @maxValue(255)
  servicePrecedence: int32;

  @doc("The QoS policy to use for packets matching this service. This can be overridden for particular flows using the ruleQosPolicy field in a PccRuleConfiguration. If this field is null then the UE's SIM policy will define the QoS settings.")
  serviceQosPolicy?: QosPolicy;

  @doc("The set of data flow policy rules that make up this service.")
  @minItems(1)
  @extension("x-ms-identifiers", ["ruleName"])
  pccRules: PccRuleConfiguration[];
}

@doc("QoS policy")
model QosPolicy {
  @doc("5G QoS Flow Indicator value. The 5QI identifies a specific QoS forwarding treatment to be provided to a flow. See 3GPP TS23.501 section 5.7.2.1 for a full description of the 5QI parameter, and table 5.7.4-1 for the definition the 5QI values.")
  @encodedName("application/json", "5qi")
  fiveQi?: FiveQiPriorityLevel = 9;

  @doc("QoS Flow allocation and retention priority (ARP) level. Flows with higher priority preempt flows with lower priority, if the settings of `preemptionCapability` and `preemptionVulnerability` allow it. 1 is the highest level of priority. If this field is not specified then `5qi` is used to derive the ARP value. See 3GPP TS23.501 section 5.7.2.2 for a full description of the ARP parameters.")
  allocationAndRetentionPriorityLevel?: ArpPriorityLevel = 9;

  @doc("QoS Flow preemption capability. The preemption capability of a QoS Flow controls whether it can preempt another QoS Flow with a lower priority level. See 3GPP TS23.501 section 5.7.2.2 for a full description of the ARP parameters.")
  preemptionCapability?: PreemptionCapability = PreemptionCapability.NotPreempt;

  @doc("QoS Flow preemption vulnerability. The preemption vulnerability of a QoS Flow controls whether it can be preempted by a QoS Flow with a higher priority level. See 3GPP TS23.501 section 5.7.2.2 for a full description of the ARP parameters.")
  preemptionVulnerability?: PreemptionVulnerability = PreemptionVulnerability.Preemptable;

  @doc("The maximum bit rate (MBR) for all service data flows that use this data flow policy rule or service.")
  maximumBitRate: Ambr;
}

@doc("Data flow policy rule configuration")
model PccRuleConfiguration {
  @doc("The name of the rule. This must be unique within the parent service. You must not use any of the following reserved strings - `default`, `requested` or `service`.")
  @maxLength(64)
  @pattern("^(?!(default|requested|service)$)[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  ruleName: string;

  @doc("A precedence value that is used to decide between data flow policy rules when identifying the QoS values to use for a particular SIM. A lower value means a higher priority. This value should be unique among all data flow policy rules configured in the mobile network.")
  @minValue(0)
  @maxValue(255)
  rulePrecedence: int32;

  @doc("The QoS policy to use for packets matching this rule. If this field is null then the parent service will define the QoS settings.")
  ruleQosPolicy?: PccRuleQosPolicy;

  @doc("Determines whether flows that match this data flow policy rule are permitted.")
  trafficControl?: TrafficControlPermission;

  @doc("The set of data flow templates to use for this data flow policy rule.")
  @minItems(1)
  @maxItems(15)
  @extension("x-ms-identifiers", ["templateName"])
  serviceDataFlowTemplates: ServiceDataFlowTemplate[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@doc("Data flow policy rule QoS policy")
model PccRuleQosPolicy extends QosPolicy {
  @doc("The guaranteed bit rate (GBR) for all service data flows that use this data flow policy rule. This is an optional setting. If you do not provide a value, there will be no GBR set for the data flow policy rule that uses this QoS definition.")
  guaranteedBitRate?: Ambr;
}

@doc("Data flow template")
model ServiceDataFlowTemplate {
  @doc("The name of the data flow template. This must be unique within the parent data flow policy rule. You must not use any of the following reserved strings - `default`, `requested` or `service`.")
  @maxLength(64)
  @pattern("^(?!(default|requested|service)$)[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  templateName: string;

  @doc("The direction of this flow.")
  direction: SdfDirection;

  @doc("A list of the allowed protocol(s) for this flow. If you want this flow to be able to use any protocol within the internet protocol suite, use the value `ip`. If you only want to allow a selection of protocols, you must use the corresponding IANA Assigned Internet Protocol Number for each protocol, as described in https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml. For example, for UDP, you must use 17. If you use the value `ip` then you must leave the field `port` unspecified.")
  @minItems(1)
  protocol: Protocol[];

  @doc("The remote IP address(es) to which UEs will connect for this flow. If you want to allow connections on any IP address, use the value `any`. Otherwise, you must provide each of the remote IP addresses to which the packet core instance will connect for this flow. You must provide each IP address in CIDR notation, including the netmask (for example, 192.0.2.54/24).")
  @minItems(1)
  remoteIpList: RemoteIp[];

  @doc("The port(s) to which UEs will connect for this flow. You can specify zero or more ports or port ranges. If you specify one or more ports or port ranges then you must specify a value other than `ip` in the `protocol` field. This is an optional setting. If you do not specify it then connections will be allowed on all ports. Port ranges must be specified as <FirstPort>-<LastPort>. For example: [`8080`, `8082-8085`].")
  ports?: Port[];
}
