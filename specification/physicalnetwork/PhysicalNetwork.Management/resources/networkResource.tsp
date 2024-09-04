import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/networkResource.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

/** Microsoft.PhysicalNetwork Resource Provider management API. */
@armProviderNamespace
@service({
  title: "Microsoft.PhysicalNetwork management service",
})
@versioned(Versions)
namespace Microsoft.PhysicalNetwork;

enum Versions {
  /** 2024-06-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01_preview: "2024-06-01-preview",
}

alias resourceNameRegex = "^[a-zA-Z0-9][a-zA-Z0-9-._]{1,58}[a-zA-Z0-9]$";

model NetworkDeviceResource
  is Azure.ResourceManager.ProxyResource<NetworkDeviceProperties> {
  /** The network device's name, same as Hostname. */
  @key("deviceName")
  @segment("networkDevices")
  @path
  @pattern(resourceNameRegex)
  name: string;
}

@armResourceOperations
interface NetworkDevices {
  get is ArmLocResourceRead<NetworkDeviceResource>;
  list is ArmLocResourceListByParent<NetworkDeviceResource>;
}

model LocationInstanceParameters<T extends Azure.ResourceManager.Foundations.Resource> {
  ...ApiVersionParameter;
  ...ProviderNamespace<T>;
  ...LocationParameter;
  ...KeysOf<T>;
}
model LocationCollectionParameters<T extends Azure.ResourceManager.Foundations.Resource> {
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
@doc("List {name}s by location", TResource)
@get
@listsResource(TResource)
@segmentOf(TResource)
@armResourceList(TResource)
op ArmLocResourceListByParent<
  TResource extends Azure.ResourceManager.Foundations.Resource,
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
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...LocationInstanceParameters<TResource>,
): ArmResponse<TResource> | ErrorResponse;
