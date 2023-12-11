import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

interface Operations extends Azure.ResourceManager.Operations {}

model LocationInstanceParameters<T extends ArmResource> {
  ...ApiVersionParameter;
  ...ProviderNamespace<T>;
  ...LocationParameter;
  ...KeysOf<T>;
}
model LocationCollectionParameters<T extends ArmResource> {
  ...ApiVersionParameter;
  ...ProviderNamespace<T>;
  ...LocationParameter;
  ...ParentKeysOf<T>;
}

/**
 * A resource list operation, at the scope of the resource's parent
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 * @template TParentName Optional. The name of the parent resource
 * @template TParentFriendlyName Optional. The friendly name of the parent resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "All operations are inside an interface"
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid casing"
@autoRoute
@get
@listsResource(TResource)
@segmentOf(TResource)
@armRenameListByOperation(TResource, TParentName, TParentFriendlyName) // This must come before @armResourceList!
@armResourceList(TResource)
op ArmLocResourceListByParent<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>,
  TParentName extends valueof string = "",
  TParentFriendlyName extends valueof string = ""
>(
  ...LocationCollectionParameters<TResource>,
): ArmResponse<ResourceListResult<TResource>> | ErrorResponse;

/// Templates
/**
 * A resource GET operation
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
/// #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "This is a valid template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "All operations are inside an interface"
@autoRoute
@doc("Get a {name}", TResource)
@get
@armResourceRead(TResource)
op ArmLocResourceRead<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...LocationInstanceParameters<TResource>,
): ArmResponse<TResource> | ErrorResponse;
