import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppContainers;
@doc("Diagnostics data for a resource.")
@parentResource(ContainerApp)
model ContainerAppDetector is ProxyResource<DiagnosticsProperties> {
  @doc("Name of the Container App Detector.")
  @path
  @key("detectorName")
  @segment("detectors")
  name: string;
}

@armResourceOperations
interface ContainerAppDetectors {
  @doc("Get a diagnostics result of a Container App.")
  getDetector is ArmResourceRead<ContainerAppDetector>;
  @doc("Get the list of diagnostics for a given Container App.")
  listDetectors is ArmResourceListByParent<ContainerAppDetector>;
}
