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
/**
 * Diagnostics data for a resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ContainerApp)
@Azure.ResourceManager.Private.armResourceInternal(DiagnosticsProperties)
@includeInapplicableMetadataInPayload(false)
model Diagnostics extends ProxyResourceBase {
  /**
   * Name of the Container App Detector.
   */
  @path
  @key("detectorName")
  @segment("detectors")
  name: string;

  /**
   * Diagnostics resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: DiagnosticsProperties;
}

@armResourceOperations
@projectedName("client", "Diagnostics")
interface DiagnosticsOperationGroup {
  /**
   * Get a diagnostics result of a Container App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsDiagnostics_GetDetector")
  getDetector is ArmResourceRead<Diagnostics>;

  /**
   * Get the list of diagnostics for a given Container App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsDiagnostics_ListDetectors")
  listDetectors is ArmResourceListByParent<Diagnostics>;
}
