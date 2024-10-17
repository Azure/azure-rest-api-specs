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
@service({
  title: "Microsoft.HealthDataAIServices",
})
@versioned(Microsoft.HealthDataAIServices.Versions)
namespace Microsoft.HealthDataAIServices;

@doc("Supported API versions for the Microsoft.HealthDataAIServices resource provider.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("The 2024-02-28-preview version.")
  v2024_02_28_preview: "2024-02-28-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("The 2024-09-20 version.")
  v2024_09_20: "2024-09-20",
}

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
#suppress "@azure-tools/typespec-azure-core/casing-style" "Case-sensitive name"
#suppress "deprecated" "Workaround for Typespec bug https://github.com/Azure/typespec-azure/issues/383"
@doc("A HealthDataAIServicesProviderHub resource")
model DeidService is TrackedResource<DeidServiceProperties> {
  @doc("The name of the deid service")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("deidServiceName")
  @segment("deidServices")
  @path
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Adding property for versioning"
  @doc("The managed service identities assigned to this resource.")
  identity?: Azure.ResourceManager.Foundations.ManagedIdentityProperties;
}

/** Patch request body for DeidService */
model DeidUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** Updatable managed service identity */
  identity?: ManagedServiceIdentityUpdate;

  /** RP-specific properties */
  properties?: DeidPropertiesUpdate;
}

model DeidPropertiesUpdate
  is OptionalProperties<UpdateableProperties<DeidServiceProperties>>;

#suppress "deprecated" "Workaround for Typespec bug https://github.com/Azure/typespec-azure/issues/383"
model ManagedServiceIdentityUpdate
  is OptionalProperties<UpdateableProperties<Azure.ResourceManager.Foundations.ManagedIdentityProperties>>;

#suppress "@azure-tools/typespec-azure-core/no-enum" "Suppress the warning for using enum keyword."
@Azure.Core.lroStatus
@doc("The status of the current operation.")
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned. */
  Provisioning: "Provisioning",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The resource provisioning request has been accepted. */
  Accepted: "Accepted",

  string,
}

#suppress "@azure-tools/typespec-azure-core/no-enum" "Suppress the warning for using enum keyword."
@doc("State of the public network access.")
enum PublicNetworkAccess {
  @doc("The public network access is enabled")
  Enabled,

  @doc("The public network access is disabled")
  Disabled,
}

@doc("Details of the HealthDataAIServices DeidService.")
model DeidServiceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("Deid service url.")
  serviceUrl?: string;

  @doc("List of private endpoint connections.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("Gets or sets allow or disallow public network access to resource")
  publicNetworkAccess?: PublicNetworkAccess;
}

@armResourceOperations
interface DeidServices {
  get is ArmResourceRead<DeidService>;
  listByResourceGroup is ArmResourceListByParent<DeidService>;
  listBySubscription is ArmListBySubscription<DeidService>;
  create is ArmResourceCreateOrUpdateAsync<DeidService>;
  update is ArmCustomPatchAsync<DeidService, DeidUpdate>;
  delete is ArmResourceDeleteWithoutOkAsync<DeidService>;
}

/** Holder for private endpoint connections */
@parentResource(DeidService)
model PrivateEndpointConnectionResource
  is ProxyResource<PrivateEndpointConnectionProperties> {
  ...PrivateEndpointConnectionParameter;
}

/** Private connection operations */
@armResourceOperations(PrivateEndpointConnectionResource)
interface PrivateEndpointConnections {
  /** Get a specific private connection */
  get is ArmResourceRead<PrivateEndpointConnectionResource>;
  /** Create a Private endpoint connection */
  create is ArmResourceCreateOrReplaceAsync<PrivateEndpointConnectionResource>;
  /** Delete the private endpoint connection */
  delete is ArmResourceDeleteWithoutOkAsync<PrivateEndpointConnectionResource>;
  /** List private endpoint connections on the given resource */
  listByDeidService is ArmResourceListByParent<PrivateEndpointConnectionResource>;
}

/** Private Links for DeidService resource */
#suppress "@azure-tools/typespec-providerhub-controller/no-resource-operations" "Expected for private links"
@parentResource(DeidService)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  ...PrivateLinkResourceParameter;
}

/** Operations for private links on DeidService resource */
@armResourceOperations(PrivateLinkResource)
interface PrivateLinks {
  /** List private links on the given resource */
  listByDeidService is ArmResourceListByParent<PrivateLinkResource>;
}
