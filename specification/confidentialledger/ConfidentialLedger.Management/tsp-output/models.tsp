import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ConfidentialLedger;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Object representing RunningState for Confidential Ledger.")
enum RunningState {
  Active,
  Paused,
  Unknown,
  Pausing,
  Resuming,
}

@doc("Type of the ledger. Private means transaction data is encrypted.")
enum LedgerType {
  Unknown,
  Public,
  Private,
}

@doc("Object representing ProvisioningState for Confidential Ledger.")
enum ProvisioningState {
  Unknown,
  Succeeded,
  Failed,
  Canceled,
  Creating,
  Deleting,
  Updating,
}

@doc("LedgerRole associated with the Security Principal of Ledger")
enum LedgerRoleName {
  Reader,
  Contributor,
  Administrator,
}

@doc("Object representing LanguageRuntime for Manged CCF.")
enum LanguageRuntime {
  CPP,
  JS,
}

@doc("Describes the Resource Provider Operation.")
model ResourceProviderOperationDefinition {
  @doc("Resource provider operation name.")
  name?: string;

  @doc("Indicates whether the operation is data action or not.")
  isDataAction?: boolean;

  @doc("Details about the operations")
  display?: ResourceProviderOperationDisplay;
}

@doc("Describes the properties of the Operation.")
model ResourceProviderOperationDisplay {
  @doc("Name of the resource provider.")
  provider?: string;

  @doc("Name of the resource type.")
  resource?: string;

  @doc("Name of the resource provider operation.")
  operation?: string;

  @doc("Description of the resource provider operation.")
  description?: string;
}

@doc("The check availability request body.")
model CheckNameAvailabilityRequest {
  @doc("The name of the resource for which availability needs to be checked.")
  name?: string;

  @doc("The resource type.")
  type?: string;
}

@doc("The check availability result.")
model CheckNameAvailabilityResponse {
  @doc("Indicates if the resource name is available.")
  nameAvailable?: boolean;

  @doc("The reason why the given name is not available.")
  reason?: CheckNameAvailabilityReason;

  @doc("Detailed reason why the given name is available.")
  message?: string;
}

@doc("Additional Confidential Ledger properties.")
model LedgerProperties {
  @doc("Unique name for the Confidential Ledger.")
  @visibility("read")
  ledgerName?: string;

  @doc("Endpoint for calling Ledger Service.")
  @visibility("read")
  ledgerUri?: string;

  @doc("Endpoint for accessing network identity.")
  @visibility("read")
  identityServiceUri?: string;

  @doc("Internal namespace for the Ledger")
  @visibility("read")
  ledgerInternalNamespace?: string;

  @doc("Object representing RunningState for Ledger.")
  runningState?: RunningState;

  @doc("Type of Confidential Ledger")
  ledgerType?: LedgerType;

  @doc("Provisioning state of Ledger Resource")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Array of all AAD based Security Principals.")
  aadBasedSecurityPrincipals?: AADBasedSecurityPrincipal[];

  @doc("Array of all cert based Security Principals.")
  certBasedSecurityPrincipals?: CertBasedSecurityPrincipal[];
}

@doc("AAD based security principal with associated Ledger RoleName")
model AADBasedSecurityPrincipal {
  @doc("UUID/GUID based Principal Id of the Security Principal")
  principalId?: string;

  @doc("UUID/GUID based Tenant Id of the Security Principal")
  tenantId?: string;

  @doc("LedgerRole associated with the Security Principal of Ledger")
  ledgerRoleName?: LedgerRoleName;
}

@doc("Cert based security principal with Ledger RoleName")
model CertBasedSecurityPrincipal {
  @doc("Public key of the user cert (.pem or .cer)")
  cert?: string;

  @doc("LedgerRole associated with the Security Principal of Ledger")
  ledgerRoleName?: LedgerRoleName;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Additional Managed CCF properties.")
model ManagedCCFProperties {
  @doc("Unique name for the Managed CCF.")
  @visibility("read")
  appName?: string;

  @doc("Endpoint for calling Managed CCF Service.")
  @visibility("read")
  appUri?: string;

  @doc("Endpoint for accessing network identity.")
  @visibility("read")
  identityServiceUri?: string;

  @doc("List of member identity certificates for  Managed CCF")
  memberIdentityCertificates?: MemberIdentityCertificate[];

  @doc("Deployment Type of Managed CCF")
  deploymentType?: DeploymentType;

  @doc("Provisioning state of Ledger Resource")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Number of CCF nodes in the Managed CCF.")
  nodeCount?: int32;
}

@doc("Object representing MemberIdentityCertificate for Managed CCF.")
model MemberIdentityCertificate {
  @doc("Member Identity Certificate")
  certificate?: string;

  @doc("Member Identity Certificate Encryption Key")
  encryptionkey?: string;

  @doc("Anything")
  tags?: unknown;
}

@doc("Object representing DeploymentType for Managed CCF.")
model DeploymentType {
  @doc("Unique name for the Managed CCF.")
  languageRuntime?: LanguageRuntime;

  @doc("Source Uri containing ManagedCCF code")
  appSourceUri?: string;
}

@doc("Tags for Managed CCF Certificates")
model CertificateTags {
  @doc("Additional tags for Managed CCF Certificates")
  tags?: Record<string>;
}
