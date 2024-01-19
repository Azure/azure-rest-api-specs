import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("A managed database restore details.")
@parentResource(ManagedDatabase)
model ManagedDatabaseRestoreDetailsResult
  is ProxyResource<ManagedDatabaseRestoreDetailsProperties> {
  @doc("The name of the restore details to retrieve.")
  @path
  @key("restoreDetailsName")
  @segment("restoreDetails")
  name: RestoreDetailsName;
}

@armResourceOperations
interface ManagedDatabaseRestoreDetailsResults {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets managed database restore details.")
  @operationId("ManagedDatabaseRestoreDetails_Get")
  get is ArmResourceRead<ManagedDatabaseRestoreDetailsResult>;
}
