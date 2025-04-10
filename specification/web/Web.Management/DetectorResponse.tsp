import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceCertificateOrder.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Class representing Response from Detector
 */
@parentResource(AppServiceCertificateOrder)
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
        ...KeysOf<ResourceNameParameter<
          Resource = AppServiceCertificateOrder,
          KeyName = "certificateOrderName",
          SegmentName = "certificateOrders",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DetectorResponse,
        KeyName = "detectorName",
        SegmentName = "detectors",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DetectorResponses {
  /**
   * Description for Microsoft.CertificateRegistration call to get a detector response from App Lens.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CertificateOrdersDiagnostics_GetAppServiceCertificateOrderDetectorResponse")
  getAppServiceCertificateOrderDetectorResponse is DetectorResponseOps.Read<
    DetectorResponse,
    Parameters = {
      /**
       * The start time for detector response.
       */
      @query("startTime")
      startTime?: utcDateTime;

      /**
       * The end time for the detector response.
       */
      @query("endTime")
      endTime?: utcDateTime;

      /**
       * The time grain for the detector response.
       */
      @pattern("PT[1-9][0-9]+[SMH]")
      @query("timeGrain")
      timeGrain?: string;
    }
  >;

  /**
   * Description for Microsoft.CertificateRegistration to get the list of detectors for this RP.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CertificateOrdersDiagnostics_ListAppServiceCertificateOrderDetectorResponse")
  listAppServiceCertificateOrderDetectorResponse is DetectorResponseOps.List<
    DetectorResponse,
    Response = ArmResponse<DetectorResponseCollection>
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
        ...KeysOf<ResourceNameParameter<
          Resource = AppServiceEnvironmentResource,
          KeyName = "name",
          SegmentName = "hostingEnvironments",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DetectorResponse,
        KeyName = "detectorName",
        SegmentName = "detectors",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Diagnostics {
  /**
   * Description for Get Hosting Environment Detector Response
   */
  getHostingEnvironmentDetectorResponse is DiagnosticOps.Read<
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
    }
  >;

  /**
   * Description for List Hosting Environment Detector Responses
   */
  listHostingEnvironmentDetectorResponses is DiagnosticOps.List<
    DetectorResponse,
    Response = ArmResponse<DetectorResponseCollection>
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

        /** sites */
        @path @segment("sites") siteName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = DetectorResponse,
        KeyName = "detectorName",
        SegmentName = "detectors",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DetectorResponseOperationGroup {
  /**
   * Description for Get site detector response
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_GetSiteDetectorResponse")
  getSiteDetectorResponse is DetectorResponseOperationGroupOps.Read<
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
    }
  >;

  /**
   * Description for List Site Detector Responses
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_ListSiteDetectorResponses")
  listSiteDetectorResponses is DetectorResponseOperationGroupOps.List<
    DetectorResponse,
    Response = ArmResponse<DetectorResponseCollection>
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

        /** sites */
        @path @segment("sites") siteName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "slot",
          SegmentName = "slots",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = DetectorResponse,
        KeyName = "detectorName",
        SegmentName = "detectors",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DetectorResponseOperationGroup {
  /**
   * Description for Get site detector response
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
    }
  >;

  /**
   * Description for List Site Detector Responses
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Diagnostics_ListSiteDetectorResponsesSlot")
  listSiteDetectorResponsesSlot is DetectorResponseOperationGroupOps.List<
    DetectorResponse,
    Response = ArmResponse<DetectorResponseCollection>
  >;
}

@@doc(DetectorResponse.name, "The detector name which needs to be run.");
@@doc(DetectorResponse.properties,
  "DetectorResponse resource specific properties"
);
