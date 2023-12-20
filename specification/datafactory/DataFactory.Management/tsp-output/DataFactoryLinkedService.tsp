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
@doc("Linked service resource type.")
@parentResource(DataFactory)
model DataFactoryLinkedService is ProxyResource<LinkedService> {
  @doc("The linked service name.")
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @path
  @key("linkedServiceName")
  @segment("linkedservices")
  name: string;
}

@armResourceOperations
interface DataFactoryLinkedServices {
  @doc("Gets a linked service.")
  get is ArmResourceRead<
    DataFactoryLinkedService,
    {
      ...BaseParameters<DataFactoryLinkedService>;

      @doc("ETag of the linked service entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Creates or updates a linked service.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DataFactoryLinkedService,
    {
      ...BaseParameters<DataFactoryLinkedService>;

      @doc("ETag of the linkedService entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes a linked service.")
  delete is ArmResourceDeleteSync<DataFactoryLinkedService>;
  @doc("Lists linked services.")
  listByFactory is ArmResourceListByParent<DataFactoryLinkedService>;
}
