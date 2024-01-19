import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
@doc("Diagnostics data for a resource.")
@parentResource(ContainerApp)
model Diagnostics is ProxyResource<DiagnosticsProperties> {
  @doc("Name of the Container App Detector.")
  @path
  @key("detectorName")
  @segment("detectors")
  name: string;
}

@armResourceOperations
@projectedName("client", "Diagnostics")
interface DiagnosticsOperationGroup {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a diagnostics result of a Container App.")
  @operationId("ContainerAppsDiagnostics_GetDetector")
  getDetector is ArmResourceRead<Diagnostics>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the list of diagnostics for a given Container App.")
  @operationId("ContainerAppsDiagnostics_ListDetectors")
  listDetectors is ArmResourceListByParent<Diagnostics>;
}
