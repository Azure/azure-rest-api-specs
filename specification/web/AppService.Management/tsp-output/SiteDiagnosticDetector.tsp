import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SiteDiagnostic.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("ARM resource for a detector definition")
@parentResource(SiteDiagnostic)
model SiteDiagnosticDetector is ProxyResource<DetectorDefinition> {
  @doc("Detector Name")
  @path
  @key("detectorName")
  @segment("detectors")
  name: string;
}

@armResourceOperations
interface SiteDiagnosticDetectors {
  @doc("Description for Get Detector")
  getSiteDetector is ArmResourceRead<SiteDiagnosticDetector>;
  @doc("Description for Get Detectors")
  listSiteDetectors is ArmResourceListByParent<SiteDiagnosticDetector>;
  @doc("Description for Execute Detector")
  executeSiteDetector is ArmResourceActionSync<
    SiteDiagnosticDetector,
    {},
    DiagnosticDetectorResponse,
    {
      ...BaseParameters<SiteDiagnosticDetector>;

      @doc("Start Time")
      @query("startTime")
      startTime?: utcDateTime;

      @doc("End Time")
      @query("endTime")
      endTime?: utcDateTime;

      @doc("Time Grain")
      @pattern("PT[1-9][0-9]+[SMH]")
      @query("timeGrain")
      timeGrain?: string;
    }
  >;
}
