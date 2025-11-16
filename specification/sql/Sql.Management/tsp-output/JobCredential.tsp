import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./JobAgent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A stored credential that can be used by a job to connect to target databases.
 */
@parentResource(JobAgent)
model JobCredential is ProxyResource<JobCredentialProperties> {
  /**
   * The name of the credential.
   */
  @path
  @key("credentialName")
  @segment("credentials")
  name: string;
}

@armResourceOperations
interface JobCredentials {
  /**
   * Gets a jobs credential.
   */
  get is ArmResourceRead<JobCredential>;

  /**
   * Creates or updates a job credential.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<JobCredential>;

  /**
   * Deletes a job credential.
   */
  delete is ArmResourceDeleteSync<JobCredential>;

  /**
   * Gets a list of jobs credentials.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobCredentials_ListByAgent")
  listByAgent is ArmResourceListByParent<JobCredential>;
}

@@projectedName(JobCredentials.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(JobCredentials.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(JobCredentials.createOrUpdate::parameters.resource,
  "The requested job credential state."
);
