import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ElasticSan;
@doc("Response for ElasticSan request.")
model ElasticSan is TrackedResource<ElasticSanProperties> {
  @doc("The name of the ElasticSan.")
  @maxLength(24)
  @minLength(3)
  @pattern("^[A-Za-z0-9]+((-|_)[a-z0-9A-Z]+)*$")
  @path
  @key("elasticSanName")
  @segment("elasticSans")
  name: string;
}

@armResourceOperations
interface ElasticSans {
  @doc("Get a ElasticSan.")
  get is ArmResourceRead<ElasticSan>;
  @doc("Create ElasticSan.")
  create is ArmResourceCreateOrUpdateAsync<ElasticSan>;
  @doc("Update a Elastic San.")
  update is ArmResourcePatchAsync<ElasticSan, ElasticSanProperties>;
  @doc("Delete a Elastic San.")
  delete is ArmResourceDeleteAsync<ElasticSan>;
  @doc("Gets a list of ElasticSan in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ElasticSan>;
  @doc("Gets a list of ElasticSans in a subscription")
  listBySubscription is ArmListBySubscription<ElasticSan>;
  @doc("Gets the private link resources that need to be created for a elastic San.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/privateLinkResources")
  @get
  ListByElasticSan is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the ElasticSan.")
      @maxLength(24)
      @minLength(3)
      @pattern("^[A-Za-z0-9]+((-|_)[a-z0-9A-Z]+)*$")
      @path
      elasticSanName: string;
    },
    PrivateLinkResourceListResult
  >;
}
