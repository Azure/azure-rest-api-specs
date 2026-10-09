import "../common.tsp";
import "./dbSystem.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@added(Versions.v20260401_preview)
@doc("DatabaseEdition resource definition")
@parentResource(SubscriptionLocationResource)
model DatabaseEdition is ProxyResource<DatabaseEditionProperties> {
  @doc("DatabaseEdition name")
  @key("databaseeditionname")
  @path
  @segment("databaseEditions")
  @pattern(".*")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource. No provisioning state provided."
@added(Versions.v20260401_preview)
@doc("DatabaseEdition resource model")
model DatabaseEditionProperties {
  @doc("The Oracle database edition.")
  databaseEdition: DbSystemDatabaseEditionType;
}
