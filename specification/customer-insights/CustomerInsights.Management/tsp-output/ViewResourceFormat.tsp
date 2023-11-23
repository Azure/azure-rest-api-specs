import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CustomerInsights;
@doc("The view resource format.")
@parentResource(Hub)
model ViewResourceFormat is ProxyResource<View> {
  @doc("The name of the view.")
  @path
  @key("viewName")
  @segment("views")
  name: string;
}

@armResourceOperations
interface ViewResourceFormats {
  @doc("Gets a view in the hub.")
  get is ArmResourceRead<
    ViewResourceFormat,
    {
      ...BaseParameters<ViewResourceFormat>;

      @doc("The user ID. Use * to retrieve hub level view.")
      @query("userId")
      userId: string;
    }
  >;
  @doc("Creates a view or updates an existing view in the hub.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ViewResourceFormat>;
  @doc("Deletes a view in the specified hub.")
  delete is ArmResourceDeleteSync<
    ViewResourceFormat,
    {
      ...BaseParameters<ViewResourceFormat>;

      @doc("The user ID. Use * to retrieve hub level view.")
      @query("userId")
      userId: string;
    }
  >;
  @doc("Gets all available views for given user in the specified hub.")
  listByHub is ArmResourceListByParent<
    ViewResourceFormat,
    {
      ...BaseParameters<ViewResourceFormat>;

      @doc("The user ID. Use * to retrieve hub level views.")
      @query("userId")
      userId: string;
    }
  >;
}
