import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./JobAgent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("A stored credential that can be used by a job to connect to target databases.")
@parentResource(JobAgent)
model JobCredential is ProxyResource<JobCredentialProperties> {
  @doc("The name of the credential.")
  @key("credentialName")
  @segment("credentials")
  name: string;
}

@armResourceOperations
interface JobCredentials {
  @doc("Gets a jobs credential.")
  get is ArmResourceRead<JobCredential>;

  @doc("Creates or updates a job credential.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<JobCredential>;

  @doc("Deletes a job credential.")
  delete is ArmResourceDeleteSync<JobCredential>;

  @doc("Gets a list of jobs credentials.")
  listByAgent is ArmResourceListByParent<JobCredential>;
}
