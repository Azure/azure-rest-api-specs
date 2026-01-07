import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style" "Using the AI acronym similar to what was done for OpenAI"
@armProviderNamespace("Microsoft.HealthDataAIServices")
@service(#{ title: "Microsoft.HealthDataAIServices" })
@versioned(Microsoft.HealthDataAIServices.Versions)
namespace Microsoft.HealthDataAIServices;

@doc("Supported API versions for the Microsoft.HealthDataAIServices resource provider.")
enum Versions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("The 2023-06-01-preview version.")
  v2023_06_01_preview: "2023-06-01-preview",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("The 2024-02-28-preview version.")
  v2024_02_28_preview: "2024-02-28-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
#suppress "@azure-tools/typespec-azure-core/casing-style" "Case-sensitive name"
@doc("A HealthDataAIServicesProviderHub resource")
model DeidService is TrackedResource<DeidServiceProperties> {
  @doc("The name of the deid service")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("deidServiceName")
  @segment("deidServices")
  @path
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Adding property for versioning"
  @added(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
  @doc("The managed service identities assigned to this resource.")
  identity?: Azure.ResourceManager.Foundations.ManagedIdentityProperties;
}

/** Patch request body for DeidService */
@added(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
model DeidUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** Updatable managed service identity */
  identity?: ManagedServiceIdentityUpdate;

  /** RP-specific properties */
  properties?: DeidPropertiesUpdate;
}

@added(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
model DeidPropertiesUpdate
  is OptionalProperties<UpdateableProperties<DeidServiceProperties>>;

@added(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
model ManagedServiceIdentityUpdate
  is OptionalProperties<UpdateableProperties<Azure.ResourceManager.Foundations.ManagedIdentityProperties>>;

#suppress "@azure-tools/typespec-azure-core/no-enum" "Suppress the warning for using enum keyword."
@Azure.Core.lroStatus
@doc("The status of the current operation.")
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The resource is provisioning")
  Provisioning,

  @doc("The resource is updating")
  Updating,

  @doc("The resource is deleting")
  Deleting,

  @doc("The resource is accepted")
  Accepted,
}

#suppress "@azure-tools/typespec-azure-core/no-enum" "Suppress the warning for using enum keyword."
@added(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
@doc("State of the public network access.")
enum PublicNetworkAccess {
  @doc("The public network access is enabled")
  Enabled,

  @doc("The public network access is disabled")
  Disabled,
}

@doc("Details of the HealthDataAIServices DeidService.")
model DeidServiceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("Deid service url.")
  serviceUrl?: string;

  @doc("List of private endpoint connections.")
  @visibility(Lifecycle.Read)
  @added(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("Gets or sets allow or disallow public network access to resource")
  @added(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
  publicNetworkAccess?: PublicNetworkAccess;
}

@armResourceOperations
interface DeidServices {
  get is ArmResourceRead<DeidService>;
  listByResourceGroup is ArmResourceListByParent<DeidService>;
  listBySubscription is ArmListBySubscription<DeidService>;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  #suppress "deprecated" "Avoid breaking change"
  @sharedRoute
  @removed(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
  @renamedFrom(
    Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview,
    "create"
  )
  createSync is ArmResourceCreateOrUpdateSync<DeidService>;

  @sharedRoute
  @added(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
  create is ArmResourceCreateOrUpdateAsync<DeidService>;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @sharedRoute
  @removed(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
  @renamedFrom(
    Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview,
    "update"
  )
  updateSync is ArmResourcePatchSync<DeidService, DeidServiceProperties>;

  @sharedRoute
  @added(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
  update is ArmCustomPatchAsync<DeidService, DeidUpdate>;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @sharedRoute
  @removed(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
  @renamedFrom(
    Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview,
    "delete"
  )
  deleteSync is ArmResourceDeleteSync<DeidService>;

  @sharedRoute
  @added(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
  delete is ArmResourceDeleteWithoutOkAsync<DeidService>;
}

/** Holder for private endpoint connections */
@added(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
@parentResource(DeidService)
model PrivateEndpointConnectionResource
  is ProxyResource<PrivateEndpointConnectionProperties> {
  ...PrivateEndpointConnectionParameter;
}

/** Private connection operations */
@added(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
@armResourceOperations(PrivateEndpointConnectionResource)
interface PrivateEndpointConnections {
  /** Get a specific private connection */
  get is ArmResourceRead<PrivateEndpointConnectionResource>;
  /** Create a Private endpoint connection */
  create is ArmResourceCreateOrReplaceAsync<PrivateEndpointConnectionResource>;
  /** Delete the private endpoint connection */
  delete is ArmResourceDeleteWithoutOkAsync<PrivateEndpointConnectionResource>;
  /** List private endpoint connections on the given resource */
  list is ArmResourceListByParent<PrivateEndpointConnectionResource>;
}

/** Private Links for DeidService resource */
#suppress "@azure-tools/typespec-providerhub-controller/no-resource-operations" "Expected for private links"
@added(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
@parentResource(DeidService)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  ...PrivateLinkResourceParameter;
}

/** Operations for private links on DeidService resource */
@added(Microsoft.HealthDataAIServices.Versions.v2024_02_28_preview)
@armResourceOperations(PrivateLinkResource)
interface PrivateLinks {
  /** List private links on the given resource */
  list is ArmResourceListByParent<PrivateLinkResource>;
}
