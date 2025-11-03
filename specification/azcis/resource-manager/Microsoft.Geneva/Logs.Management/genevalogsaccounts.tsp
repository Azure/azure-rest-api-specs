import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.AzureCis;

@doc("GenevaLogsAccounts properties")
model GenevaLogsAccountsResourceProperties {
  @doc("The name of the warm path account. This must be unique. Logs Account name must start with a letter and can contain numbers/letters.")
  @pattern("^[a-zA-Z0-9-]*$")
  @minLength(6)
  @maxLength(32)
  accountName: string;

  @doc("The MDS environment")
  mdsEnvironment: MdsEnvironment;

  @doc("The metrics account name")
  metricsAccountName: string;

  @doc("The contact email")
  contactEmail: string;

  @doc("The array of aliases for administrators")
  administratorAliases: Array<string>;

  @doc("The security group for account administrator")
  administratorSecurityGroup: string;

  @doc("An Azure subscription to use for GSM provisioning. Each subscription in the list must have granted Geneva access via RBAC.")
  subscriptionIds: Array<string>;

  @doc("The default storage replication type")
  defaultStorageReplicationType: AccountReplicationType;

  @doc("DSMS certificate for configuring the MACommunication User Role.")
  dsmsCertificate?: DsmsCertificate;

  @doc("Key Vault certificate for configuring the MACommunication User Role.")
  keyVaultCertificate?: KeyVaultCertificate;

  @doc("Namespaces to register with MDS.")
  namespaceNames: Array<string>;

  @doc("Flag, indicating whether to create default storage groups.")
  createDefaultStorageGroups?: boolean;

  @doc("Region where the initial monikers would be created for default storage groups.")
  defaultAzureRegion?: string;

  @doc("Mode for configuration files uploading. Could be 'ARM' or 'DCMT'.")
  mode?: ConfigUploadMode;

  @doc("SAS for config package zip file containing a configuration to upload.")
  namespaceConfig?: string;

  @doc("Specifies the SAS for configuration main file, if provided instead of config package zip file.")
  namespaceConfigMainFile?: string;

  @doc("Specifies the SAS for zip import file.")
  namespaceConfigImportZip?: string;

  @doc("Explicitly specify SAS for each import file, if provided not in zip format.")
  namespaceConfigImportFiles?: Array<string>;

  @doc("Define custom storage groups instead of using the default storage groups, and setup Kusto streaming.")
  @Azure.ResourceManager.identifiers(#["storageGroupName"])
  storageGroups?: Array<StorageGroup>;

  @doc("Define custom user roles in addition to the user roles created by default (MaCommunication and MdsAccountAdmin roles).")
  userRoles?: Array<UserRole>;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: GenevaLogsProvisioningState;

  @doc("Resource event argument result; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  configDetails?: ConfigDetails;
}

@doc("Storage Group")
model StorageGroup {
  @doc("The config namespace")
  configNamespace: string;

  @doc("The storage group name")
  storageGroupName: string;

  @doc("The default region")
  defaultRegion: string;

  @doc("The storage replication types")
  storageReplicationTypes: Array<AccountReplicationType>;

  @doc("The consumer groups")
  consumerGroups: Array<string>;

  @doc("The region based Kusto settings mode")
  regionBasedKustoSettingsMode: KustoSettingsMode;

  @doc("The region based Kusto settings")
  @Azure.ResourceManager.identifiers(#["region"])
  regionBasedKustoSettings: Array<RegionBasedKustoSetting>;
}

@doc("Region based Kusto setting")
model RegionBasedKustoSetting {
  @doc("The setting region")
  region: string;

  @doc("The log analytics id")
  logAnalyticsId: string;

  @doc("The log analytics database")
  logAnalyticsDatabase: string;
}

@doc("User role")
model UserRole {
  @doc("The user role name")
  name: string;

  @doc("The security groups")
  securityGroups: Array<string>;

  @doc("The users")
  users: Array<string>;

  @doc("The dSMS certificates")
  @Azure.ResourceManager.identifiers(#["identity"])
  dsmsCertificates?: Array<DsmsCertificate>;

  @doc("The KeyVault certificates")
  @Azure.ResourceManager.identifiers(#["rootCertificateThumbprint"])
  keyVaultCertificates?: Array<KeyVaultCertificate>;

  @doc("The MSI configurations")
  @Azure.ResourceManager.identifiers(#["objectId"])
  msiConfigs?: Array<MsiConfig>;

  @doc("The list of AutoPilot Public Key Infrastructure Access Control Lists")
  appkiAcl?: Array<string>;

  @doc("The agent claims")
  @Azure.ResourceManager.identifiers(#["namespaceRegex"])
  agentClaims?: Array<AgentClaim>;

  @doc("The config claims")
  @Azure.ResourceManager.identifiers(#["resource"])
  configClaims?: Array<ConfigClaim>;
}

@doc("Config claim")
model ConfigClaim {
  @doc("The resource")
  resource: string;

  @doc("The right")
  right: string;
}

@doc("Agent claim")
model AgentClaim {
  @doc("The namespace regex")
  namespaceRegex: string;

  @doc("The right")
  right: string;
}

@doc("MSI configuration")
model MsiConfig {
  @doc("The object identifier")
  objectId?: string;

  @doc("The tenant identifier")
  tenantId?: string;

  @doc("The resource identifier")
  resourceId?: string;

  @doc("The description")
  description: string;
}

@doc("KeyVault certificate")
model KeyVaultCertificate {
  @doc("The root certificate thumbprint")
  rootCertificateThumbprint: string;

  @doc("The SAN")
  san: string;

  @doc("The description")
  description: string;
}

@doc("DSMS certificate")
model DsmsCertificate {
  @doc("The description")
  description: string;

  @doc("The identity")
  identity: string;
}

@doc("Kusto settings mode")
union KustoSettingsMode {
  @doc("Append mode")
  Append: "Append",

  @doc("Reset mode")
  Reset: "Reset",

  string,
}

@doc("Configuration uploading mode")
union ConfigUploadMode {
  @doc("ARM mode")
  ARM: "ARM",

  @doc("DCMT mode")
  DCMT: "DCMT",

  string,
}

@doc("MDS environment")
union MdsEnvironment {
  @doc("Smoke environment")
  Smoke: "Smoke",

  @doc("Canary environment")
  Canary: "Canary",

  @doc("Test environment")
  Test: "Test",

  @doc("Stage environment")
  Stage: "Stage",

  @doc("DiagnosticsProd environment")
  DiagnosticsProd: "DiagnosticsProd",

  @doc("FirstPartyProd environment")
  FirstPartyProd: "FirstPartyProd",

  @doc("BillingProd environment")
  BillingProd: "BillingProd",

  @doc("CaFairfax environment")
  CaFairfax: "CaFairfax",

  @doc("CaMooncake environment")
  CaMooncake: "CaMooncake",

  @doc("CaBlackForest environment")
  CaBlackForest: "CaBlackForest",

  @doc("UsSec environment")
  UsSec: "UsSec",

  @doc("UsNat environment")
  UsNat: "UsNat",

  @doc("ExternalProd environment")
  ExternalProd: "ExternalProd",

  @doc("CanaryEast environment")
  CanaryEast: "CanaryEast",

  @doc("CanaryWest environment")
  CanaryWest: "CanaryWest",

  @doc("CanaryNorth environment")
  CanaryNorth: "CanaryNorth",

  @doc("CanarySouth environment")
  CanarySouth: "CanarySouth",

  @doc("Bleu environment")
  Bleu: "Bleu",

  @doc("Delos environment")
  Delos: "Delos",

  @doc("GovSG environment")
  GovSG: "GovSG",

  string,
}

@doc("Configuration details result")
model ConfigDetails {
  @doc("Configuration version")
  configVersion: string;
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

@doc("genevaLogsAccounts Resource")
model GenevaLogsAccountsResource
  is ProxyResource<GenevaLogsAccountsResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]*$")
  @minLength(3)
  @maxLength(80)
  @key("resourceName")
  @segment("genevaLogsAccounts") // start with lower case
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Delete operation is currently not supported by FRP."
@armResourceOperations
interface GenevaLogsAccounts {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GenevaLogsAccountsResource>;
  listBySubscription is ArmListBySubscription<GenevaLogsAccountsResource>;
  listByResourceGroup is ArmResourceListByParent<GenevaLogsAccountsResource>;
  get is ArmResourceRead<GenevaLogsAccountsResource>;
}
