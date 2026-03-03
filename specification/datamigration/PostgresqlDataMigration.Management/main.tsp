import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./PostgresqlModels.tsp";
import "./PostgresqlMigrationService.tsp";
import "./PostgresqlDatabaseMigration.tsp";
import "./PostgresqlRoutes.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.DataMigration Management Service" })
@versioned(Microsoft.DataMigration.Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.DataMigration;

enum Versions {
  v2026_03_03_preview: "2026-03-03-preview",
}

@doc("Operations interface for Microsoft.DataMigration")
interface Operations extends Azure.ResourceManager.Operations {}
