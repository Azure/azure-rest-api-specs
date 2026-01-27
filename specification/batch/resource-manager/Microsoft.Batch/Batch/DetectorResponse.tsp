import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
/**
 * Contains the information for a detector.
 */
@parentResource(BatchAccount)
model DetectorResponse
  is Azure.ResourceManager.ProxyResource<DetectorResponseProperties> {
  ...ResourceNameParameter<
    Resource = DetectorResponse,
    KeyName = "detectorId",
    SegmentName = "detectors",
    NamePattern = ""
  >;

  /**
   * The ETag of the resource, used for concurrency statements.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations
interface DetectorResponses {
  /**
   * Gets information about the given detector for a given Batch account.
   */
  getDetector is ArmResourceRead<DetectorResponse, Error = CloudError>;

  /**
   * Gets information about the detectors available for a given Batch account.
   */
  listDetectors is ArmResourceListByParent<
    DetectorResponse,
    Response = ArmResponse<DetectorListResult>,
    Error = CloudError
  >;
}

@@doc(DetectorResponse.name, "The name of the detector.");
@@doc(DetectorResponse.properties,
  "The properties associated with the detector."
);
