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
@doc("Change data capture resource type.")
@parentResource(DataFactory)
model DataFactoryChangeDataCapture is ProxyResource<ChangeDataCapture> {
  @doc("The change data capture name.")
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @path
  @key("changeDataCaptureName")
  @segment("adfcdcs")
  name: string;
}

@armResourceOperations
interface DataFactoryChangeDataCaptures {
  @doc("Gets a change data capture.")
  get is ArmResourceRead<
    DataFactoryChangeDataCapture,
    {
      ...BaseParameters<DataFactoryChangeDataCapture>;

      @doc("ETag of the change data capture entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Creates or updates a change data capture resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DataFactoryChangeDataCapture,
    {
      ...BaseParameters<DataFactoryChangeDataCapture>;

      @doc("ETag of the change data capture entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes a change data capture.")
  delete is ArmResourceDeleteSync<DataFactoryChangeDataCapture>;
  @doc("Lists all resources of type change data capture.")
  listByFactory is ArmResourceListByParent<DataFactoryChangeDataCapture>;
  @doc("Starts a change data capture.")
  start is ArmResourceActionSync<DataFactoryChangeDataCapture, void, void>;
  @doc("Stops a change data capture.")
  stop is ArmResourceActionSync<DataFactoryChangeDataCapture, void, void>;
  @doc("Gets the current status for the change data capture resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataFactory/factories/{factoryName}/adfcdcs/{changeDataCaptureName}/status")
  @get
  Status is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The factory name.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
      @path
      factoryName: string;

      @doc("The change data capture name.")
      @maxLength(260)
      @minLength(1)
      @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
      @path
      changeDataCaptureName: string;
    },
    void
  >;
}
