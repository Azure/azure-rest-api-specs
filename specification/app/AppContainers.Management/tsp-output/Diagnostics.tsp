import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.App;
@doc("Diagnostics data for a resource.")
@parentResource(ContainerApp)
model Diagnostics is ProxyResource<DiagnosticsProperties> {
  @doc("Name of the Container App Detector.")
  @key("detectorName")
  @segment("detectors")
  name: string;
}

@armResourceOperations
@projectedName("client", "ContainerAppsDiagnostics")
interface Diagnostics_ContainerAppsDiagnostics {
  @doc("Get a diagnostics result of a Container App.")
  getDetector is ArmResourceRead<Diagnostics>;

  @doc("Get the list of diagnostics for a given Container App.")
  listDetectors is ArmResourceListByParent<Diagnostics>;
}
