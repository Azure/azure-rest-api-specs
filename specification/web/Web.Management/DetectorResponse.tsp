import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceEnvironmentResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Class representing Response from Detector
 */
@parentResource(AppServiceEnvironmentResource)
model DetectorResponse
  is Azure.ResourceManager.ProxyResource<DetectorResponseProperties> {
  ...ResourceNameParameter<
    Resource = DetectorResponse,
    KeyName = "detectorName",
    SegmentName = "detectors",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DetectorResponseOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** App Service Environment Name */
        @path
        @segment("hostingEnvironments")
        @key
        name: string,
      },
      {
        /** Detector Resource Name */
        @path
        @segment("detectors")
        @key
        detectorName: string,
      }
    > {}

@armResourceOperations
interface DetectorResponses {
  /**
   * Description for Get Hosting Environment Detector Response
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Diagnostics_GetHostingEnvironmentDetectorResponse")
  getHostingEnvironmentDetectorResponse is DetectorResponseOps.Read<
    DetectorResponse,
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

  /**
   * Description for List Hosting Environment Detector Responses
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Diagnostics_ListHostingEnvironmentDetectorResponses")
  listHostingEnvironmentDetectorResponses is DetectorResponseOps.List<
    DetectorResponse,
    Response = ArmResponse<DetectorResponseCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface DiagnosticOps
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
      },
      {
        /** Detector Resource Name */
        @path
        @segment("detectors")
        @key
        detectorName: string,
      }
    > {}

@armResourceOperations
interface Diagnostics {
  /**
   * Description for Get site detector response
   */
  getSiteDetectorResponse is DiagnosticOps.Read<
    DetectorResponse,
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

  /**
   * Description for List Site Detector Responses
   */
  listSiteDetectorResponses is DiagnosticOps.List<
    DetectorResponse,
    Response = ArmResponse<DetectorResponseCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface DetectorResponseOperationGroupOps
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
      },
      {
        /** Detector Resource Name */
        @path
        @segment("detectors")
        @key
        detectorName: string,
      }
    > {}

@armResourceOperations
interface DetectorResponseOperationGroup {
  /**
   * Description for Get site detector response
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Diagnostics_GetSiteDetectorResponseSlot")
  getSiteDetectorResponseSlot is DetectorResponseOperationGroupOps.Read<
    DetectorResponse,
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

  /**
   * Description for List Site Detector Responses
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Diagnostics_ListSiteDetectorResponsesSlot")
  listSiteDetectorResponsesSlot is DetectorResponseOperationGroupOps.List<
    DetectorResponse,
    Response = ArmResponse<DetectorResponseCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(DetectorResponse.name, "Detector Resource Name");
@@doc(DetectorResponse.properties,
  "DetectorResponse resource specific properties"
);
