import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Scom;

interface Operations extends Azure.ResourceManager.Operations {}

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

@doc("The properties of a SCOM instance resource")
model MonitoringInstanceProperties {
  @doc("SCOM product version to be installed on instance")
  @visibility("read")
  productVersion?: string;

  @doc("Virtual Network subnet id on which Aquila instance will be provisioned")
  vNetSubnetId?: string;

  @doc("List of management server endpoints")
  @visibility("read")
  managementEndpoints?: ManagementServerProperties[];

  @doc("The database instance where the SCOM Operational and Warehouse databases will be stored.")
  databaseInstance?: DatabaseInstanceProperties;

  @doc("Domain controller details")
  domainController?: DomainControllerProperties;

  @doc("Domain user which will be used to join VMs to domain and login to VMs.")
  domainUserCredentials?: DomainUserCredentials;

  @doc("Gmsa Details for load balancer and vmss")
  gmsaDetails?: GmsaDetails;

  @doc("The properties to enable Azure Hybrid benefit for various SCOM infrastructure license.")
  azureHybridBenefit?: AzureHybridBenefitProperties;

  @doc("Gets or sets the provisioning state.")
  @visibility("read")
  provisioningState?: string;

  @doc("Details of Log Analytics workspace and data being ingested.")
  @visibility("read")
  logAnalyticsProperties?: LogAnalyticsConfiguration;

  @doc("Gets status of current and latest SCOM managed instance operations.")
  @visibility("read")
  operationsStatus?: ManagedInstanceOperationStatus[];
}

@doc("The properties of management server")
model ManagementServerProperties {
  @doc("Management server Name")
  @visibility("read")
  serverName?: string;

  @doc("Azure VM Resource Id of the Management server.")
  @visibility("read")
  vmResId?: string;

  @doc("Management server Fully Qualified Domain Name.")
  @visibility("read")
  fqdn?: string;

  @doc("Represent whether the Server is a Management Server and/or Web Console Server.")
  @visibility("read")
  serverRoles?: string;

  @doc("Management server health state.")
  @visibility("read")
  healthState?: string;
}

@doc("The properties of database instance")
model DatabaseInstanceProperties {
  @doc("Resource Id of existing database instance")
  databaseInstanceId?: string;

  @doc("Fully qualified domain name of existing database instance")
  @visibility("read")
  databaseFqdn?: string;

  @doc("Name of warehouse database on database instance")
  @visibility("read")
  dwDatabaseName?: string;

  @doc("Resource Id of operational database on database instance")
  @visibility("read")
  operationalDatabaseId?: string;

  @doc("Resource Id of warehouse database on database instance")
  @visibility("read")
  dwDatabaseId?: string;
}

@doc("The properties of domain controller to which SCOM and SQL servers join for AuthN/AuthZ.")
model DomainControllerProperties {
  @doc("Fully qualified domain name")
  domainName?: string;

  @doc("IP address of DNS server ")
  dnsServer?: string;

  @doc("Organizational Unit path in which the SCOM servers will be present")
  ouPath?: string;
}

@doc("Get Domain user name and password from key vault")
model DomainUserCredentials {
  @doc("Key vault url to get the domain username and password")
  keyVaultUrl?: string;

  @doc("Domain user name secret ")
  userNameSecret?: string;

  @doc("Domain Password secret ")
  passwordSecret?: string;
}

@doc("Gmsa Details")
model GmsaDetails {
  @doc("Frontend IP configuration for Load Balancer, which should be an available IP in customer VNet")
  loadBalancerIP?: string;

  @doc("gMSA account under which context all Management Server services will run")
  gmsaAccount?: string;

  @doc("OnPrem AD Computer Group where we will join VMs for ease of management")
  managementServerGroupName?: string;

  @doc("Frontend DNS name for Load Balancer which will be used by Agents to initiate communication")
  dnsName?: string;
}

@doc("The properties to maximize savings by using Azure Hybrid Benefit")
model AzureHybridBenefitProperties {
  @doc("SCOM license type. Maximize savings by using license you already own")
  scomLicenseType?: HybridLicenseType;

  @doc("Specifies that the image or disk that is being used was licensed on-premises. <br><br> For more information, see [Azure Hybrid Use Benefit for Windows Server](https://docs.microsoft.com/azure/virtual-machines/virtual-machines-windows-hybrid-use-benefit-licensing?toc=%2fazure%2fvirtual-machines%2fwindows%2ftoc.json)")
  windowsServerLicenseType?: HybridLicenseType;

  @doc("SQL Server license type. Maximize savings by using Azure Hybrid Benefit for SQL Server with license you already own")
  sqlServerLicenseType?: HybridLicenseType;
}

@doc("Configuration for Log Analytics linking to SCOM managed instance.")
model LogAnalyticsConfiguration {
  @doc("The resource ID of the Log Analytics workspace to be used.")
  workspaceId?: string;

  @doc("The types of data to be ingested to Log Analytics workspace.")
  dataTypes?: DataType[];

  @doc("A one-time optional parameter to import data of last 7 days.")
  importData?: boolean;
}

@doc("Gets status of current and latest SCOM managed instance operation.")
model ManagedInstanceOperationStatus {
  @doc("Operation Name")
  @visibility("read")
  operationName?: string;

  @doc("Operation status")
  @visibility("read")
  operationState?: string;

  @doc("Operation id")
  @visibility("read")
  id?: string;
}

@doc("Azure Active Directory identity configuration for a resource.")
model ManagedIdentity {
  @doc("The identity type")
  type?: ManagedIdentityType;

  @doc("System Assigned Identity ObjectId.")
  @visibility("read")
  principalId?: string;

  @doc("The Azure Active Directory tenant id.")
  @visibility("read")
  tenantId?: string;

  @doc("The resource ids of the user assigned identities to use")
  userAssignedIdentities?: Record<UserIdentity>;
}

@doc("Azure Active Directory identity configuration for a resource.")
model UserIdentity {
  @doc("The Azure Active Directory principal id.")
  @visibility("read")
  principalId?: string;

  @doc("The Azure Active Directory client id.")
  @visibility("read")
  clientId?: string;
}

@doc("Properties for Scaling")
model ScalingProperties {
  @doc("Required management server count")
  serverCount?: int32;
}

@doc("Properties for set server count operation")
model SetServerCountResponseProperties {
  @doc("Management server count")
  serverCount?: int32;
}

@doc("Properties for patching servers")
model PatchServersResponseProperties {
  @doc("Status of the patch operation")
  status?: string;
}

@doc("Properties for unlinking log analytics")
model UnlinkLogAnalyticsResponseProperties {
  @doc("Status of the unlink operation")
  status?: string;
}

@doc("Updated configuration for Log Analytics linking")
model LogAnalyticsUpdateConfiguration {
  @doc("The types of data to be ingested to Log Analytics workspace.")
  dataTypes?: DataType[];
}

@doc("The properties of a monitored resource.")
model MonitoredResourceProperties {
  @doc("ArmId of the monitored resource.")
  resourceId?: string;

  @doc("Location of the monitored resource.")
  resourceLocation?: string;

  @doc("ComputerName of the monitored resource.")
  computerName?: string;

  @doc("The domain name associated with the monitored resource.")
  domainName?: string;

  @doc("The management server endpoint to which the monitored resource is directed.")
  @visibility("read")
  managementServerEndpoint?: string;

  @doc("The health status of the monitored resource.")
  @visibility("read")
  healthStatus?: string;

  @doc("The connection status of the monitored resource.")
  @visibility("read")
  connectionStatus?: string;

  @doc("The version of the monitored resource agent version.")
  @visibility("read")
  agentVersion?: string;

  @doc("Install type of monitored resource.")
  @visibility("read")
  installType?: string;

  @visibility("read")
  provisioningState?: string;
}

@doc("The properties of a gateway resource.")
model ManagedGatewayProperties {
  @doc("ArmId of the gateway to be monitored.")
  resourceId?: string;

  @doc("Location of the gateway to be monitored.")
  resourceLocation?: string;

  @doc("ComputerName of the gateway to be monitored.")
  computerName?: string;

  @doc("The domain name associated with the gateway to be monitored.")
  domainName?: string;

  @doc("The management server endpoint to which the gateway is directed.")
  @visibility("read")
  managementServerEndpoint?: string;

  @doc("The health status of the gateway resource.")
  @visibility("read")
  healthStatus?: string;

  @doc("The connection status of the gateway resource.")
  @visibility("read")
  connectionStatus?: string;

  @doc("The version of the gateway resource.")
  @visibility("read")
  version?: string;

  @doc("Install type of gateway resource.")
  @visibility("read")
  installType?: string;

  @visibility("read")
  provisioningState?: string;
}
