import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataFactory;
@doc("Dataset resource type.")
@parentResource(Factory)
model DatasetResource is ProxyResource<Dataset> {
  @doc("The dataset name.")
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @key("datasetName")
  @segment("datasets")
  name: string;
}

@armResourceOperations
@projectedName("client", "Datasets")
interface DatasetResources_Datasets {
  @doc("Gets a dataset.")
  get is ArmResourceRead<
    DatasetResource,
    {
      ...BaseParameters<DatasetResource>;

      @doc("ETag of the dataset entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;

  @doc("Creates or updates a dataset.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DatasetResource,
    {
      ...BaseParameters<DatasetResource>;

      @doc("ETag of the dataset entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;

  @doc("Deletes a dataset.")
  delete is ArmResourceDeleteSync<DatasetResource>;

  @doc("Lists datasets.")
  listByFactory is ArmResourceListByParent<DatasetResource>;
}
