import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * An environment for hosting container apps
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("rootApi")
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ManagedEnvironmentProperties)
model ManagedEnvironment extends TrackedResourceBase {
  @key("detectorProperty")
  @segment("detectorProperties")
  @visibility("read")
  name: string;

  /**
   * Kind of the Environment.
   */
  kind?: string;

  /**
   * Managed environment resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ManagedEnvironmentProperties;
}

@armResourceOperations
interface ManagedEnvironments {
  /**
   * Get the properties of a Managed Environment used to host container apps.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedEnvironmentsDiagnostics_GetRoot")
  getRoot is ArmResourceRead<ManagedEnvironment>;
}
