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

@armResourceOperations
interface LoadTests {
  listBySubscription is ArmListBySubscription<LoadTestResource>;
  listByResourceGroup is ArmResourceListByParent<LoadTestResource>;
  get is ArmResourceRead<LoadTestResource>; 
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LoadTestResource>;
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
  checkAvailability is ArmResourceActionSync<QuotaResource, QuotaBucketRequest, CheckQuotaAvailabilityResponse>;

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