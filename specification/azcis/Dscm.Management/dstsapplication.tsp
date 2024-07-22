import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("dstsApplication properties")
@removed(Versions.v2024_06_24_preview)
model DstsApplicationResourceProperties {
  @doc("Application.")
  applicationAccount?: ApplicationAccount;

  @doc("The application group. Optional.")
  applicationGroup?: ApplicationGroup;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: DscmProvisioningState;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-invalid-chars" "Arm resource name must contain only alphanumeric characters"
@removed(Versions.v2024_06_24_preview)
@doc("dstsApplication Resource")
model DstsApplicationResource
  is ProxyResource<DstsApplicationResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dstsApplications") // Start with lower case. Should be plural
  @visibility("read")
  @path
  name: string;
}

@doc("Application. Optional.")
@removed(Versions.v2024_06_24_preview)
model ApplicationAccount {
  @doc("The dSTS instance where the Application resides. Required.")
  dstsInstance: string;

  @doc("The name of the Application. Required.")
  applicationAccountName: string;

  @doc("The realms of the application. Optional.")
  realms?: Array<string>;

  @doc("The Service Principal Names of the application. Optional.")
  servicePrincipalNames?: Array<string>;

  @doc("The Reply Addresses of application. Optional.")
  replyToAddresses?: Array<string>;

  @doc("GUID of the dSCM Application group to which the Application belongs. Optional.")
  groupId?: string;

  @doc("Group name of the dSCM Application group to which the Application belongs. Optional.")
  groupName?: string;

  @doc("If set to true, authenticating to the application requires MFA. Optional.")
  isMfaEnabled?: boolean = true;

  @doc("If it is null, full SAW enforcement will apply to the application. Possible options are NoEnforcement, SAWFull, SAWElevatedOnly. Optional.")
  sawDeviceEnforcement?: string;

  @doc("If your application (service) is exclusively limited to System Metadata, Read-Only access levels, set it to false. Optional.")
  isElevatedAccess?: boolean;

  @doc("If your application (service) is exclusively NonProduction, set it to false. Optional.")
  isProduction?: boolean = true;

  @doc("The claim rule which apply to this Application. Optional.")
  @extension("x-ms-identifiers", [])
  claimRules?: Array<ApplicationClaimRule>;

  @doc("Client identity when using the application as a client. Optional.")
  applicationClientIdentity?: ApplicationClientIdentity;
}

@doc("The application group. Optional.")
@removed(Versions.v2024_06_24_preview)
model ApplicationGroup {
  @doc("Group id. Optional.")
  id?: string;

  @doc("Name of the Application Group. Required.")
  applicationGroupName: string;

  @doc("Common Name for all Applications inside the group. Required.")
  applicationName: string;

  @doc("The Service Principal Names of the application. Optional.")
  servicePrincipalNames?: Array<string>;

  @doc("Actor realm. Optional.")
  realms?: Array<string>;

  @doc("The Reply Addresses of application. Optional.")
  replyToAddresses?: Array<string>;

  @doc("If set to true, authenticating to the application requires MFA. Optional.")
  isMfaEnabled?: boolean = true;

  @doc("If not set, default is regional service. Optional.")
  isGlobalService?: boolean;

  @doc("If it is null, full SAW enforcement will apply to the application. Possible options are NoEnforcement, SAWFull, SAWElevatedOnly. Optional.")
  sawDeviceEnforcement?: string;

  @doc("Change.Remove client token ip range. Optional.")
  @extension("x-ms-identifiers", [])
  clientTokenIpRangeRestrictions?: Array<IpRange>;

  @doc("The cloud identifier for the application group. Possible options are PROD, blackforest, fairfax, mooncake. Required.")
  cloudId: string = "PROD";

  @doc("Client subscriptions. Optional.")
  clientSubscriptions?: Array<string>;

  @doc("Specific dSTS instances to create applications on. Optional.")
  regions?: Array<string>;

  @doc("The claim rules that apply to this Application Group. Optional.")
  @extension("x-ms-identifiers", [])
  claimRules?: Array<ApplicationClaimRule>;

  @doc("Client identity when using the application as a client. Optional.")
  applicationClientIdentity?: ApplicationClientIdentity;
}

@doc("The claim rule which apply to Application.")
@removed(Versions.v2024_06_24_preview)
model ApplicationClaimRule {
  @doc("A claim used to identify client. e.g., group claim, application name claim, object id claim.")
  clientIdentifier: Claim;

  @doc("The claim")
  claim: Claim;

  @doc("The name of the original identity provider of the client. e.g., federation for user or dsts instance for applications.")
  clientIdentityOrigin: string;

  @doc("If true, when the claim is scoped to service account group, only SCIs on the same dsts instance where the service accounts exist can get the claim.")
  isRegionalEnforced?: boolean = true;
}

@doc("A claim used to identify client. e.g., group claim, application name claim, object id claim.")
@removed(Versions.v2024_06_24_preview)
model Claim {
  @doc("Type of the claim")
  type: string;

  @doc("Value of claim")
  value: string;
}

@doc("Represents application client identity.")
@removed(Versions.v2024_06_24_preview)
model ApplicationClientIdentity {
  @doc("Dmsi client.")
  dmsiInfo?: DmsiInfo;

  @doc("Certificate client.")
  certificateBasedIdentity?: CertificateBasedIdentity;

  @doc("Subject name client.")
  subjectNameBasedIdentity?: SubjectNameBasedIdentity;

  @doc("The type of your client identity.e.g., Dmsi, Certificate, SubjectName.")
  type: string;

  @doc("Provide a list IP address ranges to restrict where this application's client token can be requested. Optional.")
  @extension("x-ms-identifiers", [])
  clientTokenIpRangeRestrictions?: Array<IpRange>;
}

@doc("Dmsi information")
@removed(Versions.v2024_06_24_preview)
model DmsiInfo {
  @doc("Dmsi path")
  path: string;

  @doc("Dmsi region")
  region: string;

  @doc("Dmsi subscriptions")
  subscriptions: Array<string>;
}

@doc("Represents certificate based authentication.")
@removed(Versions.v2024_06_24_preview)
model CertificateBasedIdentity {
  @doc("Certificate")
  @extension("x-ms-identifiers", [])
  certificates: Array<CertificateInfo>;
}

@doc("Certification based application client identity.")
@removed(Versions.v2024_06_24_preview)
model CertificateInfo {
  @doc("Certificate thumbprint information")
  thumbprint: string;

  @doc("Certificate expiry date")
  expiryDate: string;
}

@doc("Represents application subject name base identity.")
@removed(Versions.v2024_06_24_preview)
model SubjectNameBasedIdentity {
  @doc("List of subject names for sni based auth")
  subjectNames: Array<string>;
}

@doc("Class for a contiguous range of IP Addresses.")
@removed(Versions.v2024_06_24_preview)
model IpRange {
  @doc("From IP address.")
  fromIpAddress: string;

  @doc("To IP address.")
  toIpAddress: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
@removed(Versions.v2024_06_24_preview)
interface DstsApplications {
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "Fix on next update"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DstsApplicationResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  listBySubscription is ArmListBySubscription<DstsApplicationResource>;
  listByResourceGroup is ArmResourceListByParent<DstsApplicationResource>;
  get is ArmResourceRead<DstsApplicationResource>;
}

@@visibility(DstsApplicationResource.properties, "read", "create");
