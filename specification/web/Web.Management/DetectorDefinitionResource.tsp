import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DiagnosticCategory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * ARM resource for a detector definition
 */
@parentResource(DiagnosticCategory)
model DetectorDefinitionResource
  is Azure.ResourceManager.ProxyResource<DetectorDefinition> {
  ...ResourceNameParameter<
    Resource = DetectorDefinitionResource,
    KeyName = "detectorName",
    SegmentName = "detectors",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DetectorDefinitionResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site Name */
        @path
        @segment("sites")
        @key
        siteName: string,

        /** Diagnostic Category */
        @path
        @segment("diagnostics")
        @key
        diagnosticCategory: string,
      },
      {
        /** Detector Name */
        @path
        @segment("detectors")
        @key
        detectorName: string,
      }
    > {}

@armResourceOperations
interface DetectorDefinitionResources {
  /**
   * Description for Get Detector
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Diagnostics_GetSiteDetector")
  getSiteDetector is DetectorDefinitionResourceOps.Read<
    DetectorDefinitionResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get Detectors
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Diagnostics_ListSiteDetectors")
  listSiteDetectors is DetectorDefinitionResourceOps.List<
    DetectorDefinitionResource,
    Response = ArmResponse<DiagnosticDetectorCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Execute Detector
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Diagnostics_ExecuteSiteDetector")
  @action("execute")
  executeSiteDetector is DetectorDefinitionResourceOps.ActionSync<
    DetectorDefinitionResource,
    void,
    ArmResponse<DiagnosticDetectorResponse>,
    Parameters = {
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
    },
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface DetectorDefinitionResourceOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site Name */
        @path
        @segment("sites")
        @key
        siteName: string,

        /** Slot Name */
        @path
        @segment("slots")
        @key
        slot: string,

        /** Diagnostic Category */
        @path
        @segment("diagnostics")
        @key
        diagnosticCategory: string,
      },
      {
        /** Detector Name */
        @path
        @segment("detectors")
        @key
        detectorName: string,
      }
    > {}

@armResourceOperations
interface DetectorDefinitionResourceOperationGroup {
  /**
   * Description for Get Detector
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Diagnostics_GetSiteDetectorSlot")
  getSiteDetectorSlot is DetectorDefinitionResourceOperationGroupOps.Read<
    DetectorDefinitionResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get Detectors
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Diagnostics_ListSiteDetectorsSlot")
  listSiteDetectorsSlot is DetectorDefinitionResourceOperationGroupOps.List<
    DetectorDefinitionResource,
    Response = ArmResponse<DiagnosticDetectorCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Execute Detector
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Diagnostics_ExecuteSiteDetectorSlot")
  @action("execute")
  executeSiteDetectorSlot is DetectorDefinitionResourceOperationGroupOps.ActionSync<
    DetectorDefinitionResource,
    void,
    ArmResponse<DiagnosticDetectorResponse>,
    Parameters = {
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
    },
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(DetectorDefinitionResource.name, "Detector Name");
@@doc(DetectorDefinitionResource.properties, "Core resource properties");
