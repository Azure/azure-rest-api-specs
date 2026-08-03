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
@singleton("current")
@parentResource(Server)
model ServerAutomaticTuning is ProxyResource<AutomaticTuningServerProperties> {
  @key("automaticTuning")
  @segment("automaticTuning")
  name: string;
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
