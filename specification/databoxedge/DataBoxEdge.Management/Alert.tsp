import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * Alert on the data box edge/gateway device.
 */
@parentResource(DataBoxEdgeDevice)
model Alert is Azure.ResourceManager.ProxyResource<AlertProperties> {
  ...ResourceNameParameter<
    Resource = Alert,
    KeyName = "name",
    SegmentName = "alerts",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Alerts {
  /**
   * Gets an alert by name.
   */
  @summary("Gets an alert by name.")
  get is ArmResourceRead<Alert, Error = CloudError>;

  /**
   * Gets all the alerts for a Data Box Edge/Data Box Gateway device.
   */
  listByDataBoxEdgeDevice is ArmResourceListByParent<
    Alert,
    Response = ArmResponse<AlertList>,
    Error = CloudError
  >;
}

@@doc(Alert.name, "The alert name.");
@@doc(Alert.properties, "Properties of alert.");
