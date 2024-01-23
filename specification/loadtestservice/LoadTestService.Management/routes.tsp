import "./models.tsp";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;
using Autorest;
using Azure.ResourceManager.Foundations;
namespace Microsoft.LoadTestService.Draft;

interface Operations extends Azure.ResourceManager.Operations {}

// adding a custom operation since we want to override body parameter name to body
/**
 * A long-running resource CreateOrUpdate (PUT)
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
@autoRoute
@doc("Create a {name}", TResource)
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "azure-async-operation",
  }
)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrUpdateAsyncCustom<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @body
  body: TResource,
): ArmResourceUpdatedResponse<TResource> | ArmResourceCreatedResponse<TResource> | ErrorResponse;

// adding a custom operation since we want to override body parameter name to QuotaBucketRequest
#suppress "@azure-tools/typespec-azure-core/casing-style" "QuotaBucketRequest is already published"
/**
 * A synchronous resource action.
 * @template TResource The resource being acted upon
 * @template TRequest The request model for the action
 * @template TResponse The response model for the action
 * @template TBaseParameters Optional. Allows overriding the parameters for the operation
 */
@autoRoute
@armResourceAction(TResource)
@post
@returnsDoc("ARM operation completed successfully.")
op ArmResourceActionSyncCustom<
  TResource extends ArmResource,
  TRequest extends TypeSpec.Reflection.Model | void,
  TResponse extends TypeSpec.Reflection.Model | void,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("The content of the action request")
  @body
  QuotaBucketRequest: TRequest,
): TResponse | ErrorResponse;

@armResourceOperations
interface LoadTests {
  listBySubscription is ArmListBySubscription<LoadTestResource>;
  listByResourceGroup is ArmResourceListByParent<LoadTestResource>;
  get is ArmResourceRead<LoadTestResource>; 
  createOrUpdate is ArmResourceCreateOrUpdateAsyncCustom<LoadTestResource>;
  update is ArmResourcePatchAsync<LoadTestResource, LoadTestProperties>;
  delete is ArmResourceDeleteAsync<LoadTestResource>;
  
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "OperationId in already published GA spec is different from the auto generated one"
  @operationId("LoadTests_ListOutboundNetworkDependenciesEndpoints")
  outboundNetworkDependenciesEndpoint is ArmResourceListByParent<OutboundEnvironmentEndpoint>;
}

@armResourceOperations
interface Quotas {
  @doc("Get the available quota for a quota bucket per region per subscription.")
  get is ArmResourceRead<QuotaResource>;

  @doc("List quotas for a given subscription Id.")
  listBySubscription is ArmListBySubscription<QuotaResource>;

  @doc("Check Quota Availability on quota bucket per region per subscription.")
  checkAvailability is ArmResourceActionSyncCustom<QuotaResource, QuotaBucketRequest, CheckQuotaAvailabilityResponse>;

  // @TypeSpec.Rest.autoRoute
  // @armProviderNameValue
  // @doc("Implements global CheckNameAvailability operations")
  // @TypeSpec.Rest.action("checkAvailability")
  // @post
  // op checkAvailability(
  //   ...SubscriptionIdParameter,
  //   ...LocationParameter,
  //   @body QuotaBucketRequest: QuotaBucketRequest
  // ) : CheckQuotaAvailabilityResponse | ErrorResponse;

  // @TypeSpec.Rest.autoRoute
  // @armProviderNameValue
  // @doc("Implements global CheckNameAvailability operations")
  // @TypeSpec.Rest.action("checkAvailability3")
  // @post
  // op checkAvailability3<
  //   TScopeParameters extends TypeSpec.Reflection.Model,
  //   TRequest extends TypeSpec.Reflection.Model = Azure.ResourceManager.Foundations.CheckNameAvailabilityRequest,
  //   TResponse extends TypeSpec.Reflection.Model = {},
  //   TAdditionalParams extends TypeSpec.Reflection.Model = {}
  // >(
  //   @path subscriptionId: SubscriptionIdParameter,
  //   @path location: LocationParameter,
  //   @path quotaBucketName: string,
  //   @query `api-version`: ApiVersionParameter
  // ) : CheckQuotaAvailabilityResponse | ErrorResponse;

  // @TypeSpec.Rest.autoRoute
  // @armProviderNameValue
  // @doc("Implements global CheckNameAvailability operations")
  // @TypeSpec.Rest.action("checkNameAvailability")
  // @post
  // op checkNameAvailability<
  //   TScopeParameters extends TypeSpec.Reflection.Model,
  //   TRequest extends TypeSpec.Reflection.Model = Azure.ResourceManager.Foundations.CheckNameAvailabilityRequest,
  //   TResponse extends TypeSpec.Reflection.Model = CheckNameAvailabilityResponse,
  //   TAdditionalParams extends TypeSpec.Reflection.Model = {}
  // >(
  //   ...ApiVersionParameter,
  //   ...TScopeParameters,
  //   ...TAdditionalParams,

  //   @doc("The CheckAvailability request")
  //   @body
  //   body: TRequest,
  // ): TResponse | ErrorResponse;
}