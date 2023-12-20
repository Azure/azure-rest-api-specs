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
@doc("Data flow resource type.")
@parentResource(DataFactory)
model DataFactoryDataFlow is ProxyResource<DataFlow> {
  @doc("The data flow name.")
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @path
  @key("dataFlowName")
  @segment("dataflows")
  name: string;
}

@armResourceOperations
interface DataFactoryDataFlows {
  @doc("Gets a data flow.")
  get is ArmResourceRead<
    DataFactoryDataFlow,
    {
      ...BaseParameters<DataFactoryDataFlow>;

      @doc("ETag of the data flow entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Creates or updates a data flow.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DataFactoryDataFlow,
    {
      ...BaseParameters<DataFactoryDataFlow>;

      @doc("ETag of the data flow entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes a data flow.")
  delete is ArmResourceDeleteSync<DataFactoryDataFlow>;
  @doc("Lists data flows.")
  listByFactory is ArmResourceListByParent<DataFactoryDataFlow>;
}
