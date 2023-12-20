import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServerJobAgent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A stored credential that can be used by a job to connect to target databases.")
@parentResource(SqlServerJobAgent)
model SqlServerJobCredential is ProxyResource<JobCredentialProperties> {
  @doc("The name of the credential.")
  @path
  @key("credentialName")
  @segment("credentials")
  name: string;
}

@armResourceOperations
interface SqlServerJobCredentials {
  @doc("Gets a jobs credential.")
  get is ArmResourceRead<SqlServerJobCredential>;
  @doc("Creates or updates a job credential.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SqlServerJobCredential>;
  @doc("Deletes a job credential.")
  delete is ArmResourceDeleteSync<SqlServerJobCredential>;
  @doc("Gets a list of jobs credentials.")
  listByAgent is ArmResourceListByParent<SqlServerJobCredential>;
}
