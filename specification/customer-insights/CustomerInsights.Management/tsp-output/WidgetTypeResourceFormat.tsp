import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CustomerInsights;
@doc("The WidgetTypeResourceFormat")
@parentResource(Hub)
model WidgetTypeResourceFormat is ProxyResource<WidgetType> {
  @doc("The name of the widget type.")
  @path
  @key("widgetTypeName")
  @segment("widgetTypes")
  name: string;
}

@armResourceOperations
interface WidgetTypeResourceFormats {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a widget type in the specified hub.")
  @operationId("WidgetTypes_Get")
  get is ArmResourceRead<WidgetTypeResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all available widget types in the specified hub.")
  @operationId("WidgetTypes_ListByHub")
  listByHub is ArmResourceListByParent<WidgetTypeResourceFormat>;
}
