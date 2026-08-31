import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServerInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureArcData;
/**
 * Arc Sql Server database
 */
@parentResource(SqlServerInstance)
model SqlServerDatabaseResource
  is Azure.ResourceManager.TrackedResource<
    SqlServerDatabaseResourceProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = SqlServerDatabaseResource,
    KeyName = "databaseName",
    SegmentName = "databases",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SqlServerDatabaseResources {
  /**
   * Retrieves an Arc Sql Server database.
   */
  get is ArmResourceRead<SqlServerDatabaseResource>;

  /**
   * Creates or replaces an Arc Sql Server Database.
   */
  create is ArmResourceCreateOrReplaceSync<SqlServerDatabaseResource>;

  /**
   * Updates an existing database.
   */
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is ArmCustomPatchAsync<
    SqlServerDatabaseResource,
    PatchModel = SqlServerDatabaseUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlServerDatabaseResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes an Arc Sql Server database resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<SqlServerDatabaseResource>;

  /**
   * List the databases associated with the given Arc Sql Server.
   */
  @summary("List the databases associated with the given Arc Sql Server.")
  list is ArmResourceListByParent<
    SqlServerDatabaseResource,
    Response = ArmResponse<ArcSqlServerDatabaseListResult>
  >;
}

@@doc(SqlServerDatabaseResource.name, "Name of the database");
@@doc(
  SqlServerDatabaseResource.properties,
  "Properties of Arc Sql Server database"
);
@@doc(
  SqlServerDatabaseResources.create::parameters.resource,
  "The request body for database resource."
);
@@doc(
  SqlServerDatabaseResources.update::parameters.properties,
  "The requested database resource state."
);
