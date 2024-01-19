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
@doc("Database-level Automatic Tuning.")
@singleton("current")
@parentResource(Database)
model DatabaseAutomaticTuning
  is ProxyResource<DatabaseAutomaticTuningProperties> {
  @key("automaticTuning")
  @segment("automaticTuning")
  name: string;
}

@armResourceOperations
interface DatabaseAutomaticTunings {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a database's automatic tuning.")
  @operationId("DatabaseAutomaticTuning_Get")
  get is ArmResourceRead<DatabaseAutomaticTuning>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update automatic tuning properties for target database.")
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
