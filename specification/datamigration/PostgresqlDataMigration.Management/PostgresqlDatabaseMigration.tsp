import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./PostgresqlModels.tsp";
import "./PostgresqlMigrationService.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

@armProviderNamespace
namespace Microsoft.DataMigration;

@doc("A database migration resource.")
@resource("databaseMigrations")
@parentResource(MigrationService)
model DatabaseMigration is ProxyResource<DatabaseMigrationProperties> {
  @doc("The database migration identifier.")
  @key("databaseMigrationId")
  @segment("databaseMigrations")
  @path
  @pattern("^[a-zA-Z0-9-_]*$")
  name: string;
}
