import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("A restorable dropped managed database resource.")
@parentResource(ManagedInstance)
model RestorableDroppedManagedDatabase
  is TrackedResource<RestorableDroppedManagedDatabaseProperties> {
  @key("restorableDroppedDatabaseId")
  @segment("restorableDroppedDatabases")
  name: string;
}

@armResourceOperations
interface RestorableDroppedManagedDatabases {
  @doc("Gets a restorable dropped managed database.")
  get is ArmResourceRead<RestorableDroppedManagedDatabase>;

  @doc("Gets a list of restorable dropped managed databases.")
  listByInstance is ArmResourceListByParent<RestorableDroppedManagedDatabase>;
}
