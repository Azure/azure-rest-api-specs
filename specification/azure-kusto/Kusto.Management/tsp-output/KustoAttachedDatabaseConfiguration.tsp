import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./KustoCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Kusto;
@doc("Class representing an attached database configuration.")
@parentResource(KustoCluster)
model KustoAttachedDatabaseConfiguration
  is ProxyResource<AttachedDatabaseConfigurationProperties> {
  @doc("The name of the attached database configuration.")
  @pattern("^.*$")
  @path
  @key("attachedDatabaseConfigurationName")
  @segment("attachedDatabaseConfigurations")
  name: string;
}

@armResourceOperations
interface KustoAttachedDatabaseConfigurations {
  @doc("Returns an attached database configuration.")
  get is ArmResourceRead<KustoAttachedDatabaseConfiguration>;
  @doc("Creates or updates an attached database configuration.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KustoAttachedDatabaseConfiguration>;
  @doc("Deletes the attached database configuration with the given name.")
  delete is ArmResourceDeleteAsync<KustoAttachedDatabaseConfiguration>;
  @doc("Returns the list of attached database configurations of the given Kusto cluster.")
  listByCluster is ArmResourceListByParent<KustoAttachedDatabaseConfiguration>;
}
