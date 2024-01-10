import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DiagnosticCategory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("ARM resource for a detector definition")
@parentResource(DiagnosticCategory)
model DetectorDefinitionResource is ProxyResource<DetectorDefinition> {
  @doc("Detector Name")
  @key("detectorName")
  @segment("detectors")
  name: string;
}

@armResourceOperations
@projectedName("client", "Diagnostics")
interface DetectorDefinitionResources_Diagnostics {
  @doc("Description for Get Detector")
  getSiteDetector is ArmResourceRead<DetectorDefinitionResource>;

  @doc("Description for Get Detectors")
  listSiteDetectors is ArmResourceListByParent<DetectorDefinitionResource>;

  @doc("Description for Execute Detector")
  executeSiteDetector is ArmResourceActionSync<
    DetectorDefinitionResource,
    void,
    DiagnosticDetectorResponse,
    {
      ...BaseParameters<DetectorDefinitionResource>;

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
