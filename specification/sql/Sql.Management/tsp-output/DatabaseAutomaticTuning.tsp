import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Database-level Automatic Tuning.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("current")
@parentResource(Database)
@includeInapplicableMetadataInPayload(false)
model DatabaseAutomaticTuning extends ProxyResource {
  @key("automaticTuning")
  @segment("automaticTuning")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DatabaseAutomaticTuningProperties;
}

@armResourceOperations
interface DatabaseAutomaticTunings {
  /**
   * Gets a database's automatic tuning.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseAutomaticTuning_Get")
  get is ArmResourceRead<DatabaseAutomaticTuning>;

  /**
   * Update automatic tuning properties for target database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("DatabaseAutomaticTuning_Update")
  update is ArmCustomPatchSync<
    DatabaseAutomaticTuning,
    DatabaseAutomaticTuning
  >;
}

@@projectedName(DatabaseAutomaticTunings.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(DatabaseAutomaticTunings.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(DatabaseAutomaticTunings.update::parameters.properties,
  "The requested automatic tuning resource state."
);
