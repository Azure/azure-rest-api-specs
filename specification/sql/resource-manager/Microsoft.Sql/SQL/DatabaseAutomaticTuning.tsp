import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Database-level Automatic Tuning.
 */
@singleton("current")
@parentResource(Database)
model DatabaseAutomaticTuning
  is Azure.ResourceManager.ProxyResource<DatabaseAutomaticTuningProperties> {
  ...ResourceNameParameter<
    Resource = DatabaseAutomaticTuning,
    KeyName = "automaticTuning",
    SegmentName = "automaticTuning",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface DatabaseAutomaticTunings {
  /**
   * Gets a database's automatic tuning.
   */
  @tag("DatabaseAutomaticTuning")
  get is ArmResourceRead<DatabaseAutomaticTuning>;

  /**
   * Update automatic tuning properties for target database.
   */
  @tag("DatabaseAutomaticTuning")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    DatabaseAutomaticTuning,
    PatchModel = DatabaseAutomaticTuning
  >;
}

@@doc(DatabaseAutomaticTuning.name, "");
@@doc(DatabaseAutomaticTuning.properties, "Resource properties.");
@@doc(DatabaseAutomaticTunings.update::parameters.properties,
  "The requested automatic tuning resource state."
);
