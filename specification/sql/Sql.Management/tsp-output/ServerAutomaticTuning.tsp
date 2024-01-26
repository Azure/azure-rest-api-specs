import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Server-level Automatic Tuning.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("current")
@parentResource(Server)
@includeInapplicableMetadataInPayload(false)
model ServerAutomaticTuning extends ProxyResource {
  @key("automaticTuning")
  @segment("automaticTuning")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AutomaticTuningServerProperties;
}

@armResourceOperations
interface ServerAutomaticTunings {
  /**
   * Retrieves server automatic tuning options.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerAutomaticTuning_Get")
  get is ArmResourceRead<ServerAutomaticTuning>;

  /**
   * Update automatic tuning options on server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("ServerAutomaticTuning_Update")
  update is ArmCustomPatchSync<ServerAutomaticTuning, ServerAutomaticTuning>;
}

@@projectedName(ServerAutomaticTunings.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ServerAutomaticTunings.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerAutomaticTunings.update::parameters.properties,
  "The requested automatic tuning resource state."
);
