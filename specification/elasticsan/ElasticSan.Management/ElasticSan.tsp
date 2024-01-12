import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  create is ArmResourceCreateOrUpdateAsync<
    ElasticSan,
    BaseParameters<ElasticSan>,
    ArmLroLocationHeader
  >;

  @doc("Update a Elastic San.")
  update is ArmCustomPatchAsync<
    ElasticSan,
    ElasticSanUpdate,
    BaseParameters<ElasticSan>,
    ArmLroLocationHeader
  >;

  @doc("Delete a Elastic San.")
  delete is ArmResourceDeleteAsync<
    ElasticSan,
    BaseParameters<ElasticSan>,
    ArmLroLocationHeader
  >;

  @doc("Gets a list of ElasticSan in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ElasticSan>;

  @doc("Gets a list of ElasticSans in a subscription")
  listBySubscription is ArmListBySubscription<ElasticSan>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListByElasticSan")
  @doc("Gets the private link resources that need to be created for a elastic San.")
  // FIXME: PrivateLinkResources_ListByElasticSan could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ElasticSan/elasticSans/{elasticSanName}/privateLinkResources")
  @get
  listByElasticSan is Azure.Core.Foundations.Operation<
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

@@projectedName(ElasticSans.create::parameters.resource, "json", "parameters");
@@extension(ElasticSans.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ElasticSans.create::parameters.resource, "Elastic San object.");
@@projectedName(ElasticSans.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ElasticSans.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ElasticSans.update::parameters.properties, "Elastic San object.");
