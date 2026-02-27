import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.AzureCis;

@added(Versions.v2024_06_24_preview)
@doc("DstsServiceAccountGroup properties")
model DstsServiceAccountGroupResourceProperties {
  @doc("Service Account Group name. Case-insensitive.")
  groupName: string;

  @doc("This property is used to enable auto-creation of service accounts in all regions. By default no service accounts are created.")
  serviceAvailabilityStrategy: ServiceAvailabilityStrategy;

  @doc("Desired naming pattern of the accounts in this group.")
  accountName?: string;

  @doc("Display name.")
  displayName?: string;

  @doc("List of realms.")
  realms?: Array<DstsRealm>;

  @doc("List of claim mappings.")
  @Azure.ResourceManager.identifiers(#[])
  claimMappings?: Array<GroupClaimMapping>;

  @doc("List of container claim mappings.")
  @Azure.ResourceManager.identifiers(#[])
  containerClaimMappings?: Array<GroupClaimMapping>;

  @doc("List of authentication requirements.")
  @Azure.ResourceManager.identifiers(#[])
  authenticationRequirements?: Array<AuthenticationRequirement>;

  @doc("The cloud ID where the Service Account Group should be added.")
  cloudId?: CloudId;

  @doc("Allowed actor ids.")
  allowedActorIds?: Array<string>;

  @doc("JIT resource type.")
  jitResourceType?: string;

  @doc("Account version.")
  accountVersion?: string;

  @doc("Create Jit dSTS controlled resource with service account group.")
  dstsControlledResource?: DstsControlledResource;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: DscmProvisioningState;

  @doc("Request ID; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  requestId?: string;
}

@added(Versions.v2024_06_24_preview)
@doc("Represents a controlled resource in a JIT policy.")
model DstsControlledResource {
  @doc("Defines if the resource should be created.")
  createNewResource: boolean;

  @doc("The type of the resource.")
  resourceType: string;

  @doc("A list of IDs of the services that own the resource.")
  owningServiceIds: Array<string>;

  @doc("A list of access levels for the resource.")
  accessLevels: Array<JitAccessLevel>;

  @doc("A list of IDs of the containers that the resource is allowed to be created in.")
  dstsContainerIds: Array<string>;
}

@added(Versions.v2024_06_24_preview)
@doc("This model represents a claim mapping for authorization.")
model GroupClaimMapping {
  @doc("The input claim.")
  inputClaim: Claim;

  @doc("The output claim.")
  outputClaim: Claim;

  @doc("The federation context for the mapping. E.g. 'MSIT-ADFS-Federation' or 'BF-ADFS-Federation'.")
  federation: string;
}

@added(Versions.v2024_06_24_preview)
@doc("Represents a JIT access level.")
model JitAccessLevel {
  @doc("The name of the access level.")
  name: string;

  @doc("The type of the access policy.")
  accessPolicyType: string;
}

@added(Versions.v2024_06_24_preview)
@doc("Service availability strategy.")
union ServiceAvailabilityStrategy {
  @doc("Create service accounts in all regions.")
  Regional: "Regional",

  @doc("Create service accounts in user specified regions.")
  UserSpecifiedRegions: "UserSpecifiedRegions",

  string,
}

@added(Versions.v2024_06_24_preview)
@doc("DstsServiceAccountGroup Resource")
model DstsServiceAccountGroupResource
  is ProxyResource<DstsServiceAccountGroupResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]*$")
  @minLength(3)
  @maxLength(80)
  @key("resourceName")
  @segment("dstsServiceAccountGroups")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Delete operation is currently not supported by FRP."
@added(Versions.v2024_06_24_preview)
@armResourceOperations
interface DstsServiceAccountGroup {
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "Fix on next update"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DstsServiceAccountGroupResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  listBySubscription is ArmListBySubscription<DstsServiceAccountGroupResource>;
  listByResourceGroup is ArmResourceListByParent<DstsServiceAccountGroupResource>;
  get is ArmResourceRead<DstsServiceAccountGroupResource>;
}

@@visibility(DstsServiceAccountGroupResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
