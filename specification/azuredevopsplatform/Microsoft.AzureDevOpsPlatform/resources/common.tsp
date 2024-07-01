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

namespace Microsoft.AzureDevOpsPlatform;

model LocationInstanceParameters<T extends Foundations.Resource> {
  ...ApiVersionParameter;
  ...ProviderNamespace<T>;
  ...LocationParameter;
  ...KeysOf<T>;
}
model LocationCollectionParameters<T extends Foundations.Resource> {
  ...ApiVersionParameter;
  ...ProviderNamespace<T>;
  ...LocationParameter;
  ...ParentKeysOf<T>;
}

@armResourceOperations
interface ArmLocResources {
  /**
   * A resource list operation, at the scope of the resource's parent
   * @template TResource the resource being patched
   * @template TBaseParameters Optional. Allows overriding the operation parameters
   * @template TParentName Optional. The name of the parent resource
   * @template TParentFriendlyName Optional. The friendly name of the parent resource
   */
  @autoRoute
  @get
  @listsResource(TResource)
  @segmentOf(TResource)
  @armResourceList(TResource)
  ArmLocResourceListByParent<
    TResource extends Foundations.Resource,
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
  @autoRoute
  @doc("Get a {name}", TResource)
  @get
  @armResourceRead(TResource)
  ArmLocResourceRead<
    TResource extends Foundations.Resource,
    TBaseParameters = BaseParameters<TResource>
  >(
    ...LocationInstanceParameters<TResource>,
  ): ArmResponse<TResource> | ErrorResponse;
}
