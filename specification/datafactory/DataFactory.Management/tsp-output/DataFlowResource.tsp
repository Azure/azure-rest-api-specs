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
@doc("Data flow resource type.")
@parentResource(Factory)
model DataFlowResource is ProxyResource<DataFlow> {
  @doc("The data flow name.")
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @key("dataFlowName")
  @segment("dataflows")
  name: string;
}

@armResourceOperations
@projectedName("client", "DataFlows")
interface DataFlowResources_DataFlows {
  @doc("Gets a data flow.")
  get is ArmResourceRead<
    DataFlowResource,
    {
      ...BaseParameters<DataFlowResource>;

      @doc("ETag of the data flow entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;

  @doc("Creates or updates a data flow.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DataFlowResource,
    {
      ...BaseParameters<DataFlowResource>;

      @doc("ETag of the data flow entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;

  @doc("Deletes a data flow.")
  delete is ArmResourceDeleteSync<DataFlowResource>;

  @doc("Lists data flows.")
  listByFactory is ArmResourceListByParent<DataFlowResource>;
}
