import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Kusto;
@doc("Class representing an attached database configuration.")
@parentResource(Cluster)
model AttachedDatabaseConfiguration
  is ProxyResource<AttachedDatabaseConfigurationProperties> {
  @doc("The name of the attached database configuration.")
  @pattern("^.*$")
  @key("attachedDatabaseConfigurationName")
  @segment("attachedDatabaseConfigurations")
  name: string;
}

@armResourceOperations
interface AttachedDatabaseConfigurations {
  @doc("Returns an attached database configuration.")
  get is ArmResourceRead<AttachedDatabaseConfiguration>;

  @doc("Creates or updates an attached database configuration.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AttachedDatabaseConfiguration>;

  @doc("Deletes the attached database configuration with the given name.")
  delete is ArmResourceDeleteAsync<AttachedDatabaseConfiguration>;

  @doc("Returns the list of attached database configurations of the given Kusto cluster.")
  listByCluster is ArmResourceListByParent<AttachedDatabaseConfiguration>;
}
