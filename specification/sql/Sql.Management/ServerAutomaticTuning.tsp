import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Server-level Automatic Tuning.
 */
@singleton("current")
@parentResource(Server)
model ServerAutomaticTuning
  is Azure.ResourceManager.ProxyResource<AutomaticTuningServerProperties> {
  ...ResourceNameParameter<
    Resource = ServerAutomaticTuning,
    KeyName = "automaticTuning",
    SegmentName = "automaticTuning",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ServerAutomaticTunings {
  /**
   * Retrieves server automatic tuning options.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServerAutomaticTuning_Get")
  get is ArmResourceRead<ServerAutomaticTuning>;

  /**
   * Update automatic tuning options on server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServerAutomaticTuning_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ServerAutomaticTuning,
    PatchModel = ServerAutomaticTuning
  >;
}

@@doc(ServerAutomaticTuning.name, "");
@@doc(ServerAutomaticTuning.properties, "Resource properties.");
@@doc(ServerAutomaticTunings.update::parameters.properties,
  "The requested automatic tuning resource state."
);
