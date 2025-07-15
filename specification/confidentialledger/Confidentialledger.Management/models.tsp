import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;

namespace Microsoft.ConfidentialLedger;

/**
 * The reason why the given name is not available.
 */
union CheckNameAvailabilityReason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AlreadyExists: "AlreadyExists",
}

/**
 * Object representing RunningState for Confidential Ledger.
 */
union RunningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Paused: "Paused",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pausing: "Pausing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Resuming: "Resuming",
}

/**
 * Type of the ledger. Private means transaction data is encrypted.
 */
union LedgerType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Public: "Public",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Private: "Private",
}

/**
 * Object representing ProvisioningState for Confidential Ledger.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
}

/**
 * SKU associated with the ledger resource
 */
union LedgerSku {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
}

/**
 * LedgerRole associated with the Security Principal of Ledger
 */
union LedgerRoleName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Reader: "Reader",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Contributor: "Contributor",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Administrator: "Administrator",
}

/**
 * Object representing the enclave platform for the Confidential Ledger application. Defaults to IntelSgx.
 */
union EnclavePlatform {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IntelSgx: "IntelSgx",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AmdSevSnp: "AmdSevSnp",
}

/**
 * Object representing the application type of the Confidential Ledger. Defaults to ConfidentialLedger.
 */
union ApplicationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ConfidentialLedger: "ConfidentialLedger",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CodeTransparency: "CodeTransparency",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * Object representing LanguageRuntime for Manged CCF.
 */
union LanguageRuntime {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CPP: "CPP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  JS: "JS",
}

/**
 * List containing this Resource Provider's available operations.
 */
@pagedResult
model ResourceProviderOperationList {
  /**
   * The list of operations.
   */
  @items
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  @visibility(Lifecycle.Read)
  value?: ResourceProviderOperationDefinition[];

  /**
   * The URL to get the next set of results, if any.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Describes the Resource Provider Operation.
 */
model ResourceProviderOperationDefinition {
  /**
   * Resource provider operation name.
   */
  name?: string;

  /**
   * Indicates whether the operation is data action or not.
   */
  isDataAction?: boolean;

  /**
   * Details about the operations
   */
  display?: ResourceProviderOperationDisplay;
}

/**
 * Describes the properties of the Operation.
 */
model ResourceProviderOperationDisplay {
  /**
   * Name of the resource provider.
   */
  provider?: string;

  /**
   * Name of the resource type.
   */
  resource?: string;

  /**
   * Name of the resource provider operation.
   */
  operation?: string;

  /**
   * Description of the resource provider operation.
   */
  description?: string;
}

/**
 * Additional Confidential Ledger properties.
 */
model LedgerProperties {
  /**
   * Unique name for the Confidential Ledger.
   */
  @visibility(Lifecycle.Read)
  ledgerName?: string;

  /**
   * Endpoint for calling Ledger Service.
   */
  @visibility(Lifecycle.Read)
  ledgerUri?: string;

  /**
   * Endpoint for accessing network identity.
   */
  @visibility(Lifecycle.Read)
  identityServiceUri?: string;

  /**
   * Internal namespace for the Ledger
   */
  @visibility(Lifecycle.Read)
  ledgerInternalNamespace?: string;

  /**
   * Object representing RunningState for Ledger.
   */
  runningState?: RunningState;

  /**
   * Type of Confidential Ledger
   */
  ledgerType?: LedgerType;

  /**
   * Provisioning state of Ledger Resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * SKU associated with the ledger
   */
  ledgerSku?: LedgerSku;

  /**
   * Array of all AAD based Security Principals.
   */
  @OpenAPI.extension("x-ms-identifiers", #["principalId"])
  aadBasedSecurityPrincipals?: AADBasedSecurityPrincipal[];

  /**
   * Array of all cert based Security Principals.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  certBasedSecurityPrincipals?: CertBasedSecurityPrincipal[];

  /**
   * CCF Property for the logging level for the untrusted host: Trace, Debug, Info, Fail, Fatal.
   */
  hostLevel?: string;

  /**
   * CCF Property for the maximum size of the http request body: 1MB, 5MB, 10MB.
   */
  maxBodySizeInMb?: int32;

  /**
   * CCF Property for the subject name to include in the node certificate. Default: CN=CCF Node.
   */
  subjectName?: string;

  /**
   * Number of CCF nodes in the ACC Ledger.
   */
  nodeCount?: int32;

  /**
   * Prefix for the write load balancer. Example: write
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  writeLBAddressPrefix?: string;

  /**
   * Number of additional threads processing incoming client requests in the enclave (modify with care!)
   */
  workerThreads?: int32;

  /**
   * Enclave platform of the Confidential Ledger.
   */
  enclavePlatform?: EnclavePlatform;

  /**
   * Application type of the Confidential Ledger.
   */
  applicationType?: ApplicationType;

  /**
   * The SCITT Configuration that needs to be set for the Confidential Ledger.
   */
  scittConfiguration?: string;
}

/**
 * AAD based security principal with associated Ledger RoleName
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model AADBasedSecurityPrincipal {
  /**
   * UUID/GUID based Principal Id of the Security Principal
   */
  principalId?: string;

  /**
   * UUID/GUID based Tenant Id of the Security Principal
   */
  tenantId?: string;

  /**
   * LedgerRole associated with the Security Principal of Ledger
   */
  ledgerRoleName?: LedgerRoleName;
}

/**
 * Cert based security principal with Ledger RoleName
 */
model CertBasedSecurityPrincipal {
  /**
   * Public key of the user cert (.pem or .cer)
   */
  cert?: string;

  /**
   * LedgerRole associated with the Security Principal of Ledger
   */
  ledgerRoleName?: LedgerRoleName;
}

/**
 * Object that includes an array of Confidential Ledgers and a possible link for next set.
 */
model ConfidentialLedgerList is Azure.Core.Page<ConfidentialLedger>;

/**
 * Object representing Backup properties of a Confidential Ledger Resource.
 */
model ConfidentialLedgerBackup {
  /**
   * The region where the backup of the ledger will eventually be restored to.
   */
  restoreRegion?: string;

  /**
   * SAS URI used to access the backup Fileshare.
   */
  @secret
  uri: string;
}

/**
 * Object representing the backup response of a Confidential Ledger Resource.
 */
model ConfidentialLedgerBackupResponse {
  /**
   * Response body stating if the ledger is being backed up.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Object representing Restore properties of a Confidential Ledger Resource.
 */
model ConfidentialLedgerRestore {
  /**
   * Fileshare where the ledger backup is stored.
   */
  fileShareName: string;

  /**
   * The region the ledger is being restored to.
   */
  restoreRegion: string;

  /**
   * SAS URI used to access the backup fileshare.
   */
  @secret
  uri: string;
}

/**
 * Object representing the restore response of a Confidential Ledger Resource.
 */
model ConfidentialLedgerRestoreResponse {
  /**
   * Response body stating if the ledger is being restored.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Additional Managed CCF properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model ManagedCCFProperties {
  /**
   * Unique name for the Managed CCF.
   */
  @visibility(Lifecycle.Read)
  appName?: string;

  /**
   * Endpoint for calling Managed CCF Service.
   */
  @visibility(Lifecycle.Read)
  appUri?: string;

  /**
   * Endpoint for accessing network identity.
   */
  @visibility(Lifecycle.Read)
  identityServiceUri?: string;

  /**
   * List of member identity certificates for  Managed CCF
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  memberIdentityCertificates?: MemberIdentityCertificate[];

  /**
   * Deployment Type of Managed CCF
   */
  deploymentType?: DeploymentType;

  /**
   * Object representing RunningState for Managed CCF.
   */
  runningState?: RunningState;

  /**
   * Provisioning state of Managed CCF Resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Number of CCF nodes in the Managed CCF.
   */
  nodeCount?: int32;

  /**
   * Enclave platform of Managed CCF.
   */
  enclavePlatform?: EnclavePlatform;
}

/**
 * Object representing MemberIdentityCertificate for Managed CCF.
 */
model MemberIdentityCertificate {
  /**
   * Member Identity Certificate
   */
  certificate?: string;

  /**
   * Member Identity Certificate Encryption Key
   */
  encryptionkey?: string;

  /**
   * Anything
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  tags?: CertificateTags[];
}

/**
 * Object representing DeploymentType for Managed CCF.
 */
model DeploymentType {
  /**
   * Unique name for the Managed CCF.
   */
  languageRuntime?: LanguageRuntime;

  /**
   * Source Uri containing ManagedCCF code
   */
  appSourceUri?: string;
}

/**
 * Object that includes an array of Managed CCF and a possible link for next set.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model ManagedCCFList is Azure.Core.Page<ManagedCCF>;

/**
 * Object representing Backup properties of a Managed CCF Resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model ManagedCCFBackup {
  /**
   * The region where the backup of the managed CCF resource will eventually be restored to.
   */
  restoreRegion?: string;

  /**
   * SAS URI used to access the backup Fileshare.
   */
  @secret
  uri: string;
}

/**
 * Object representing the backup response of a Managed CCF Resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model ManagedCCFBackupResponse {
  /**
   * Response body stating if the managed CCF resource is being backed up.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Object representing Restore properties of Managed CCF Resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model ManagedCCFRestore {
  /**
   * Fileshare where the managed CCF resource backup is stored.
   */
  fileShareName: string;

  /**
   * The region the managed CCF resource is being restored to.
   */
  restoreRegion: string;

  /**
   * SAS URI used to access the backup Fileshare.
   */
  @secret
  uri: string;
}

/**
 * Object representing the restore response of a Managed CCF Resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model ManagedCCFRestoreResponse {
  /**
   * Response body stating if the managed CCF resource is being restored.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Tags for Managed CCF Certificates
 */
model CertificateTags {
  /**
   * Additional tags for Managed CCF Certificates
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}
