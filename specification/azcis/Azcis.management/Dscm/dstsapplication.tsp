import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("dstsApplication properties")
model DstsApplicationResourceProperties {
  @doc("Application.")
  applicationAccount: ApplicationAccount;

  @doc("The application group. Optional.")
  applicationGroup?: ApplicationGroup;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: DscmProvisioningState;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-invalid-chars" "Arm resource name must contain only alphanumeric characters"
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

@doc("Application.")
model ApplicationAccount {
  @doc("The dSTS instance where the Application resides.")
  dstsInstance: string;

  @doc("The name of the Application.")
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

  @doc("If it is null, full SAW enforcement will apply to the application. Optional.")
  sawDeviceEnforcement?: string;

  @doc("If you application (service) is exclusively limited to System Metadata, Read-Only access levels, set it to false. Optional.")
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
model ApplicationGroup {
  @doc("Group id.")
  id?: string;

  @doc("Name of the Application Group.")
  applicationGroupName: string;

  @doc("Common Name for all Applications inside the group.")
  applicationName?: string;

  @doc("The Service Principal Names of the application. Optional.")
  servicePrincipalNames?: Array<string>;

  @doc("Actor realm.")
  realms?: Array<string>;

  @doc("The Reply Addresses of application. Optional.")
  replyToAddresses?: Array<string>;

  @doc("If set to true, authenticating to the application requires MFA. Optional.")
  isMfaEnabled?: boolean = true;

  @doc("If not set, default is regional service. Optional.")
  isGlobalService?: boolean;

  @doc("If it is null, full SAW enforcement will apply to the application. Optional.")
  sawDeviceEnforcement?: string;

  @doc("Change.Remove client token ip range.")
  @extension("x-ms-identifiers", [])
  clientTokenIpRangeRestrictions?: Array<IpRange>;

  @doc("Optional. If it is null, full SAW enforcement will apply to the application.")
  cloudId: string = "PROD";

  @doc("Optional.client subscriptions.")
  clientSubscriptions?: Array<string>;

  @doc("Specific dSTS instances to create applications on.")
  regions?: Array<string>;

  @doc("The claim rules that apply to this Application Group. Optional.")
  @extension("x-ms-identifiers", [])
  claimRules?: Array<ApplicationClaimRule>;

  @doc("Client identity when using the application as a client. Optional.")
  applicationClientIdentity?: ApplicationClientIdentity;
}

@doc("The claim rule which apply to Application.")
model ApplicationClaimRule {
  @doc("A claim used to identifiy client. e.g., group claim, application name claim, object id claim.")
  clientIdentifier: Claim;

  @doc("The claim")
  claim: Claim;

  @doc("The name of the original identity provider of the client. e.g., federation for user or dsts instance for applications.")
  clientIdentityOrigin: string;

  @doc("If true, when the claim is scoped to service account group, only SCIs on the same dsts instance where the service accounts exist can get the claim.")
  isRegionalEnforced?: boolean = true;
}

@doc("A claim used to identifiy client. e.g., group claim, application name claim, object id claim.")
model Claim {
  @doc("Type of the claim")
  type: string;

  @doc("Value of claim")
  value: string;
}

@doc("Represents application client identity.")
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

@doc("DMSI information")
model DmsiInfo {
  @doc("DMSI path")
  path: string;

  @doc("DMSI region")
  region: string;

  @doc("DMSI subscriptions")
  subscriptions: Array<string>;
}

@doc("Represents certificate based authentication.")
model CertificateBasedIdentity {
  @doc("Certificate")
  @extension("x-ms-identifiers", [])
  certificates: Array<CertificateInfo>;
}

@doc("Certification based application client identity.")
model CertificateInfo {
  @doc("Certificate thumbprint information")
  thumbprint: string;

  @doc("Certificate expiry date")
  expiryDate: string;
}

@doc("Represents application subject name base identity.")
model SubjectNameBasedIdentity {
  @doc("List of subject names for sni based auth")
  subjectNames: Array<string>;
}

@doc("Class for a contiguous range of IP Addresses.")
model IpRange {
  @doc("From IP address.")
  fromIpAddress: string;

  @doc("To IP address.")
  toIpAddress: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DstsApplication {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DstsApplicationResource>;
  listBySubscription is ArmListBySubscription<DstsApplicationResource>;
  listByResourceGroup is ArmResourceListByParent<DstsApplicationResource>;
  get is ArmResourceRead<DstsApplicationResource>;
}
