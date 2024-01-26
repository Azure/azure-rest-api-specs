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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DiagnosticCategory)
@includeInapplicableMetadataInPayload(false)
model DetectorDefinitionResource extends ProxyOnlyResource {
  /**
   * Detector Name
   */
  @path
  @key("detectorName")
  @segment("detectors")
  @visibility("read")
  name: string;

  /**
   * Core resource properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: DetectorDefinition;
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
