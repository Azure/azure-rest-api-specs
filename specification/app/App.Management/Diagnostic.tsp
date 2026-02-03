import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConnectedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;

/**
 * Diagnostics data for a resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model Diagnostics
  extends Azure.ResourceManager.ProxyResource<DiagnosticsProperties> {
  ...ResourceNameParameter<
    Resource = Diagnostics,
    KeyName = "detectorName",
    SegmentName = "detectors",
    NamePattern = ""
  >;
}

@armResourceOperations
@tag("Diagnostics")
interface Diagnostic {
  // /**
  //  * Get the properties of a Container App Job.
  //  */
  // @tag("Jobs")
  // proxyGet is ArmResourceRead<
  //   Job,
  //   Parameters = {
  //     /**
  //      * Proxy API Name for Container App Job.
  //      */
  //     @path
  //     @segment("detectorProperties")
  //     @pattern("^[-\\w\\._]+$")
  //     apiName: string;
  //   },
  //   Error = DefaultErrorResponse
  // >;
}
