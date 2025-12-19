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

namespace Microsoft.Web;

@armResourceOperations
interface CertificateOrdersDiagnostics {
  // /**
  //  * Description for Microsoft.CertificateRegistration call to get a detector response from App Lens.
  //  */
  // getAppServiceCertificateOrderDetectorResponse is ArmResourceRead<
  //   DetectorResponse,
  //   Parameters = {
  //     /**
  //      * The start time for detector response.
  //      */
  //     @query("startTime")
  //     startTime?: utcDateTime;
  //     /**
  //      * The end time for the detector response.
  //      */
  //     @query("endTime")
  //     endTime?: utcDateTime;
  //     /**
  //      * The time grain for the detector response.
  //      */
  //     @pattern("PT[1-9][0-9]+[SMH]")
  //     @query("timeGrain")
  //     timeGrain?: string;
  //   },
  //   Error = DefaultErrorResponse
  // >;
  // /**
  //  * Description for Microsoft.CertificateRegistration to get the list of detectors for this RP.
  //  */
  // listAppServiceCertificateOrderDetectorResponse is ArmResourceListByParent<
  //   DetectorResponse,
  //   Response = ArmResponse<DetectorResponseCollection>,
  //   Error = DefaultErrorResponse
  // >;
}

@@doc(DetectorResponse.name, "The detector name which needs to be run.");
@@doc(DetectorResponse.properties,
  "DetectorResponse resource specific properties"
);
// @@summary(CertificateOrdersDiagnostics.listAppServiceCertificateOrderDetectorResponse,
//   "Microsoft.CertificateRegistration to get the list of detectors for this RP."
// );
// @@summary(CertificateOrdersDiagnostics.getAppServiceCertificateOrderDetectorResponse,
//   "Microsoft.CertificateRegistration call to get a detector response from App Lens."
// );
