import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Databricks;

/**
 * The workspace compute mode. Required on create, cannot be changed. Possible values include: 'Serverless', 'Hybrid'
 */
union ComputeMode {
  string,

  /**
   * Serverless
   */
  Serverless: "Serverless",

  /**
   * Hybrid
   */
  Hybrid: "Hybrid",
}

/**
 * The workspace's custom parameters.
 */
union CustomParameterType {
  string,

  /**
   * Bool
   */
  Bool: "Bool",

  /**
   * Object
   */
  Object: "Object",

  /**
   * String
   */
  String: "String",
}

/**
 * The encryption keySource (provider). Possible values (case-insensitive):  Default, Microsoft.Keyvault
 */
union KeySource {
  string,

  /**
   * Default
   */
  Default: "Default",

  /**
   * Microsoft.Keyvault
   */
  `Microsoft.Keyvault`: "Microsoft.Keyvault",
}

/**
 * Provisioning status of the workspace.
 */
union ProvisioningState {
  string,

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Ready
   */
  Ready: "Ready",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Created
   */
  Created: "Created",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Updating
   */
  Updating: "Updating",
}

/**
 * The encryption keySource (provider). Possible values (case-insensitive):  Microsoft.Keyvault
 */
union EncryptionKeySource {
  string,

  /**
   * Microsoft.Keyvault
   */
  `Microsoft.Keyvault`: "Microsoft.Keyvault",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union AutomaticClusterUpdateValue {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ComplianceSecurityProfileValue {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union EnhancedSecurityMonitoringValue {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * The status of a private endpoint connection
 */
union PrivateLinkServiceConnectionStatus {
  string,

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * Rejected
   */
  Rejected: "Rejected",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union PrivateEndpointConnectionProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The network access type for accessing workspace. Set value to disabled to access workspace only via private link. Used to configure front-end only private link for Serverless ComputeMode workspace.
 */
union PublicNetworkAccess {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Gets or sets a value indicating whether data plane (clusters) to control plane communication happen over private endpoint. Supported values are 'AllRules' and 'NoAzureDatabricksRules'. 'NoAzureServiceRules' value is for internal use only. Not allowed in Serverless ComputeMode workspace.
 */
union RequiredNsgRules {
  string,

  /**
   * AllRules
   */
  AllRules: "AllRules",

  /**
   * NoAzureDatabricksRules
   */
  NoAzureDatabricksRules: "NoAzureDatabricksRules",

  /**
   * NoAzureServiceRules
   */
  NoAzureServiceRules: "NoAzureServiceRules",
}

/**
 * Defines the initial type of the default catalog. Possible values (case-insensitive):  HiveMetastore, UnityCatalog
 */
union InitialType {
  string,

  /**
   * HiveMetastore
   */
  HiveMetastore: "HiveMetastore",

  /**
   * UnityCatalog
   */
  UnityCatalog: "UnityCatalog",
}

/**
 * The identity type of the Access Connector Resource.
 */
union IdentityType {
  string,

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",
}

/**
 * Gets or Sets Default Storage Firewall configuration information. Not allowed in Serverless ComputeMode workspace.
 */
union DefaultStorageFirewall {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * The status of the virtual network peering.
 */
union PeeringState {
  string,

  /**
   * Initiated
   */
  Initiated: "Initiated",

  /**
   * Connected
   */
  Connected: "Connected",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union PeeringProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The workspace properties.
 */
model WorkspaceProperties {
  /**
   * The workspace compute mode. Required on create, cannot be changed. Possible values include: 'Serverless', 'Hybrid'
   */
  computeMode: ComputeMode;

  /**
   * The managed resource group Id. Required in Hybrid ComputeMode workspace. Not allowed in Serverless ComputeMode workspace.
   */
  managedResourceGroupId?: string;

  /**
   * The workspace's custom parameters.
   */
  parameters?: WorkspaceCustomParameters;

  /**
   * The workspace provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The blob URI where the UI definition file is located.
   */
  uiDefinitionUri?: string;

  /**
   * The workspace provider authorizations.
   */
  @identifiers(#[])
  authorizations?: WorkspaceProviderAuthorization[];

  /**
   * Indicates the Object ID, PUID and Application ID of entity that created the workspace.
   */
  createdBy?: CreatedBy;

  /**
   * Indicates the Object ID, PUID and Application ID of entity that last updated the workspace.
   */
  updatedBy?: CreatedBy;

  /**
   * Specifies the date and time when the workspace is created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;

  /**
   * The unique identifier of the databricks workspace in databricks control plane.
   */
  @visibility(Lifecycle.Read)
  workspaceId?: string;

  /**
   * The workspace URL which is of the format 'adb-{workspaceId}.{random}.azuredatabricks.net'
   */
  @visibility(Lifecycle.Read)
  workspaceUrl?: string;

  /**
   * The details of Managed Identity of Storage Account. Only returned in Hybrid ComputeMode workspace.
   */
  storageAccountIdentity?: ManagedIdentityConfiguration;

  /**
   * The details of Managed Identity of Disk Encryption Set used for Managed Disk Encryption. Only returned in Hybrid ComputeMode workspace.
   */
  managedDiskIdentity?: ManagedIdentityConfiguration;

  /**
   * The resource Id of the managed disk encryption set. Not allowed in Serverless ComputeMode workspace.
   */
  @visibility(Lifecycle.Read)
  diskEncryptionSetId?: string;

  /**
   * Encryption properties for databricks workspace. Supported in both Serverless and Hybrid ComputeMode workspace.
   */
  encryption?: WorkspacePropertiesEncryption;

  /**
   * Contains settings related to the Enhanced Security and Compliance Add-On. Supported in both Serverless and Hybrid ComputeMode workspace.
   */
  enhancedSecurityCompliance?: EnhancedSecurityComplianceDefinition;

  /**
   * Private endpoint connections created on the workspace. Supported in both Serverless and Hybrid ComputeMode workspace.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * The network access type for accessing workspace. Set value to disabled to access workspace only via private link. Used to configure front-end only private link for Serverless ComputeMode workspace.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Gets or sets a value indicating whether data plane (clusters) to control plane communication happen over private endpoint. Supported values are 'AllRules' and 'NoAzureDatabricksRules'. 'NoAzureServiceRules' value is for internal use only. Not allowed in Serverless ComputeMode workspace.
   */
  requiredNsgRules?: RequiredNsgRules;

  /**
   * Properties for Default Catalog configuration during workspace creation. Not allowed in Serverless ComputeMode workspace.
   */
  defaultCatalog?: DefaultCatalogProperties;

  /**
   * Indicates whether unity catalog enabled for the workspace or not. Set as true in Serverless ComputeMode workspace.
   */
  @visibility(Lifecycle.Read)
  isUcEnabled?: boolean;

  /**
   * Access Connector Resource that is going to be associated with Databricks Workspace. Not allowed in Serverless ComputeMode workspace.
   */
  accessConnector?: WorkspacePropertiesAccessConnector;

  /**
   * Gets or Sets Default Storage Firewall configuration information. Not allowed in Serverless ComputeMode workspace.
   */
  defaultStorageFirewall?: DefaultStorageFirewall;
}

/**
 * Custom Parameters used for Workspace Creation. Not allowed in Serverless ComputeMode workspace.
 */
model WorkspaceCustomParameters {
  /**
   * The ID of a Azure Machine Learning workspace to link with Databricks workspace. Not allowed in Serverless ComputeMode workspace.
   */
  amlWorkspaceId?: WorkspaceCustomStringParameter;

  /**
   * The ID of a Virtual Network where this Databricks Cluster should be created. Not allowed in Serverless ComputeMode workspace.
   */
  customVirtualNetworkId?: WorkspaceCustomStringParameter;

  /**
   * The name of a Public Subnet within the Virtual Network. Not allowed in Serverless ComputeMode workspace.
   */
  customPublicSubnetName?: WorkspaceCustomStringParameter;

  /**
   * The name of the Private Subnet within the Virtual Network. Not allowed in Serverless ComputeMode workspace.
   */
  customPrivateSubnetName?: WorkspaceCustomStringParameter;

  /**
   * Boolean indicating whether the public IP should be disabled. Default value is true. Not allowed in Serverless ComputeMode workspace.
   */
  enableNoPublicIp?: WorkspaceNoPublicIPBooleanParameter;

  /**
   * Name of the outbound Load Balancer Backend Pool for Secure Cluster Connectivity (No Public IP). Not allowed in Serverless ComputeMode workspace.
   */
  loadBalancerBackendPoolName?: WorkspaceCustomStringParameter;

  /**
   * Resource URI of Outbound Load balancer for Secure Cluster Connectivity (No Public IP) workspace. Not allowed in Serverless ComputeMode workspace.
   */
  loadBalancerId?: WorkspaceCustomStringParameter;

  /**
   * Name of the NAT gateway for Secure Cluster Connectivity (No Public IP) workspace subnets. Not allowed in Serverless ComputeMode workspace.
   */
  natGatewayName?: WorkspaceCustomStringParameter;

  /**
   * Name of the Public IP for No Public IP workspace with managed vNet. Not allowed in Serverless ComputeMode workspace.
   */
  publicIpName?: WorkspaceCustomStringParameter;

  /**
   * Prepare the workspace for encryption. Enables the Managed Identity for managed storage account. Not allowed in Serverless ComputeMode workspace.
   */
  prepareEncryption?: WorkspaceCustomBooleanParameter;

  /**
   * Contains the encryption details for Customer-Managed Key (CMK) enabled workspace.Not allowed in Serverless ComputeMode workspace.
   */
  encryption?: WorkspaceEncryptionParameter;

  /**
   * A boolean indicating whether or not the DBFS root file system will be enabled with secondary layer of encryption with platform managed keys for data at rest. Not allowed in Serverless ComputeMode workspace.
   */
  requireInfrastructureEncryption?: WorkspaceCustomBooleanParameter;

  /**
   * Default DBFS storage account name. Not allowed in Serverless ComputeMode workspace.
   */
  storageAccountName?: WorkspaceCustomStringParameter;

  /**
   * Storage account SKU name, ex: Standard_GRS, Standard_LRS. Refer https://aka.ms/storageskus for valid inputs. Not allowed in Serverless ComputeMode workspace.
   */
  storageAccountSkuName?: WorkspaceCustomStringParameter;

  /**
   * Address prefix for Managed virtual network. Default value for this input is 10.139. Not allowed in Serverless ComputeMode workspace.
   */
  vnetAddressPrefix?: WorkspaceCustomStringParameter;

  /**
   * Tags applied to resources under Managed resource group. These can be updated by updating tags at workspace level. Not allowed in Serverless ComputeMode workspace.
   */
  @visibility(Lifecycle.Read)
  resourceTags?: WorkspaceCustomObjectParameter;
}

/**
 * The Value.
 */
model WorkspaceCustomStringParameter {
  /**
   * The type of variable that this is
   */
  type?: CustomParameterType;

  /**
   * The value which should be used for this field.
   */
  value: string;
}

/**
 * The value which should be used for this field.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing model from original swagger"
model WorkspaceNoPublicIPBooleanParameter {
  /**
   * The type of variable that this is
   */
  type?: CustomParameterType;

  /**
   * The value which should be used for this field.
   */
  value: boolean;
}

/**
 * The value which should be used for this field.
 */
model WorkspaceCustomBooleanParameter {
  /**
   * The type of variable that this is
   */
  type?: CustomParameterType;

  /**
   * The value which should be used for this field.
   */
  value: boolean;
}

/**
 * The object that contains details of encryption used on the workspace.
 */
model WorkspaceEncryptionParameter {
  /**
   * The type of variable that this is
   */
  type?: CustomParameterType;

  /**
   * The value which should be used for this field.
   */
  value?: Encryption;
}

/**
 * The object that contains details of encryption used on the workspace.
 */
model Encryption {
  /**
   * The encryption keySource (provider). Possible values (case-insensitive):  Default, Microsoft.Keyvault
   */
  keySource?: KeySource = KeySource.Default;

  /**
   * The name of KeyVault key.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
  KeyName?: string;

  /**
   * The version of KeyVault key.
   */
  keyversion?: string;

  /**
   * The Uri of KeyVault.
   */
  keyvaulturi?: string;
}

/**
 * The value which should be used for this field.
 */
model WorkspaceCustomObjectParameter {
  /**
   * The type of variable that this is
   */
  type?: CustomParameterType;

  /**
   * The value which should be used for this field.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Existing property from original swagger"
  value: unknown;
}

/**
 * The workspace provider authorization.
 */
model WorkspaceProviderAuthorization {
  /**
   * The provider's principal identifier. This is the identity that the provider will use to call ARM to manage the workspace resources.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  principalId: string;

  /**
   * The provider's role definition identifier. This role will define all the permissions that the provider must have on the workspace's container resource group. This role definition cannot have permission to delete the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  roleDefinitionId: string;
}

/**
 * Provides details of the entity that created/updated the workspace.
 */
model CreatedBy {
  /**
   * The Object ID that created the workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  oid?: string;

  /**
   * The Personal Object ID corresponding to the object ID above
   */
  @visibility(Lifecycle.Read)
  puid?: string;

  /**
   * The application ID of the application that initiated the creation of the workspace. For example, Azure Portal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  applicationId?: string;
}

/**
 * The Managed Identity details for storage account.
 */
model ManagedIdentityConfiguration {
  /**
   * The objectId of the Managed Identity that is linked to the Managed Storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;

  /**
   * The tenant Id where the Managed Identity is created.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  tenantId?: string;

  /**
   * The type of Identity created. It can be either SystemAssigned or UserAssigned.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Encryption properties for databricks workspace. Supported in both Serverless and Hybrid ComputeMode workspace.
 */
model WorkspacePropertiesEncryption {
  /**
   * Encryption entities definition for the workspace.
   */
  entities: EncryptionEntitiesDefinition;
}

/**
 * Encryption entities for databricks workspace resource.
 */
model EncryptionEntitiesDefinition {
  /**
   * Encryption properties for the databricks managed services. Supported in both Serverless and Hybrid ComputeMode.
   */
  managedServices?: EncryptionV2;

  /**
   * Encryption properties for the databricks managed disks. Not allowed in Serverless ComputeMode workspace.
   */
  managedDisk?: ManagedDiskEncryption;
}

/**
 * The object that contains details of encryption used on the workspace.
 */
model EncryptionV2 {
  /**
   * The encryption keySource (provider). Possible values (case-insensitive):  Microsoft.Keyvault
   */
  keySource: EncryptionKeySource;

  /**
   * Key Vault input properties for encryption.
   */
  keyVaultProperties?: EncryptionV2KeyVaultProperties;
}

/**
 * Key Vault input properties for encryption.
 */
model EncryptionV2KeyVaultProperties {
  /**
   * The Uri of KeyVault.
   */
  keyVaultUri: string;

  /**
   * The name of KeyVault key.
   */
  keyName: string;

  /**
   * The version of KeyVault key.
   */
  keyVersion: string;
}

/**
 * The object that contains details of encryption used on the workspace.
 */
model ManagedDiskEncryption {
  /**
   * The encryption keySource (provider). Possible values (case-insensitive):  Microsoft.Keyvault. Not allowed in Serverless ComputeMode workspace.
   */
  keySource: EncryptionKeySource;

  /**
   * Key Vault input properties for encryption.
   */
  keyVaultProperties: ManagedDiskEncryptionKeyVaultProperties;

  /**
   * Indicate whether the latest key version should be automatically used for Managed Disk Encryption.
   */
  rotationToLatestKeyVersionEnabled?: boolean;
}

/**
 * Key Vault input properties for encryption.
 */
model ManagedDiskEncryptionKeyVaultProperties {
  /**
   * The URI of KeyVault.
   */
  keyVaultUri: string;

  /**
   * The name of KeyVault key.
   */
  keyName: string;

  /**
   * The version of KeyVault key.
   */
  keyVersion: string;
}

/**
 * Status of settings related to the Enhanced Security and Compliance Add-On.
 */
model EnhancedSecurityComplianceDefinition {
  /**
   * Status of automated cluster updates feature.
   */
  automaticClusterUpdate?: AutomaticClusterUpdateDefinition;

  /**
   * Status of Compliance Security Profile feature.
   */
  complianceSecurityProfile?: ComplianceSecurityProfileDefinition;

  /**
   * Status of Enhanced Security Monitoring feature.
   */
  enhancedSecurityMonitoring?: EnhancedSecurityMonitoringDefinition;
}

/**
 * Status of automated cluster updates feature.
 */
model AutomaticClusterUpdateDefinition {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  value?: AutomaticClusterUpdateValue;
}

/**
 * Status of Compliance Security Profile feature.
 */
model ComplianceSecurityProfileDefinition {
  /**
   * Compliance standards associated with the workspace.
   */
  complianceStandards?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  value?: ComplianceSecurityProfileValue;
}

/**
 * Status of Enhanced Security Monitoring feature.
 */
model EnhancedSecurityMonitoringDefinition {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  value?: EnhancedSecurityMonitoringValue;
}

/**
 * The properties of a private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * Private endpoint
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * GroupIds from the private link service resource.
   */
  groupIds?: string[];

  /**
   * Private endpoint connection state
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * Provisioning state of the private endpoint connection.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The private endpoint property of a private endpoint connection.
 */
model PrivateEndpoint {
  /**
   * The resource identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * The current state of a private endpoint connection.
 */
model PrivateLinkServiceConnectionState {
  /**
   * The status of a private endpoint connection
   */
  status: PrivateLinkServiceConnectionStatus;

  /**
   * The description for the current state of a private endpoint connection
   */
  description?: string;

  /**
   * Actions required for a private endpoint connection
   */
  actionsRequired?: string;
}

/**
 * These properties lets user specify default catalog properties during workspace creation. Not allowed in Serverless ComputeMode workspace.
 */
model DefaultCatalogProperties {
  /**
   * Defines the initial type of the default catalog. Possible values (case-insensitive):  HiveMetastore, UnityCatalog
   */
  initialType?: InitialType = InitialType.HiveMetastore;

  /**
   * Specifies the initial Name of default catalog. If not specified, the name of the workspace will be used.
   */
  initialName?: string;
}

/**
 * Access Connector Resource that is going to be associated with Databricks Workspace. Not allowed in Serverless ComputeMode workspace.
 */
model WorkspacePropertiesAccessConnector {
  /**
   * The resource ID of Azure Databricks Access Connector Resource.
   */
  id: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Databricks/accessConnectors";
    }
  ]>;

  /**
   * The identity type of the Access Connector Resource.
   */
  identityType: IdentityType;

  /**
   * The resource ID of the User Assigned Identity associated with the Access Connector Resource. This is required for type 'UserAssigned' and not valid for type 'SystemAssigned'.
   */
  userAssignedIdentityId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

/**
 * SKU for the resource.
 */
model Sku {
  /**
   * The SKU name.
   */
  name: string;

  /**
   * The SKU tier.
   */
  tier?: string;
}

/**
 * The resource model definition for a ARM tracked top level resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model TrackedResource extends Resource {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;
}

/**
 * The core properties of ARM resources
 */
model Resource {
  /**
   * Fully qualified resource Id for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. Ex- Microsoft.Compute/virtualMachines or Microsoft.Storage/storageAccounts.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Contains details when the response code indicates an error.
 */
@error
model ErrorResponse {
  /**
   * The error details.
   */
  error: ErrorInfo;
}

/**
 * The code and message for an error.
 */
model ErrorInfo {
  /**
   * A machine readable error code.
   */
  code: string;

  /**
   * A human readable error message.
   */
  message: string;

  /**
   * error details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Existing property from original swagger"
  details?: ErrorDetail[];

  /**
   * Inner error details if they exist.
   */
  innererror?: string;
}

/**
 * Error details.
 */
model ErrorDetail {
  /**
   * The error's code.
   */
  code: string;

  /**
   * A human readable error message.
   */
  message: string;

  /**
   * Indicates which property in the request is responsible for the error.
   */
  target?: string;
}

/**
 * An update to a workspace.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Existing model from original swagger"
model WorkspaceUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * REST API operation
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * The object that represents the operation.
   */
  display?: OperationDisplay;
}

/**
 * The object that represents the operation.
 */
model OperationDisplay {
  /**
   * Service provider: ex Microsoft.Databricks
   */
  provider?: string;

  /**
   * Resource on which the operation is performed.
   */
  resource?: string;

  /**
   * Operation type: Read, write, delete, etc.
   */
  operation?: string;

  /**
   * Description for the resource operation.
   */
  description?: string;
}

/**
 * The available private link resources for a workspace
 */
model PrivateLinkResourcesList is Azure.Core.Page<GroupIdInformation>;

/**
 * The properties for a group information object
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model GroupIdInformationProperties {
  /**
   * The group id
   */
  groupId?: string;

  /**
   * The required members for a specific group id
   */
  requiredMembers?: string[];

  /**
   * The required DNS zones for a specific group id
   */
  requiredZoneNames?: string[];
}

/**
 * List of private link connections.
 */
model PrivateEndpointConnectionsList
  is Azure.Core.Page<PrivateEndpointConnection>;

/**
 * Egress endpoints which Workspace connects to for common purposes.
 */
model OutboundEnvironmentEndpoint {
  /**
   * The category of endpoints accessed by the Workspace, e.g. azure-storage, azure-mysql, etc.
   */
  category?: string;

  /**
   * The endpoints that Workspace connect to
   */
  @identifiers(#[])
  endpoints?: EndpointDependency[];
}

/**
 * Collection of outbound network dependency endpoints
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Existing model from original swagger"
@identifiers(#[])
model OutboundEnvironmentEndpointCollection is OutboundEnvironmentEndpoint[];

/**
 * A domain name or IP address the Workspace is reaching at.
 */
model EndpointDependency {
  /**
   * The domain name of the dependency.
   */
  domainName?: string;

  /**
   * The Ports used when connecting to domainName.
   */
  @identifiers(#[])
  endpointDetails?: EndpointDetail[];
}

/**
 * Connect information from the Workspace to a single endpoint.
 */
model EndpointDetail {
  /**
   * An IP Address that Domain Name currently resolves to.
   */
  ipAddress?: string;

  /**
   * The port an endpoint is connected to.
   */
  port?: int32;

  /**
   * The time in milliseconds it takes for the connection to be created from the Workspace to this IpAddress at this Port.
   */
  latency?: float64;

  /**
   * Whether it is possible to create a connection from the Workspace to this IpAddress at this Port.
   */
  isAccessible?: boolean;
}

/**
 * Properties of the virtual network peering.
 */
model VirtualNetworkPeeringPropertiesFormat {
  /**
   * Whether the VMs in the local virtual network space would be able to access the VMs in remote virtual network space.
   */
  allowVirtualNetworkAccess?: boolean;

  /**
   * Whether the forwarded traffic from the VMs in the local virtual network will be allowed/disallowed in remote virtual network.
   */
  allowForwardedTraffic?: boolean;

  /**
   * If gateway links can be used in remote virtual networking to link to this virtual network.
   */
  allowGatewayTransit?: boolean;

  /**
   * If remote gateways can be used on this virtual network. If the flag is set to true, and allowGatewayTransit on remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway.
   */
  useRemoteGateways?: boolean;

  /**
   *  The remote virtual network should be in the same region. See here to learn more (https://docs.microsoft.com/en-us/azure/databricks/administration-guide/cloud-configurations/azure/vnet-peering).
   */
  databricksVirtualNetwork?: VirtualNetworkPeeringPropertiesFormatDatabricksVirtualNetwork;

  /**
   * The reference to the databricks virtual network address space.
   */
  databricksAddressSpace?: AddressSpace;

  /**
   *  The remote virtual network should be in the same region. See here to learn more (https://docs.microsoft.com/en-us/azure/databricks/administration-guide/cloud-configurations/azure/vnet-peering).
   */
  remoteVirtualNetwork: VirtualNetworkPeeringPropertiesFormatRemoteVirtualNetwork;

  /**
   * The reference to the remote virtual network address space.
   */
  remoteAddressSpace?: AddressSpace;

  /**
   * The status of the virtual network peering.
   */
  @visibility(Lifecycle.Read)
  peeringState?: PeeringState;

  /**
   * The provisioning state of the virtual network peering resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PeeringProvisioningState;
}

/**
 *  The remote virtual network should be in the same region. See here to learn more (https://docs.microsoft.com/en-us/azure/databricks/administration-guide/cloud-configurations/azure/vnet-peering).
 */
model VirtualNetworkPeeringPropertiesFormatDatabricksVirtualNetwork {
  /**
   * The Id of the databricks virtual network.
   */
  id?: string;
}

/**
 * AddressSpace contains an array of IP address ranges that can be used by subnets of the virtual network.
 */
model AddressSpace {
  /**
   * A list of address blocks reserved for this virtual network in CIDR notation.
   */
  addressPrefixes?: string[];
}

/**
 *  The remote virtual network should be in the same region. See here to learn more (https://docs.microsoft.com/en-us/azure/databricks/administration-guide/cloud-configurations/azure/vnet-peering).
 */
model VirtualNetworkPeeringPropertiesFormatRemoteVirtualNetwork {
  /**
   * The Id of the remote virtual network.
   */
  id?: string;
}

/**
 * Gets all virtual network peerings under a workspace.
 */
model VirtualNetworkPeeringList is Azure.Core.Page<VirtualNetworkPeering>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AccessConnectorProperties {
  /**
   * Provisioning status of the Access Connector.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * List of workspaces referring this Access Connector.
   */
  @visibility(Lifecycle.Read)
  referedBy?: string[];
}

/**
 * An update to an Azure Databricks Access Connector.
 */
model AccessConnectorUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

/**
 * Result of the request to list Resource Provider operations. It contains a list of operations and a URL link to get the next set of results.
 */
model OperationListResult {
  /**
   * List of Resource Provider operations supported by the Resource Provider resource provider.
   */
  @pageItems
  @identifiers(#[])
  value?: Operation[];

  /**
   * URL to get the next set of operation list results if there are any.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}
