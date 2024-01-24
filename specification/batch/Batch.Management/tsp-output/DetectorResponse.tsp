import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
/**
 * Contains the information for a detector.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(BatchAccount)
@Azure.ResourceManager.Private.armResourceInternal(DetectorResponseProperties)
@includeInapplicableMetadataInPayload(false)
model DetectorResponse extends ProxyResource {
  /**
   * The name of the detector.
   */
  @path
  @key("detectorId")
  @segment("detectors")
  name: string;

  /**
   * The properties associated with the detector.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DetectorResponseProperties;
}

@armResourceOperations
interface DetectorResponses {
  /**
   * Gets information about the given detector for a given Batch account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BatchAccount_GetDetector")
  getDetector is ArmResourceRead<DetectorResponse>;

  /**
   * Gets information about the detectors available for a given Batch account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BatchAccount_ListDetectors")
  listDetectors is ArmResourceListByParent<DetectorResponse>;
}
