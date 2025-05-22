import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../../../Common/ArmModels/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Evaluated sql entity resource.")
@parentResource(BusinessCase)
model EvaluatedSqlEntity is ProxyResource<EvaluatedSqlEntityProperties> {
  @doc("Business case Evaluated sql entity ARM name")
  @key("evaluatedSqlEntityName")
  @segment("evaluatedSqlEntities")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a hydrated resource with no PUT call."
@doc("Evaluated sql entity properties class.")
model EvaluatedSqlEntityProperties {
  @doc("Server name.")
  @visibility(Lifecycle.Read)
  serverName?: string;

  @doc("Activity state.")
  @visibility(Lifecycle.Read)
  activityState?: string;

  @doc("SQL Server version.")
  @visibility(Lifecycle.Read)
  sqlVersion?: string;

  @doc("SQL Server edition.")
  @visibility(Lifecycle.Read)
  sqlEdition?: string;

  @doc("Recommended Azure target.")
  @visibility(Lifecycle.Read)
  recommendedAzureTarget?: string;

  @doc("Qualifying offer.")
  @visibility(Lifecycle.Read)
  qualifyingOffer?: string;

  @doc("Is SQL Instance ready for migration.")
  @visibility(Lifecycle.Read)
  readyForMigration?: string;

  @doc("The virtualization type.")
  @visibility(Lifecycle.Read)
  virtualizationType?: string;

  @doc("DB count in instance.")
  @visibility(Lifecycle.Read)
  dbCount?: int32;

  @doc("End of Support status.")
  @visibility(Lifecycle.Read)
  supportStatus?: SupportabilityStatus;
}
