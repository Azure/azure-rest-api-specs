using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

using Azure.ResourceManager.Foundations;

namespace Oracle.Database;

@armResourceOperations(T)
interface OracleSubscriptionLevelResource<
  T extends Foundations.Resource,
  TProperties extends TypeSpec.Reflection.Model
>
  extends ResourceListBySubscription<T>,
    ResourceCreateAsync<T>,
    ResourceRead<T>,
    ResourceUpdateAsync<T, TProperties>,
    ResourceDeleteWithoutOkAsync<T> {}

@armResourceOperations(T)
interface OracleTrackedResource<
  T extends Foundations.Resource,
  TProperties extends TypeSpec.Reflection.Model
> extends OracleSubscriptionLevelResource<T, TProperties> {
  listByResourceGroup is ArmResourceListByParent<T>;
}

@armResourceOperations(T)
interface OracleReadOnlyResource<T extends Foundations.Resource> {
  // TODO: Swagger generator bug, cannot be extracted to interface
  // listByParent is ArmResourceListByParent<T>;
  get is ArmResourceRead<T>;
}

@armResourceOperations(T)
interface OracleLocationBasedResource<T extends Foundations.Resource>
  extends OracleReadOnlyResource<T> {
  listByLocation is ArmResourceListByParent<T>;
}

@armResourceOperations(T)
interface OracleChildResource<
  T extends Foundations.Resource,
  TProperties extends TypeSpec.Reflection.Model
>
  extends ResourceCreateAsync<T>,
    ResourceRead<T>,
    ResourceDeleteWithoutOkAsync<T> {}

@armResourceOperations
interface ListActions {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO - Migrate to LRO pattern"
  @doc("Generic Async Get operation")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "location" }
  )
  @autoRoute
  @armResourceAction(TResource)
  @post
  ArmResourceGetActionAsync<
    TResource extends Foundations.Resource,
    TResponse extends {} | void,
    TBaseParameters = BaseParameters<TResource>
  >(
    ...ResourceInstanceParameters<TResource, TBaseParameters>,
  ): ArmResponse<TResponse> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = TResponse> &
    Azure.Core.Foundations.RetryAfterHeader> | ErrorResponse;
}
