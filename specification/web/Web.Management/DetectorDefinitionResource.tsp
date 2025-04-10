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

namespace Microsoft.CertificateRegistration;
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

        /** sites */
        @path @segment("sites") siteName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = DiagnosticCategory,
          KeyName = "diagnosticCategory",
          SegmentName = "diagnostics",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DetectorDefinitionResource,
        KeyName = "detectorName",
        SegmentName = "detectors",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DetectorDefinitionResources {
  /**
   * Description for Get Detector
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_GetSiteDetector")
  getSiteDetector is DetectorDefinitionResourceOps.Read<DetectorDefinitionResource>;

  /**
   * Description for Get Detectors
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_ListSiteDetectors")
  listSiteDetectors is DetectorDefinitionResourceOps.List<
    DetectorDefinitionResource,
    Response = ArmResponse<DiagnosticDetectorCollection>
  >;

  /**
   * Description for Execute Detector
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("execute")
  @operationId("Diagnostics_ExecuteSiteDetector")
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
    }
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

        /** sites */
        @path @segment("sites") siteName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "slot",
          SegmentName = "slots",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = DiagnosticCategory,
          KeyName = "diagnosticCategory",
          SegmentName = "diagnostics",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DetectorDefinitionResource,
        KeyName = "detectorName",
        SegmentName = "detectors",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DetectorDefinitionResourceOperationGroup {
  /**
   * Description for Get Detector
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_GetSiteDetectorSlot")
  getSiteDetectorSlot is DetectorDefinitionResourceOperationGroupOps.Read<DetectorDefinitionResource>;

  /**
   * Description for Get Detectors
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_ListSiteDetectorsSlot")
  listSiteDetectorsSlot is DetectorDefinitionResourceOperationGroupOps.List<
    DetectorDefinitionResource,
    Response = ArmResponse<DiagnosticDetectorCollection>
  >;

  /**
   * Description for Execute Detector
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("execute")
  @operationId("Diagnostics_ExecuteSiteDetectorSlot")
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
    }
  >;
}

@@doc(DetectorDefinitionResource.name, "Detector Name");
@@doc(DetectorDefinitionResource.properties, "Core resource properties");
