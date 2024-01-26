import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * Alert on the data box edge/gateway device.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DataBoxEdgeDevice)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(AlertProperties)
model Alert extends ProxyResourceBase {
  /**
   * The alert name.
   */
  @path
  @key("name")
  @segment("alerts")
  @visibility("read")
  name: string;

  /**
   * Properties of alert.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AlertProperties;
}

@armResourceOperations
interface Alerts {
  /**
   * Gets an alert by name.
   */
  get is ArmResourceRead<Alert>;

  /**
   * Gets all the alerts for a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Alerts_ListByDataBoxEdgeDevice")
  listByDataBoxEdgeDevice is ArmResourceListByParent<Alert>;
}
