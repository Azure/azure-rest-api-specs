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
/**
 * The WidgetTypeResourceFormat
 */
@parentResource(Hub)
model WidgetTypeResourceFormat is ProxyResource<WidgetType> {
  /**
   * The name of the widget type.
   */
  @path
  @key("widgetTypeName")
  @segment("widgetTypes")
  name: string;
}

@armResourceOperations
interface WidgetTypeResourceFormats {
  /**
   * Gets a widget type in the specified hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WidgetTypes_Get")
  get is ArmResourceRead<WidgetTypeResourceFormat>;

  /**
   * Gets all available widget types in the specified hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WidgetTypes_ListByHub")
  listByHub is ArmResourceListByParent<WidgetTypeResourceFormat>;
}
