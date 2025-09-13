import "../../Common/ArmModels/AzureResourceProperties.tsp";
import "../Enums/Enums.tsp";
import "../../Common/ArmModels/MigrateProject.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@added(ApiVersions.v2025_03_30_preview)
@doc("Migration Entity Group resource.")
@parentResource(MigrateProject)
model MigrationEntityGroup is ProxyResource<MigrationEntityGroupProperties> {
  @doc("Migration Entity Group ARM name")
  @key("migrationEntityGroupName")
  @segment("migrationEntityGroups")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;

  ...EntityTagProperty;
}

@doc("Migration Entity Group Properties class.")
model MigrationEntityGroupProperties is AzureResourceProperties {
  @doc("Application id ")
  applicationId: armResourceIdentifier<[
    {
      type: "Microsoft.ApplicationMigration/discoveryHubs/applications";
    }
  ]>;

  @doc("Display Name of the Workload.")
  applicationDisplayName: string;

  @doc("Associated Assessment Id")
  associatedAssessmentIds?: armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/assessmentProjects";
    }
  ]>;

  @doc("associated Wave Id")
  associatedWaveIds?: Array<armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/waves";
    }
  ]>>;

  @doc("Migration Entity Group Status")
  executionStatus: MigrationEntityGroupExecutionStatus;

  @doc("Execution Start Date")
  executionStartDate: string;
}
