import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

@armProviderNamespace
@service(#{ title: "Microsoft MaterializedViews Management Service" })
@doc("Microsoft MaterializedViews Management Service")
@versioned(Microsoft.MaterializedViews.Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.MaterializedViews;

/** The available API versions. */
enum Versions {
  /** 2025-04-01 version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2025_04_01: "2025-04-01",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A MaterializedView resource")
model MaterializedViewResource is TrackedResource<MaterializedViewProperties> {
  @pattern("^[a-zA-Z][a-zA-Z0-9-]{2,63}$")
  @key("materializedViewName")
  @segment("materializedViews")
  @doc("MaterializedView resource name")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@doc("The properties of MaterializedView resource")
model MaterializedViewProperties {
  @doc("Provisioning state of MaterializedView resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The definition of the materialized view")
  viewDefinition?: string;

  @doc("The refresh policy of the materialized view")
  refreshPolicy?: RefreshPolicy;

  @doc("The data source connection information")
  dataSource?: DataSourceInfo;
}

@doc("Provisioning state of the resource")
@lroStatus
union ProvisioningState {
  @doc("Resource has been created.")
  Succeeded: "Succeeded",

  @doc("Resource creation failed.")
  Failed: "Failed",

  @doc("Resource creation was canceled.")
  Canceled: "Canceled",

  @doc("This state indicates that the resource is being provisioned.")
  Provisioning: "Provisioning",

  @doc("This state indicates that the resource is being updated.")
  Updating: "Updating",

  @doc("This state indicates that the resource is being deleted.")
  Deleting: "Deleting",

  @doc("This state indicates that the operation on the resource has been accepted.")
  Accepted: "Accepted",

  string,
}

@doc("Refresh policy for the materialized view")
model RefreshPolicy {
  @doc("Whether the materialized view is automatically refreshed")
  isAutoRefresh?: boolean;

  @doc("Refresh interval in minutes")
  refreshIntervalMinutes?: int32;
}

@doc("Data source information for the materialized view")
model DataSourceInfo {
  @doc("The connection string to the data source")
  connectionString?: string;

  @doc("The type of data source")
  dataSourceType?: DataSourceType;
}

@doc("Type of data source")
union DataSourceType {
  @doc("SQL Server data source")
  SqlServer: "SqlServer",

  @doc("PostgreSQL data source")
  PostgreSQL: "PostgreSQL",

  @doc("Azure SQL Database")
  AzureSqlDatabase: "AzureSqlDatabase",

  string,
}

@armResourceOperations
interface MaterializedViews {
  get is ArmResourceRead<MaterializedViewResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MaterializedViewResource>;
  update is ArmTagsPatchAsync<MaterializedViewResource>;
  delete is ArmResourceDeleteWithoutOkAsync<MaterializedViewResource>;
  listByResourceGroup is ArmResourceListByParent<MaterializedViewResource>;
  listBySubscription is ArmListBySubscription<MaterializedViewResource>;

  @doc("Refresh a materialized view")
  @action("refresh")
  refresh is ArmResourceActionNoResponseContentAsync<
    MaterializedViewResource,
    void
  >;
}
