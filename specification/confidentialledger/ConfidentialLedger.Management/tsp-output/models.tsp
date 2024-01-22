import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ConfidentialLedger;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Object representing RunningState for Confidential Ledger.
 */
enum RunningState {
  Active,
  Paused,
  Unknown,
  Pausing,
  Resuming,
}

/**
 * Type of the ledger. Private means transaction data is encrypted.
 */
enum LedgerType {
  Unknown,
  Public,
  Private,
}

/**
 * Object representing ProvisioningState for Confidential Ledger.
 */
enum ProvisioningState {
  Unknown,
  Succeeded,
  Failed,
  Canceled,
  Creating,
  Deleting,
  Updating,
}

/**
 * LedgerRole associated with the Security Principal of Ledger
 */
enum LedgerRoleName {
  Reader,
  Contributor,
  Administrator,
}

/**
 * Object representing LanguageRuntime for Manged CCF.
 */
enum LanguageRuntime {
  CPP,
  JS,
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
 * The check availability request body.
 */
model CheckNameAvailabilityRequest {
  /**
   * The name of the resource for which availability needs to be checked.
   */
  name?: string;

  /**
   * The resource type.
   */
  type?: string;
}

/**
 * The check availability result.
 */
model CheckNameAvailabilityResponse {
  /**
   * Indicates if the resource name is available.
   */
  nameAvailable?: boolean;

  /**
   * The reason why the given name is not available.
   */
  reason?: CheckNameAvailabilityReason;

  /**
   * Detailed reason why the given name is available.
   */
  message?: string;
}

/**
 * Additional Confidential Ledger properties.
 */
model LedgerProperties {
  /**
   * Unique name for the Confidential Ledger.
   */
  @visibility("read")
  ledgerName?: string;

  /**
   * Endpoint for calling Ledger Service.
   */
  @visibility("read")
  ledgerUri?: string;

  /**
   * Endpoint for accessing network identity.
   */
  @visibility("read")
  identityServiceUri?: string;

  /**
   * Internal namespace for the Ledger
   */
  @visibility("read")
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
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Array of all AAD based Security Principals.
   */
  aadBasedSecurityPrincipals?: AADBasedSecurityPrincipal[];

  /**
   * Array of all cert based Security Principals.
   */
  certBasedSecurityPrincipals?: CertBasedSecurityPrincipal[];
}

/**
 * AAD based security principal with associated Ledger RoleName
 */
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
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Additional Managed CCF properties.
 */
model ManagedCCFProperties {
  /**
   * Unique name for the Managed CCF.
   */
  @visibility("read")
  appName?: string;

  /**
   * Endpoint for calling Managed CCF Service.
   */
  @visibility("read")
  appUri?: string;

  /**
   * Endpoint for accessing network identity.
   */
  @visibility("read")
  identityServiceUri?: string;

  /**
   * List of member identity certificates for  Managed CCF
   */
  memberIdentityCertificates?: MemberIdentityCertificate[];

  /**
   * Deployment Type of Managed CCF
   */
  deploymentType?: DeploymentType;

  /**
   * Provisioning state of Ledger Resource
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Number of CCF nodes in the Managed CCF.
   */
  nodeCount?: int32 = 3;
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
  tags?: unknown;
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
 * Tags for Managed CCF Certificates
 */
model CertificateTags {
  /**
   * Additional tags for Managed CCF Certificates
   */
  tags?: Record<string>;
}
