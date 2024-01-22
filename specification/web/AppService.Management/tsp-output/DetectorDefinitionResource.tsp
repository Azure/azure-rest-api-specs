import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DiagnosticCategory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * ARM resource for a detector definition
 */
@parentResource(DiagnosticCategory)
model DetectorDefinitionResource is ProxyResource<DetectorDefinition> {
  /**
   * Detector Name
   */
  @path
  @key("detectorName")
  @segment("detectors")
  name: string;
}

@armResourceOperations
interface DetectorDefinitionResources {
  /**
   * Description for Get Detector
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Diagnostics_GetSiteDetector")
  getSiteDetector is ArmResourceRead<DetectorDefinitionResource>;

  /**
   * Description for Get Detectors
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Diagnostics_ListSiteDetectors")
  listSiteDetectors is ArmResourceListByParent<DetectorDefinitionResource>;

  /**
   * Description for Execute Detector
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Diagnostics_ExecuteSiteDetector")
  executeSiteDetector is ArmResourceActionSync<
    DetectorDefinitionResource,
    void,
    DiagnosticDetectorResponse,
    {
      ...BaseParameters<DetectorDefinitionResource>;

      /**
       * Start Time
       */
      @query("startTime")
      startTime?: utcDateTime;

      /**
       * End Time
       */
      @query("endTime")
      endTime?: utcDateTime;

      /**
       * Time Grain
       */
      @pattern("PT[1-9][0-9]+[SMH]")
      @query("timeGrain")
      timeGrain?: string;
    }
  >;
}
