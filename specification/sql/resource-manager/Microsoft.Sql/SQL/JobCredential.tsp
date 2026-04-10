import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./JobAgent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A stored credential that can be used by a job to connect to target databases.
 */
@parentResource(JobAgent)
model JobCredential
  is Azure.ResourceManager.ProxyResource<JobCredentialProperties> {
  ...ResourceNameParameter<
    Resource = JobCredential,
    KeyName = "credentialName",
    SegmentName = "credentials",
    NamePattern = ""
  >;
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
  listByAgent is ArmResourceListByParent<JobCredential>;
}

@@doc(JobCredential.name, "The name of the credential.");
@@doc(JobCredential.properties, "Resource properties.");
@@doc(JobCredentials.createOrUpdate::parameters.resource,
  "The requested job credential state."
);
