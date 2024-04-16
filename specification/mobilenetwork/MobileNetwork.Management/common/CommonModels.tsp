import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";

import "./Enums.tsp";
import "./Operations.tsp";
import "./ResourceIdentifiers.tsp";

using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

// Models

@doc("Reference to another sub resource.")
@extension("x-ms-azure-resource", true)
model SubResource {
  @doc("Resource ID.")
  id: string;
}

@doc("The current status of an async operation.")
model AsyncOperationStatus {
  @doc("Fully qualified ID for the async operation.")
  id?: string;

  @doc("Name of the async operation.")
  name?: string;

  @doc("The operation status.")
  status: string;

  @doc("Fully qualified ID for the resource that this async operation status relates to.")
  resourceId?: string;

  @doc("The start time of the operation.")
  startTime?: utcDateTime;

  @doc("The end time of the operation.")
  endTime?: utcDateTime;

  @doc("Percentage of the operation that is complete.")
  @minValue(0)
  @maxValue(100)
  percentComplete?: float64;

  @doc("Properties returned by the resource provider on a successful operation")
  properties?: {};

  @doc("If present, details of the operation error.")
  error?: ErrorDetail;
}

@doc("Interface properties")
model InterfaceProperties {
  @doc("The logical name for this interface. This should match one of the interfaces configured on your Azure Stack Edge device.")
  name?: string;

  @doc("The IPv4 address.")
  ipv4Address?: Ipv4Addr;

  @doc("The IPv4 subnet.")
  ipv4Subnet?: Ipv4AddrMask;

  @doc("The default IPv4 gateway (router).")
  ipv4Gateway?: Ipv4Addr;

  @doc("VLAN identifier of the network interface. Example: 501.")
  @maxValue(4094)
  @minValue(1)
  vlanId?: int32;

  @doc("The Nexus Trunked Network that is used for the network interface.")
  nexusTrunkedNetwork?: NexusTrunkedNetworkResourceId;
}

@doc("Pool of addresses which can be used by User Equipment")
model UserEquipmentAddressPool {
  @doc("Reference to an Edge Subnet within an Edge Virtual Network")
  subnet?: EdgeSubnetReference;

  @doc("IPv4 address prefix.")
  ipv4Prefix?: Ipv4AddrMask;

  @doc("The type of User Equipment Address Pool.")
  type: UserEquipmentAddressPoolType;
}

@doc("Reference to an Edge Subnet within an Edge Virtual Network")
model EdgeSubnetReference {
  @doc("The Edge Virtual Network containing the Edge Subnet")
  edgeVirtualNetwork: EdgeVirtualNetworkResourceId;

  @doc("The name of the Edge Subnet")
  edgeSubnetName: string;
}

@doc("Tags object for patch operations.")
model TagsObject {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Identity and Tags object for patch operations.")
model IdentityAndTagsObject {
  @doc("The managed service identity associated with this resource.")
  identity?: ManagedServiceIdentity;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Managed service identity (User assigned identity).")
model ManagedServiceIdentity {
  @doc("Type of managed service identity (currently only UserAssigned allowed).")
  type: ManagedServiceIdentityType;

  @doc("The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.")
  userAssignedIdentities?: UserAssignedIdentities;
}

@doc("The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.")
@extension("x-nullable", true)
model UserAssignedIdentities {
  ...Record<UserAssignedIdentity>;
}

@doc("User assigned identity properties.")
model UserAssignedIdentity {
  @doc("The principal ID of the assigned identity.")
  @visibility("read")
  principalId?: uuid;

  @doc("The client ID of the assigned identity.")
  @visibility("read")
  clientId?: uuid;
}

@doc("The provisioning state of a resource e.g. SIM/SIM policy on a site. The dictionary keys will ARM resource IDs in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MobileNetwork/mobileNetworks/{mobileNetworkName}/sites/{siteName}. The dictionary values will be from the \"SiteProvisioningState\" enum.")
model SiteProvisioning {
  ...Record<SiteProvisioningState>;
}

@doc("Edge Network Interface properties")
model EdgeNetworkInterface {
  @doc("The interface on the core side to which traffic on this Virtual Network is sent.")
  deviceInterface?: VirtualNetworkResourceId;

  @doc("Core side interface properties")
  interfaceProperties?: InterfaceProperties;

  @doc("Edge Network Security Group applying to traffic on this interface.")
  edgeNetworkSecurityGroup?: EdgeNetworkSecurityGroupResourceId;
}

@doc("Public land mobile network (PLMN) ID. This is made up of the mobile country code and mobile network code, as defined in https://www.itu.int/rec/T-REC-E.212. The values 001-01 and 001-001 can be used for testing and the values 999-99 and 999-999 can be used on internal private networks.")
model PlmnId {
  @doc("Mobile country code (MCC).")
  mcc: Mcc;

  @doc("Mobile network code (MNC).")
  mnc: Mnc;
}

@doc("A group of User Equipment endpoints to which security policy can be applied.")
model EndpointSecurityGroup {
  @doc("The name of the endpoint security group.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  name?: string;
}

@doc("Aggregate maximum bit rate.")
model Ambr {
  @doc("Uplink bit rate.")
  uplink: BitRate;

  @doc("Downlink bit rate.")
  downlink: BitRate;
}

@doc("Single-network slice selection assistance information (S-NSSAI).")
model Snssai {
  @doc("Slice/service type (SST).")
  @minValue(0)
  @maxValue(255)
  sst: int32;

  @doc("Slice differentiator (SD).")
  @pattern("^[A-Fa-f0-9]{6}$")
  sd?: string;
}

@doc("UE IP address")
model UeIpAddress {
  @doc("IPv4 address.")
  ipV4Addr?: Ipv4Addr;
}

@doc("Managed-On-Behalf-Of configuration properties. This configuration exists for the resources where a resource provider manages those resources on behalf of the resource owner.")
model ManagedOnBehalfOfConfiguration {
  @doc("Managed-On-Behalf-Of broker resources")
  @extension("x-ms-identifiers", ["id"])
  moboBrokerResources?: MoboBrokerResource[];
}

@doc("Managed-On-Behalf-Of broker resource. This resource is created by the Resource Provider to manage some resources on behalf of the user.")
model MoboBrokerResource {
  @doc("Resource identifier of a Managed-On-Behalf-Of broker resource")
  id?: armResourceIdentifier;
}

@doc("Reference to an virtual network resource, to be used as an interface for an Edge Virtual Network.")
@extension("x-ms-azure-resource", true)
model VirtualNetworkResourceId {
  @doc("Virtual network resource ID.")
  id: string;
}

@doc("Operational Status of the resource")
model OperationalStatus {
  @doc("Status of the deployed workload")
  @visibility("read")
  workload?: string;

  @doc("Health check results")
  @visibility("read")
  healthCheck?: string;
}

@doc("Containerized Network Function (CNF) Qualified Deployment Parameters")
model QualifiedComponentDeploymentParameters {
  @doc("Component Type")
  type: ComponentDeploymentType;

  @doc("Deployment Parameters")
  parameters?: ComponentDeploymentParameters;

  @doc("Deployment secrets")
  @secret
  @visibility("create", "update")
  secrets?: ComponentDeploymentSecrets;
}

@doc("ManagedResourceGroupConfiguration represents the configuration of the resource group managed by Azure.")
model ManagedResourceGroupConfiguration {
  @doc("The name for the managed resource group. If not specified, the unique name is automatically generated.")
  @visibility("create", "read")
  @maxLength(75)
  name?: string;

  @doc("The location of the managed resource group. If not specified, the location of the parent resource is chosen.")
  @visibility("create", "read")
  location?: string;
}

// Scalar

@doc("5G QoS Identifier.")
@minValue(0)
@maxValue(255)
@encodedName("application/json", "5Qi")
scalar FiveQi extends int32;

@doc("5G QoS Identifier priority level.")
@minValue(1)
@maxValue(127)
@encodedName("application/json", "5QiPriorityLevel")
scalar FiveQiPriorityLevel extends int32;

@doc("ARP priority level.")
@minValue(1)
@maxValue(15)
scalar ArpPriorityLevel extends int32;

@doc("Bit rate.")
@pattern("^\\d+(\\.\\d+)? (bps|Kbps|Mbps|Gbps|Tbps)$")
scalar BitRate extends string;

@doc("Data network name.")
scalar Dnn extends string;

@doc("Mobile country code.")
@pattern("^\\d{3}$")
scalar Mcc extends string;

@doc("Mobile network code.")
@pattern("^\\d{2,3}$")
scalar Mnc extends string;

@doc("RAT/Frequency Selection Priority Index.")
@minValue(1)
@maxValue(256)
@encodedName("application/json", "5QiPriorityLevel")
scalar RfspIndex extends int32;

@doc("The name of the SIM.")
@maxLength(64)
@pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
scalar SimName extends string;

@doc("IPv4 address.")
@pattern("^(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$")
scalar Ipv4Addr extends string;

@doc("IPv4 address prefix.")
@pattern("^(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\\/([0-9]|[1-2][0-9]|3[0-2]))$")
scalar Ipv4AddrMask extends string;

@doc("IP protocol.")
@pattern("^(ip|[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$")
scalar Protocol extends string;

@doc("Port number.")
@pattern("^([1-9]|[1-9][0-9]{1,3}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])(-([1-9]|[1-9][0-9]{1,3}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5]))?$")
scalar Port extends string;

@doc("Remote IP address.")
@pattern("^(any|(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\\/([0-9]|[1-2][0-9]|3[0-2])))$")
scalar RemoteIp extends string;

@doc("Usage SKU Definition")
scalar UsageSku extends string;

@doc("Mobile Core Scaling Unit SKU Definition")
scalar MobileCoreScalingUnitSku extends string;

@doc("Azure for Operators 5G Core Release Version.")
scalar ReleaseVersion extends string;

@doc("Containerized Network Function (CNF) Component Deployment Parameters")
scalar ComponentDeploymentParameters extends string;

@doc("Containerized Network Function (CNF) Component Secrets")
scalar ComponentDeploymentSecrets extends string;

@doc("Containerized Network Function (CNF) Component Deployment Type")
scalar ComponentDeploymentType extends string;
