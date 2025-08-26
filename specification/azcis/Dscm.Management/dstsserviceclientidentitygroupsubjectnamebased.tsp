import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.AzureCis;

@doc("DSTS service client identity (SCI) group, which is subjectName based.")
model DstsServiceClientIdentityGroupSubjectNameBasedResourceProperties {
  @doc("List of common subject names for the service client identity group. Client identification is based on the combination of the Subject Name and Issuer of the certificate. For groups, the CommonSubjectNames can be explicitly specified. When creating a SubjectName-Based SCI Group and subsequently creating SCIs, the subject names associated with the group automatically appear in the SCI. Optional.")
  commonSubjectNames?: Array<string>;

  @doc("The service client identity group name. The name cannot collide with the name of another service client identity group or another service account group at the same dSTS instance. Please follow dSTS guideline for naming convention. Required.")
  groupName: string;

  @doc("Common service client identity name. If set, all Service Client Identities (SCIs) belonging to this group will have the same name (as set by this field). Optional.")
  commonServiceClientIdentityName?: string;

  @doc("List of claim provisionings for the service client identity group. This describes how the client identity is authorized. ClaimProvisionings included in an SCI group can specify scope to a service account group. With this, your claim can be manually or automatically (depending on autoapproval permissions) approved by the owning team of the service account for the first time, and later new SCI instance in the same SCI group will have the claim added by default. Optional.")
  @Azure.ResourceManager.identifiers(#[])
  listOfClaimProvisioningsForGroup?: Array<ClaimProvisioningsForGroup>;

  @doc("List of common certificates for the service client identity group. Optional.")
  @Azure.ResourceManager.identifiers(#[])
  commonCertificates?: Array<CertificateInfo>;

  @doc("List of common authentication requirements for the service client identity group. Optional.")
  @Azure.ResourceManager.identifiers(#[])
  commonAuthenticationRequirements?: Array<AuthenticationRequirement>;

  @doc("Cloud identifier for the service client identity group. Optional.")
  cloudId?: CloudId;

  @doc("Account version for the service client identity group. Optional.")
  accountVersion?: string;

  @doc("List of claim expansions for the service client identity group. Optional.")
  @Azure.ResourceManager.identifiers(#[])
  claimExpansions?: Array<ClaimExpansion>;

  @doc("List of dSTS instances for the service client identity group. A list contains specific dSTS instances to create identities on. Optional.")
  dstsInstances?: Array<string>;

  @doc("List of member SCI ids to enforce group properties on. Each ServiceClientIdentityId element should contain a valid guid. Optional.")
  enforceServiceClientIdentityIds?: Array<string>;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: DscmProvisioningState;

  @doc("Request ID; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  requestId?: string;
}

@doc("DstsServiceClientIdentityGroupSubjectNameBased Resource")
model DstsServiceClientIdentityGroupSubjectNameBasedResource
  is ProxyResource<DstsServiceClientIdentityGroupSubjectNameBasedResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dstsServiceClientIdentityGroupSubjectNameBaseds") // Start with lower case. Should be plural
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DstsServiceClientIdentityGroupSubjectNameBased {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DstsServiceClientIdentityGroupSubjectNameBasedResource>;
  get is ArmResourceRead<DstsServiceClientIdentityGroupSubjectNameBasedResource>;
  listByResourceGroup is ArmResourceListByParent<DstsServiceClientIdentityGroupSubjectNameBasedResource>;
  listBySubscription is ArmListBySubscription<DstsServiceClientIdentityGroupSubjectNameBasedResource>;
}
