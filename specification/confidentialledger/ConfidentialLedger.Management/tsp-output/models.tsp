import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ConfidentialLedger;

enum CheckNameAvailabilityReason {
  Invalid,
  AlreadyExists,
}

enum RunningState {
  Active,
  Paused,
  Unknown,
  Pausing,
  Resuming,
}

enum LedgerType {
  Unknown,
  Public,
  Private,
}

enum ProvisioningState {
  Unknown,
  Succeeded,
  Failed,
  Canceled,
  Creating,
  Deleting,
  Updating,
}

enum LedgerRoleName {
  Reader,
  Contributor,
  Administrator,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum LanguageRuntime {
  CPP,
  JS,
}

@doc("List containing this Resource Provider's available operations.")
model ResourceProviderOperationList
  is Azure.Core.Page<ResourceProviderOperationDefinition>;

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

@doc("""
Common error response for all Azure Resource Manager APIs to return error
details for failed operations. (This also follows the OData error response
format.).
""")
@error
model ErrorResponse {
  @doc("The error object.")
  error?: ErrorDetail;
}

@doc("The error detail.")
model ErrorDetail {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: ErrorDetail[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  @visibility("read")
  type?: string;

  @doc("The additional info.")
  @visibility("read")
  info?: unknown;
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

@doc("Confidential Ledger. Contains the properties of Confidential Ledger Resource.")
model ConfidentialLedger {
  ...TrackedResource;

  @doc("Properties of Confidential Ledger Resource.")
  properties?: LedgerProperties;
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

@doc("""
The resource model definition for an Azure Resource Manager tracked top level
resource which has 'tags' and a 'location'
""")
model TrackedResource {
  ...Resource;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  location: string;
}

@doc("""
Common fields that are returned in the response for all Azure Resource Manager
resources
""")
model Resource {
  @doc("""
Fully qualified resource ID for the resource. Ex -
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
""")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("""
The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or
\"Microsoft.Storage/storageAccounts\"
""")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("""
Object that includes an array of Confidential Ledgers and a possible link for
next set.
""")
model ConfidentialLedgerList is Azure.Core.Page<ConfidentialLedger>;

@doc("Managed CCF. Contains the properties of Managed CCF Resource.")
model ManagedCCF {
  ...TrackedResource;

  @doc("Properties of Managed CCF Resource.")
  properties?: ManagedCCFProperties;
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

@doc("Object that includes an array of Managed CCF and a possible link for next set.")
model ManagedCCFList is Azure.Core.Page<ManagedCCF>;

@doc("Tags for Managed CCF Certificates")
model CertificateTags {
  @doc("Additional tags for Managed CCF Certificates")
  tags?: Record<string>;
}
