import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Common;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
namespace SecuritySolutionsAPI;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ConnectionType {
  string,

  /**
   * Internal
   */
  Internal: "Internal",

  /**
   * External
   */
  External: "External",
}

/**
 * The security family of the discovered solution
 */
union SecurityFamily {
  string,

  /**
   * Waf
   */
  Waf: "Waf",

  /**
   * Ngfw
   */
  Ngfw: "Ngfw",

  /**
   * SaasWaf
   */
  SaasWaf: "SaasWaf",

  /**
   * Va
   */
  Va: "Va",
}

/**
 * The kind of the external solution
 */
union ExternalSecuritySolutionKind {
  string,

  /**
   * CEF
   */
  CEF: "CEF",

  /**
   * ATA
   */
  ATA: "ATA",

  /**
   * AAD
   */
  AAD: "AAD",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union Protocol {
  string,

  /**
   * TCP
   */
  TCP: "TCP",

  /**
   * UDP
   */
  UDP: "UDP",

  /**
   * *
   */
  All: "*",
}

/**
 * The status of the port
 */
union Status {
  string,

  /**
   * Revoked
   */
  Revoked: "Revoked",

  /**
   * Initiated
   */
  Initiated: "Initiated",
}

/**
 * A description of why the `status` has its value
 */
union StatusReason {
  string,

  /**
   * Expired
   */
  Expired: "Expired",

  /**
   * UserRequested
   */
  UserRequested: "UserRequested",

  /**
   * NewerRequestInitiated
   */
  NewerRequestInitiated: "NewerRequestInitiated",
}

/**
 * The provisioningState of the vulnerability assessment capability on the VM
 */
union ServerVulnerabilityAssessmentPropertiesProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Deprovisioning
   */
  Deprovisioning: "Deprovisioning",
}

/**
 * The connectivity state of the external AAD solution
 */
union AadConnectivityState {
  string,

  /**
   * Discovered
   */
  Discovered: "Discovered",

  /**
   * NotLicensed
   */
  NotLicensed: "NotLicensed",

  /**
   * Connected
   */
  Connected: "Connected",
}

/**
 * List of all possible traffic between Azure resources
 */
model AllowedConnectionsList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  @visibility(Lifecycle.Read)
  value?: AllowedConnectionsResource[];

  /**
   * The URI to fetch the next page.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Describes the allowed traffic between Azure resources
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AllowedConnectionsResourceProperties {
  /**
   * The UTC time on which the allowed connections resource was calculated
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  calculatedDateTime?: utcDateTime;

  /**
   * List of connectable resources
   */
  @visibility(Lifecycle.Read)
  connectableResources?: ConnectableResource[];
}

/**
 * Describes the allowed inbound and outbound traffic of an Azure resource
 */
model ConnectableResource {
  /**
   * The Azure resource id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The list of Azure resources that the resource has inbound allowed connection from
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  inboundConnectedResources?: ConnectedResource[];

  /**
   * The list of Azure resources that the resource has outbound allowed connection to
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  outboundConnectedResources?: ConnectedResource[];
}

/**
 * Describes properties of a connected resource
 */
model ConnectedResource {
  /**
   * The Azure resource id of the connected resource
   */
  @visibility(Lifecycle.Read)
  connectedResourceId?: string;

  /**
   * The allowed tcp ports
   */
  @visibility(Lifecycle.Read)
  tcpPorts?: string;

  /**
   * The allowed udp ports
   */
  @visibility(Lifecycle.Read)
  udpPorts?: string;
}

/**
 * Describes an Azure resource with location
 */
model Location {
  /**
   * Location where the resource is stored
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DiscoveredSecuritySolutionList {
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  value?: DiscoveredSecuritySolution[];

  /**
   * The URI to fetch the next page.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DiscoveredSecuritySolutionProperties {
  /**
   * The security family of the discovered solution
   */
  securityFamily: SecurityFamily;

  /**
   * The security solutions' image offer
   */
  offer: string;

  /**
   * The security solutions' image publisher
   */
  publisher: string;

  /**
   * The security solutions' image sku
   */
  sku: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ExternalSecuritySolutionList {
  @pageItems
  value?: ExternalSecuritySolution[];

  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JitNetworkAccessPoliciesList {
  @pageItems
  value?: JitNetworkAccessPolicy[];

  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JitNetworkAccessPolicyProperties {
  /**
   * Configurations for Microsoft.Compute/virtualMachines resource type.
   */
  virtualMachines: JitNetworkAccessPolicyVirtualMachine[];

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  requests?: JitNetworkAccessRequest[];

  /**
   * Gets the provisioning state of the Just-in-Time policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JitNetworkAccessPolicyVirtualMachine {
  /**
   * Resource ID of the virtual machine that is linked to this policy
   */
  id: string;

  /**
   * Port configurations for the virtual machine
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ports: JitNetworkAccessPortRule[];

  /**
   * Public IP address of the Azure Firewall that is linked to this policy, if applicable
   */
  publicIpAddress?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JitNetworkAccessPortRule {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @minValue(0)
  @maxValue(65535)
  number: int32;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protocol: Protocol;

  /**
   * Mutually exclusive with the "allowedSourceAddressPrefixes" parameter. Should be an IP address or CIDR, for example "192.168.0.3" or "192.168.0.0/16".
   */
  allowedSourceAddressPrefix?: string;

  /**
   * Mutually exclusive with the "allowedSourceAddressPrefix" parameter.
   */
  allowedSourceAddressPrefixes?: string[];

  /**
   * Maximum duration requests can be made for. In ISO 8601 duration format. Minimum 5 minutes, maximum 1 day
   */
  maxRequestAccessDuration: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JitNetworkAccessRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  virtualMachines: JitNetworkAccessRequestVirtualMachine[];

  /**
   * The start time of the request in UTC
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc: utcDateTime;

  /**
   * The identity of the person who made the request
   */
  requestor: string;

  /**
   * The justification for making the initiate request
   */
  justification?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JitNetworkAccessRequestVirtualMachine {
  /**
   * Resource ID of the virtual machine that is linked to this policy
   */
  id: string;

  /**
   * The ports that were opened for the virtual machine
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ports: JitNetworkAccessRequestPort[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JitNetworkAccessRequestPort {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @minValue(0)
  @maxValue(65535)
  number: int32;

  /**
   * Mutually exclusive with the "allowedSourceAddressPrefixes" parameter. Should be an IP address or CIDR, for example "192.168.0.3" or "192.168.0.0/16".
   */
  allowedSourceAddressPrefix?: string;

  /**
   * Mutually exclusive with the "allowedSourceAddressPrefix" parameter.
   */
  allowedSourceAddressPrefixes?: string[];

  /**
   * The date & time at which the request ends in UTC
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc: utcDateTime;

  /**
   * The status of the port
   */
  status: Status;

  /**
   * A description of why the `status` has its value
   */
  statusReason: StatusReason;

  /**
   * The port which is mapped to this port's `number` in the Azure Firewall, if applicable
   */
  mappedPort?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JitNetworkAccessPolicyInitiateRequest {
  /**
   * A list of virtual machines & ports to open access for
   */
  virtualMachines: JitNetworkAccessPolicyInitiateVirtualMachine[];

  /**
   * The justification for making the initiate request
   */
  justification?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JitNetworkAccessPolicyInitiateVirtualMachine {
  /**
   * Resource ID of the virtual machine that is linked to this policy
   */
  id: string;

  /**
   * The ports to open for the resource with the `id`
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ports: JitNetworkAccessPolicyInitiatePort[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JitNetworkAccessPolicyInitiatePort {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @minValue(0)
  @maxValue(65535)
  number: int32;

  /**
   * Source of the allowed traffic. If omitted, the request will be for the source IP address of the initiate request.
   */
  allowedSourceAddressPrefix?: string;

  /**
   * The time to close the request in UTC
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecuritySolutionList {
  @pageItems
  value?: SecuritySolution[];

  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SecuritySolutionProperties {
  /**
   * The security family of the security solution
   */
  securityFamily: SecurityFamily;

  /**
   * The security family provisioning State
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState: ProvisioningState;

  /**
   * The security solutions' template
   */
  template: string;

  /**
   * The security solutions' status
   */
  protectionStatus: string;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model securitySolutionsReferenceDataList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: securitySolutionsReferenceData[];
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model securitySolutionsReferenceData {
  ...Azure.ResourceManager.Foundations.Resource;
  ...Location;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties: securitySolutionsReferenceDataProperties;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model securitySolutionsReferenceDataProperties {
  /**
   * The security family of the security solution
   */
  securityFamily: SecurityFamily;

  /**
   * The security solutions' vendor name
   */
  alertVendorName: string;

  /**
   * The security solutions' package info url
   */
  packageInfoUrl: string;

  /**
   * The security solutions' product name
   */
  productName: string;

  /**
   * The security solutions' publisher
   */
  publisher: string;

  /**
   * The security solutions' publisher display name
   */
  publisherDisplayName: string;

  /**
   * The security solutions' template
   */
  template: string;
}

/**
 * List of server vulnerability assessments
 */
model ServerVulnerabilityAssessmentsList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  value?: ServerVulnerabilityAssessment[];
}

/**
 * describes ServerVulnerabilityAssessment properties.
 */
model ServerVulnerabilityAssessmentProperties {
  /**
   * The provisioningState of the vulnerability assessment capability on the VM
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ServerVulnerabilityAssessmentPropertiesProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TopologyList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  @visibility(Lifecycle.Read)
  value?: TopologyResource[];

  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TopologyResourceProperties {
  /**
   * The UTC time on which the topology was calculated
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  calculatedDateTime?: utcDateTime;

  /**
   * Azure resources which are part of this topology resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  topologyResources?: TopologySingleResource[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TopologySingleResource {
  /**
   * Azure resource id
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;

  /**
   * The security severity of the resource
   */
  @visibility(Lifecycle.Read)
  severity?: string;

  /**
   * Indicates if the resource has security recommendations
   */
  @visibility(Lifecycle.Read)
  recommendationsExist?: boolean;

  /**
   * Indicates the resource connectivity level to the Internet (InternetFacing, Internal ,etc.)
   */
  @visibility(Lifecycle.Read)
  networkZones?: string;

  /**
   * Score of the resource based on its security severity
   */
  @visibility(Lifecycle.Read)
  topologyScore?: int32;

  /**
   * The location of this resource
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Azure resources connected to this resource which are in higher level in the topology view
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  parents?: TopologySingleResourceParent[];

  /**
   * Azure resources connected to this resource which are in lower level in the topology view
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  children?: TopologySingleResourceChild[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TopologySingleResourceParent {
  /**
   * Azure resource id which serves as parent resource in topology view
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TopologySingleResourceChild {
  /**
   * Azure resource id which serves as child resource in topology view
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;
}

/**
 * Represents a security solution which sends CEF logs to an OMS workspace
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CefExternalSecuritySolution extends ExternalSecuritySolution {
  /**
   * The external security solution properties for CEF solutions
   */
  properties?: CefSolutionProperties;

  kind: ExternalSecuritySolutionKind.CEF;
}

/**
 * The external security solution properties for CEF solutions
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CefSolutionProperties extends ExternalSecuritySolutionProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  hostname?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  agent?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  lastEventReceived?: string;
}

/**
 * The solution properties (correspond to the solution kind)
 */
model ExternalSecuritySolutionProperties {
  ...Record<unknown>;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deviceVendor?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deviceType?: string;

  /**
   * Represents an OMS workspace to which the solution is connected
   */
  workspace?: ConnectedWorkspace;
}

/**
 * Represents an OMS workspace to which the solution is connected
 */
model ConnectedWorkspace {
  /**
   * Azure resource ID of the connected OMS workspace
   */
  id?: string;
}

/**
 * Represents an ATA security solution which sends logs to an OMS workspace
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AtaExternalSecuritySolution extends ExternalSecuritySolution {
  /**
   * The external security solution properties for ATA solutions
   */
  properties?: AtaSolutionProperties;

  kind: ExternalSecuritySolutionKind.ATA;
}

/**
 * The external security solution properties for ATA solutions
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AtaSolutionProperties extends ExternalSecuritySolutionProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  lastEventReceived?: string;
}

/**
 * Represents an AAD identity protection solution which sends logs to an OMS workspace.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AadExternalSecuritySolution extends ExternalSecuritySolution {
  /**
   * The external security solution properties for AAD solutions
   */
  properties?: AadSolutionProperties;

  kind: ExternalSecuritySolutionKind.AAD;
}

/**
 * The external security solution properties for AAD solutions
 */
model AadSolutionProperties {
  ...ExternalSecuritySolutionProperties;

  /**
   * The connectivity state of the external AAD solution
   */
  connectivityState?: AadConnectivityState;
}


