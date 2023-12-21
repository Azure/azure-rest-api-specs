import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceCertificateOrder.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Class representing Response from Detector")
@parentResource(AppServiceCertificateOrder)
model DetectorResponse is ProxyResource<DetectorResponseProperties> {
  @doc("The detector name which needs to be run.")
  @path
  @key("detectorName")
  @segment("detectors")
  name: string;
}

@armResourceOperations
interface CertificateOrdersDiagnostics {
  @doc("Description for Microsoft.CertificateRegistration call to get a detector response from App Lens.")
  getAppServiceCertificateOrderDetectorResponse is ArmResourceRead<
    DetectorResponse,
    {
      ...BaseParameters<DetectorResponse>;

      @doc("The start time for detector response.")
      @query("startTime")
      startTime?: utcDateTime;

      @doc("The end time for the detector response.")
      @query("endTime")
      endTime?: utcDateTime;

      @doc("The time grain for the detector response.")
      @pattern("PT[1-9][0-9]+[SMH]")
      @query("timeGrain")
      timeGrain?: string;
    }
  >;
  @doc("Description for Microsoft.CertificateRegistration to get the list of detectors for this RP.")
  listAppServiceCertificateOrderDetectorResponse is ArmResourceListByParent<DetectorResponse>;
}
