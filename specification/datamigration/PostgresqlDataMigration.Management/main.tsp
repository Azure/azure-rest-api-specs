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
  @Azure.Core.previewVersion
  v2025_01_10_preview: "2025-01-10-preview",
}

@doc("Operations interface for Microsoft.DataMigration")
interface Operations extends Azure.ResourceManager.Operations {}
