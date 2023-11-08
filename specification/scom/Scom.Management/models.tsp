import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Scom;

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum HybridLicenseType {
  None,
  AzureHybridBenefit,
}

enum DataType {
  State,
  Performance,
  Event,
  Audit,
}

enum ManagedIdentityType {
  None,
  UserAssigned,
  SystemAssigned,
  `SystemAssigned,UserAssigned`,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

/** The properties of a SCOM instance resource */
model MonitoringInstanceProperties {
  /** SCOM product version to be installed on instance */
  @visibility("read")
  productVersion?: string;

  /** Virtual Network subnet id on which Aquila instance will be provisioned */
  vNetSubnetId?: string;

  /** List of management server endpoints */
  @visibility("read")
  managementEndpoints?: ManagementServerProperties[];

  /** The database instance where the SCOM Operational and Warehouse databases will be stored. */
  databaseInstance?: DatabaseInstanceProperties;

  /** Domain controller details */
  domainController?: DomainControllerProperties;

  /** Domain user which will be used to join VMs to domain and login to VMs. */
  domainUserCredentials?: DomainUserCredentials;

  /** Gmsa Details for load balancer and vmss */
  gmsaDetails?: GmsaDetails;

  /** The properties to enable Azure Hybrid benefit for various SCOM infrastructure license. */
  azureHybridBenefit?: AzureHybridBenefitProperties;

  /** Gets or sets the provisioning state. */
  @visibility("read")
  provisioningState?: string;

  /** Details of Log Analytics workspace and data being ingested. */
  @visibility("read")
  logAnalyticsProperties?: LogAnalyticsConfiguration;

  /** Gets status of current and latest SCOM managed instance operations. */
  @visibility("read")
  operationsStatus?: ManagedInstanceOperationStatus[];
}

/** The properties of management server */
model ManagementServerProperties {
  /** Management server Name */
  @visibility("read")
  serverName?: string;

  /** Azure VM Resource Id of the Management server. */
  @visibility("read")
  vmResId?: string;

  /** Management server Fully Qualified Domain Name. */
  @visibility("read")
  fqdn?: string;

  /** Represent whether the Server is a Management Server and/or Web Console Server. */
  @visibility("read")
  serverRoles?: string;

  /** Management server health state. */
  @visibility("read")
  healthState?: string;
}

/** The properties of database instance */
model DatabaseInstanceProperties {
  /** Resource Id of existing database instance */
  databaseInstanceId?: string;

  /** Fully qualified domain name of existing database instance */
  @visibility("read")
  databaseFqdn?: string;

  /** Name of warehouse database on database instance */
  @visibility("read")
  dwDatabaseName?: string;

  /** Resource Id of operational database on database instance */
  @visibility("read")
  operationalDatabaseId?: string;

  /** Resource Id of warehouse database on database instance */
  @visibility("read")
  dwDatabaseId?: string;
}

/** The properties of domain controller to which SCOM and SQL servers join for AuthN/AuthZ. */
model DomainControllerProperties {
  /** Fully qualified domain name */
  domainName?: string;

  /** IP address of DNS server  */
  dnsServer?: string;

  /** Organizational Unit path in which the SCOM servers will be present */
  ouPath?: string;
}

/** Get Domain user name and password from key vault */
model DomainUserCredentials {
  /** Key vault url to get the domain username and password */
  keyVaultUrl?: string;

  /** Domain user name secret  */
  userNameSecret?: string;

  /** Domain Password secret  */
  passwordSecret?: string;
}

/** Gmsa Details */
model GmsaDetails {
  /** Frontend IP configuration for Load Balancer, which should be an available IP in customer VNet */
  loadBalancerIP?: string;

  /** gMSA account under which context all Management Server services will run */
  gmsaAccount?: string;

  /** OnPrem AD Computer Group where we will join VMs for ease of management */
  managementServerGroupName?: string;

  /** Frontend DNS name for Load Balancer which will be used by Agents to initiate communication */
  dnsName?: string;
}

/** The properties to maximize savings by using Azure Hybrid Benefit */
model AzureHybridBenefitProperties {
  /** SCOM license type. Maximize savings by using license you already own */
  scomLicenseType?: HybridLicenseType;

  /** Specifies that the image or disk that is being used was licensed on-premises. <br><br> For more information, see [Azure Hybrid Use Benefit for Windows Server](https://docs.microsoft.com/azure/virtual-machines/virtual-machines-windows-hybrid-use-benefit-licensing?toc=%2fazure%2fvirtual-machines%2fwindows%2ftoc.json) */
  windowsServerLicenseType?: HybridLicenseType;

  /** SQL Server license type. Maximize savings by using Azure Hybrid Benefit for SQL Server with license you already own */
  sqlServerLicenseType?: HybridLicenseType;
}

/** Configuration for Log Analytics linking to SCOM managed instance. */
model LogAnalyticsConfiguration {
  /** The resource ID of the Log Analytics workspace to be used. */
  workspaceId?: string;

  /** The types of data to be ingested to Log Analytics workspace. */
  dataTypes?: DataType[];

  /** A one-time optional parameter to import data of last 7 days. */
  importData?: boolean;
}

/** Gets status of current and latest SCOM managed instance operation. */
model ManagedInstanceOperationStatus {
  /** Operation Name */
  @visibility("read")
  operationName?: string;

  /** Operation status */
  @visibility("read")
  operationState?: string;

  /** Operation id */
  @visibility("read")
  id?: string;
}

/** Azure Active Directory identity configuration for a resource. */
model ManagedIdentity {
  /** The identity type */
  type?: ManagedIdentityType;

  /** System Assigned Identity ObjectId. */
  @visibility("read")
  principalId?: string;

  /** The Azure Active Directory tenant id. */
  @visibility("read")
  tenantId?: string;

  /** The resource ids of the user assigned identities to use */
  userAssignedIdentities?: Record<UserIdentity>;
}

/** Azure Active Directory identity configuration for a resource. */
model UserIdentity {
  /** The Azure Active Directory principal id. */
  @visibility("read")
  principalId?: string;

  /** The Azure Active Directory client id. */
  @visibility("read")
  clientId?: string;
}

/** Properties for Scaling */
model ScalingProperties {
  /** Required management server count */
  serverCount?: int32;
}

/** Properties for set server count operation */
model SetServerCountResponseProperties {
  /** Management server count */
  serverCount?: int32;
}

/** Properties for patching servers */
model PatchServersResponseProperties {
  /** Status of the patch operation */
  status?: string;
}

/** Properties for unlinking log analytics */
model UnlinkLogAnalyticsResponseProperties {
  /** Status of the unlink operation */
  status?: string;
}

/** Updated configuration for Log Analytics linking */
model LogAnalyticsUpdateConfiguration {
  /** The types of data to be ingested to Log Analytics workspace. */
  dataTypes?: DataType[];
}

/** The properties of a monitored resource. */
model MonitoredResourceProperties {
  /** ArmId of the monitored resource. */
  resourceId?: string;

  /** Location of the monitored resource. */
  resourceLocation?: string;

  /** ComputerName of the monitored resource. */
  computerName?: string;

  /** The domain name associated with the monitored resource. */
  domainName?: string;

  /** The management server endpoint to which the monitored resource is directed. */
  @visibility("read")
  managementServerEndpoint?: string;

  /** The health status of the monitored resource. */
  @visibility("read")
  healthStatus?: string;

  /** The connection status of the monitored resource. */
  @visibility("read")
  connectionStatus?: string;

  /** The version of the monitored resource agent version. */
  @visibility("read")
  agentVersion?: string;

  /** Install type of monitored resource. */
  @visibility("read")
  installType?: string;

  @visibility("read")
  provisioningState?: string;
}

/** The properties of a gateway resource. */
model ManagedGatewayProperties {
  /** ArmId of the gateway to be monitored. */
  resourceId?: string;

  /** Location of the gateway to be monitored. */
  resourceLocation?: string;

  /** ComputerName of the gateway to be monitored. */
  computerName?: string;

  /** The domain name associated with the gateway to be monitored. */
  domainName?: string;

  /** The management server endpoint to which the gateway is directed. */
  @visibility("read")
  managementServerEndpoint?: string;

  /** The health status of the gateway resource. */
  @visibility("read")
  healthStatus?: string;

  /** The connection status of the gateway resource. */
  @visibility("read")
  connectionStatus?: string;

  /** The version of the gateway resource. */
  @visibility("read")
  version?: string;

  /** Install type of gateway resource. */
  @visibility("read")
  installType?: string;

  @visibility("read")
  provisioningState?: string;
}
