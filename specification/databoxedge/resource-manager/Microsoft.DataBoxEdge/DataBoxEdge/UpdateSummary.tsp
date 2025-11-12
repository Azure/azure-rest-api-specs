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
 * Details about ongoing updates and availability of updates on the device.
 */
@singleton("default")
@parentResource(DataBoxEdgeDevice)
model UpdateSummary
  is Azure.ResourceManager.ProxyResource<UpdateSummaryProperties> {
  ...ResourceNameParameter<
    Resource = UpdateSummary,
    KeyName = "updateSummary",
    SegmentName = "updateSummary",
    NamePattern = ""
  >;
}

@armResourceOperations
interface UpdateSummaries {
  /**
   * Gets information about the availability of updates based on the last scan of the device. It also gets information about any ongoing download or install jobs on the device.
   */
  @summary("Gets information about the availability of updates based on the last scan of the device. It also gets information about any ongoing download or install jobs on the device.")
  getUpdateSummary is ArmResourceRead<UpdateSummary, Error = CloudError>;
}

@@doc(UpdateSummary.name, "");
@@doc(UpdateSummary.properties, "The device update information summary.");
