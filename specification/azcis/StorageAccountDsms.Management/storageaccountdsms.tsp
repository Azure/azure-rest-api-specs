import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/http";
import "@typespec/rest";

using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.AzureCis;

@doc("StorageAccountDsms properties.")
model StorageAccountDsmsResourceProperties {
  @doc("Name of the Storage Account.")
  accountName: string; // Camel case for the parameter names.

  @doc("Root path of the certificate.")
  rootPath: string;

  @doc("Defines in which region of dSMS to provision the Storage Account, such as global-dsms.dsms.%(HostNameSuffix), uswest-dsms.dsms.%(HostNameSuffix). Used only for provisioning Storage Account in non-home-dsms endpoint.")
  dsmsDns?: string; // Can be a part of provisioning ResultData output, and get PATCHed back from FRP.

  @doc("Subscription Tenant Id. If not set, will use default tenant id in global setting.")
  subscriptionTenantId?: string;

  @doc("Account replication type (SKU).")
  accountReplicationType?: AccountReplicationType;

  @doc("Description of the XStore account.")
  description?: string;

  @doc("Location of the Storage Account. Use RDFE location ID.")
  location?: string;

  @doc("Label of the XStore account.")
  label?: string;

  @doc("If False, create Storage Account and dSMS object in Deferred Provisioning; if True, create dSMS object in Provisioning, then create Storage Account in Deferred Provisioning and refresh keys in dSMS. Optional, True by default.")
  xstoreBootstrapping?: boolean;

  @doc("Name of the event to emit once the XStore account is created.")
  eventEmittedUponProvisioning?: string;

  @doc("Storage account whitelist in dSMS.")
  whitelists?: Whitelists;

  @doc("Storage account Replication in dSMS.")
  replicate?: Replicate;

  @doc("Set to True to block auto key rollover. Optional, False by default.")
  blockAutoRollover?: boolean;

  @doc("Key renewal period in days. Optional, 365 by default.")
  keyRenewalPeriodInDays?: int32;

  @doc("Set to True to grant Access Control List (ACL) permissions to access this Storage Account to Autopilot or PilotFish environments. Optional, False by default.")
  releaseKeyToAgent?: boolean;

  @doc("Set to True to force global sync of dSMS secret or False to skip it. Optional, False by default.")
  forceSyncGlobalDsmsSecret?: boolean;

  @doc("Storage Account resource provider.")
  resourceProvider: ResourceProvider;

  @doc("Set to True to pilot XStore resource provider. In new region or new cloud scenario, it can create Storage Account at earlier stage before ARM ready. This is mainly as a replacement for Classic resource provider which will be deprecated with RDFE.")
  pilotXstoreResourceProvider?: boolean;

  @doc("Storage account shared access signature.")
  @Azure.ResourceManager.identifiers(#[])
  accountSasInfos?: Array<AccountSasInfo>;

  @doc("Residency boundary. Acceptable values: 'Worldwide', 'National'.")
  residencyBoundary?: "Worldwide" | "National" | string;

  @doc("Minimum account replication type, e.g. 'Standard_LRS'. If it's set, it will enable VRS feature for the Storage Account, and the 'AccountReplicationType' property will not be used.")
  resiliencyMinimum?: AccountReplicationType;

  @doc("Maximum account replication type, e.g. 'Standard_ZRS'.")
  resiliencyMaximum?: AccountReplicationType;

  @doc("Resiliencies progression controls how Storage Account is migrated by VRS.")
  resilienciesProgressionId?: ResilienciesProgressionId;

  @doc("Additional locations to support resiliency, e.g. 'primary', separated by ',' or ';'.")
  additionalLocations?: string;

  @doc("Dual Stack Endpoint Preference.")
  dualStackEndpointPreference?: DualStackEndpointPreference;

  @doc("An array of Lifecycle Management Policy rules.")
  @Azure.ResourceManager.identifiers(#[])
  lifecycleManagementPolicy?: Array<LifecycleManagementPolicyRule>;

  @doc("Defines if Infrastructure Encryption is required.")
  requireInfrastructureEncryption?: boolean;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Duplicate property found in the resource envelope and resource properties."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Generic object model is used, because the number of nested properties can be different."
  @doc("Properties can be used to save customer key-value pairs associated with the dSMS secrets. Optional.")
  properties?: {};

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: StorageAccountDsmsProvisioningState;

  @doc("Storage Account dSMS object name; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  storageAccountDsmsName?: string;

  @doc("Storage Account dSMS object resource provider; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  storageAccountDsmsResourceProviderName?: string;

  @doc("Storage Account ARM creation time; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  storageAccountArmCreationTime?: string;

  @doc("Storage Account RDFE creation time; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  storageAccountRdfeCreationTime?: string;

  @doc("Storage Account XStore creation time; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  storageAccountXstoreCreationTime?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "The property name in the original Resource Template code contains an underscore."
  @doc("DsmsAccountTemplate provision start time; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  provisionStartTime_dsmsAccountTemplate?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "The property name in the original Resource Template code contains an underscore."
  @doc("StorageAccountTemplate provision start time; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  provisionStartTime_storageAccountTemplate?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "The property name in the original Resource Template code contains an underscore."
  @doc("StorageAccountSyncTemplate provision start time; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  provisionStartTime_storageAccountSyncTemplate?: string;
}

@doc("Account replication type (SKU).")
union AccountReplicationType {
  @doc("Standard Locally Redundant Storage.")
  Standard_LRS: "Standard_LRS",

  @doc("Standard Geo Replicated Storage.")
  Standard_GRS: "Standard_GRS",

  @doc("Standard Zone Redundant Storage.")
  Standard_ZRS: "Standard_ZRS",

  @doc("Standard Read-Access Geo Replicated Storage.")
  Standard_RAGRS: "Standard_RAGRS",

  @doc("Provisioned IO Locally Redundant Storage.")
  Premium_LRS: "Premium_LRS",

  string,
}

@doc("Whitelist element defines the whitelist for a secret.")
model Whitelist {
  @doc("Type of the whitelist: 'ServiceID': whitelisting a service; 'SubscriptionID': whitelisting subscription ID for creating Storage Account objects; 'DnsDomain': whitelisting a DNS domain for creating chained certificates; 'ServiceTreeID': whitelisting a service tree ID.")
  type: "ServiceID" | "SubscriptionID" | "DnsDomain" | "ServiceTreeID" | string;

  @doc("Values of the whitelist, separated by semicolon.")
  values: string;
}

@doc("Whitelists element is a wrapper object over a collection of Whitelist elements.")
model Whitelists {
  @doc("Array of whitelists.")
  @Azure.ResourceManager.identifiers(#[])
  whitelist: Array<Whitelist>;
}

@doc("Replicate element defines where the secret should be replicated to.")
model Replicate {
  @doc("Replication type. 'Local': This secret is not replicated to other dSMS instance. 'AllDsmsRegions': This secret can be replicated to all dSMS instances. 'SpecifiedDsmsRegions': This secret can only be replicated to the specified dSMS instances.")
  type: "Local" | "AllDsmsRegions" | "SpecifiedDsmsRegions" | string;

  @doc("List of regions the secret will be replicated to, separated by semicolon. Applicable when the replication type is SpecifiedDsmsRegions.")
  regions: string;
}

@doc("Storage Account resource provider.")
union ResourceProvider {
  @doc("Used to create RDFE Storage Account.")
  Classic: "Classic",

  @doc("Used to create StorageV2 (General Purpose v2 / GPv2) Storage Account.")
  ARM: "ARM",

  @doc("Used to create Xstore Storage Account.")
  Xstore: "Xstore",

  @doc("Used to create a dummy account in dSMS.")
  Invalid: "Invalid",

  string,
}

@doc("AccountSasInfo element contains Sas Key Information.")
model AccountSasInfo {
  @doc("dSMS root folder.")
  rootPath: string;

  @doc("Name of the Storage Account.")
  name: string;

  @doc("Path in Dsms endpoint. If this specified, then RootPath and Name should be ignored.")
  dsmsLocation: string;

  @doc("The signed permissions for the account SAS. Acceptable values: Read (r), Write (w), Delete (d), List (l), Add (a), Create (c), Update (u) and Process (p).")
  signedPermissions: string;

  @doc("Services like blob (b), queue (q) and table (t).")
  signedServices: string;

  @doc("The signed resource types that are accessible with the account SAS: Service (s) / Container (c) / Object (o).")
  signedResourceTypes: string;

  @doc("List of regions where the SAS should be provisioned, separated by semicolon. May include both region names and DsmsDns names.")
  regions: string;
}

@doc("Resiliencies progression id.")
union ResilienciesProgressionId {
  @doc("Default resiliencies progression: Standard_LRS, Standard_ZRS, Standard_GRS, Standard_GZRS, Standard_RAGRS, Standard_RAGZRS.")
  Default: "Default",

  @doc("PremiumDefault resiliencies progression: Premium_LRS, Premium_ZRS.")
  PremiumDefault: "PremiumDefault",

  @doc("Zonal resiliencies progression: Standard_LRS, Standard_GRS, Standard_ZRS, Standard_GZRS, Standard_RAGRS, Standard_RAGZRS.")
  Zonal: "Zonal",

  string,
}

@doc("Lifecycle Management Policy Rule for Storage Account.")
model LifecycleManagementPolicyRule {
  @doc("Name of the policy rule.")
  name: string;

  @doc("Indicates whether the rule is enabled.")
  enabled: boolean;

  @doc("Policy for base blobs.")
  @Azure.ResourceManager.identifiers(#[])
  baseBlobPolicy: Array<LcmActionPolicy>;

  @doc("Policy for snapshots.")
  @Azure.ResourceManager.identifiers(#[])
  snapshotPolicy: Array<LcmActionPolicy>;

  @doc("Policy for versions.")
  @Azure.ResourceManager.identifiers(#[])
  versionPolicy: Array<LcmActionPolicy>;

  @doc("A string, containing BlobTypes to filter, separated with a semicolon. Acceptable values: 'blockBlob', 'appendBlob'.")
  blobTypesFilter: "blockBlob" | "appendBlob" | string;

  @doc("List of prefixes to filter by.")
  prefixMatchFilter: Array<string>;

  @doc("List of blob index match filters.")
  @Azure.ResourceManager.identifiers(#[])
  blobIndexMatchFilter: Array<BlobIndexMatch>;
}

@doc("Lifecycle Management Policy details for a specific action in a rule.")
model LcmActionPolicy {
  @doc("Action to be performed. Acceptable values: 'tierToCool', 'tierToArchive', 'tierToCold', 'tierToHot', 'delete'.")
  action:
    | "tierToCool"
    | "tierToArchive"
    | "tierToCold"
    | "tierToHot"
    | "delete"
    | string;

  @doc("Days after modification greater than.")
  daysAfterModificationGreaterThan?: int32;

  @doc("Days after last access time greater than.")
  daysAfterLastAccessTimeGreaterThan?: int32;

  @doc("Days after last tier change greater than (specific to tierToArchive action).")
  daysAfterLastTierChangeGreaterThan?: int32;

  @doc("Days after creation greater than.")
  daysAfterCreationGreaterThan?: int32;
}

@doc("Blob Index Match filter.")
model BlobIndexMatch {
  @doc("Filter tag name.")
  name: string;

  @doc("Comparison operator.")
  operator: string;

  @doc("Filter tag value.")
  value: string;
}

@doc("Dual Stack Endpoint Preference.")
model DualStackEndpointPreference {
  @doc("Enable default dual stack endpoints.")
  defaultDualStackEndpoints?: boolean;

  @doc("Publish IPv4 endpoint.")
  publishIpv4Endpoint?: boolean;

  @doc("Publish IPv6 endpoint.")
  publishIpv6Endpoint?: boolean;
}

@doc("StorageAccount Resource")
model StorageAccountDsmsResource
  is ProxyResource<StorageAccountDsmsResourceProperties> { // This can be TrackedResource based on resourcetype.
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("storageAccountDsms") // Start with lower case. Should be plural.
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Delete operation is currently not supported by FRP."
@armResourceOperations
interface StorageAccountDsms {
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "Fix on next update"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    StorageAccountDsmsResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  get is ArmResourceRead<StorageAccountDsmsResource>;
  listByResourceGroup is ArmResourceListByParent<StorageAccountDsmsResource>;
  listBySubscription is ArmListBySubscription<StorageAccountDsmsResource>;
}

@@visibility(StorageAccountDsmsResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
