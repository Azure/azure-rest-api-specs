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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Hub)
@Azure.ResourceManager.Private.armResourceInternal(WidgetType)
@includeInapplicableMetadataInPayload(false)
model WidgetTypeResourceFormat extends ProxyResource {
  /**
   * The name of the widget type.
   */
  @path
  @key("widgetTypeName")
  @segment("widgetTypes")
  name: string;

  /**
   * Definition of WidgetType.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WidgetType;
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
