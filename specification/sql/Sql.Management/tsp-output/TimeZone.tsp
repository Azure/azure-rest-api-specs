import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Time Zone.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@locationResource
@Azure.ResourceManager.Private.armResourceInternal(TimeZoneProperties)
@includeInapplicableMetadataInPayload(false)
model TimeZone extends ProxyResource {
  @path
  @key("timeZoneId")
  @segment("timeZones")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: TimeZoneProperties;
}

@armResourceOperations
interface TimeZones {
  /**
   * Gets a managed instance time zone.
   */
  get is ArmResourceRead<TimeZone>;

  /**
   * Gets a list of managed instance time zones by location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TimeZones_ListByLocation")
  listByLocation is ArmResourceListByParent<TimeZone>;
}
