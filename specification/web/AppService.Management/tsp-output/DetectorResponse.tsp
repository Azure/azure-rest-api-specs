import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceCertificateOrder.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Class representing Response from Detector
 */
@parentResource(AppServiceCertificateOrder)
model DetectorResponse is ProxyResource<DetectorResponseProperties> {
  /**
   * The detector name which needs to be run.
   */
  @path
  @key("detectorName")
  @segment("detectors")
  name: string;
}

@armResourceOperations
interface DetectorResponses {
  /**
   * Description for Microsoft.CertificateRegistration call to get a detector response from App Lens.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CertificateOrdersDiagnostics_GetAppServiceCertificateOrderDetectorResponse")
  getAppServiceCertificateOrderDetectorResponse is ArmResourceRead<
    DetectorResponse,
    {
      ...BaseParameters<DetectorResponse>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CertificateOrdersDiagnostics_ListAppServiceCertificateOrderDetectorResponse")
  listAppServiceCertificateOrderDetectorResponse is ArmResourceListByParent<DetectorResponse>;
}
