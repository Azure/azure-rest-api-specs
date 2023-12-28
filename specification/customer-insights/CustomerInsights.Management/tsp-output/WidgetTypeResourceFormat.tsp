import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CustomerInsights;
@doc("The WidgetTypeResourceFormat")
@parentResource(Hub)
model WidgetTypeResourceFormat is ProxyResource<WidgetType> {
  @doc("The name of the widget type.")
  @key("widgetTypeName")
  @segment("widgetTypes")
  name: string;
}

@armResourceOperations
interface WidgetTypes {
  @doc("Gets a widget type in the specified hub.")
  get is ArmResourceRead<WidgetTypeResourceFormat>;
  @doc("Gets all available widget types in the specified hub.")
  listByHub is ArmResourceListByParent<WidgetTypeResourceFormat>;
}
