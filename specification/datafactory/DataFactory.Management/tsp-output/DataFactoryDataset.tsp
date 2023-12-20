import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataFactory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataFactory;
@doc("Dataset resource type.")
@parentResource(DataFactory)
model DataFactoryDataset is ProxyResource<Dataset> {
  @doc("The dataset name.")
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @path
  @key("datasetName")
  @segment("datasets")
  name: string;
}

@armResourceOperations
interface DataFactoryDatasets {
  @doc("Gets a dataset.")
  get is ArmResourceRead<
    DataFactoryDataset,
    {
      ...BaseParameters<DataFactoryDataset>;

      @doc("ETag of the dataset entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Creates or updates a dataset.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DataFactoryDataset,
    {
      ...BaseParameters<DataFactoryDataset>;

      @doc("ETag of the dataset entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes a dataset.")
  delete is ArmResourceDeleteSync<DataFactoryDataset>;
  @doc("Lists datasets.")
  listByFactory is ArmResourceListByParent<DataFactoryDataset>;
}
