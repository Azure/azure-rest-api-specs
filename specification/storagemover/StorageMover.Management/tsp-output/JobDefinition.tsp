import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageMover;
/**
 * The Job Definition resource.
 */
@parentResource(Project)
model JobDefinition is ProxyResource<JobDefinitionProperties> {
  /**
   * The name of the Job Definition resource.
   */
  @path
  @key("jobDefinitionName")
  @segment("jobDefinitions")
  name: string;
}

@armResourceOperations
interface JobDefinitions {
  /**
   * Gets a Job Definition resource.
   */
  get is ArmResourceRead<JobDefinition>;

  /**
   * Creates or updates a Job Definition resource, which contains configuration for a single unit of managed data transfer.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<JobDefinition>;

  /**
   * Updates properties for a Job Definition resource. Properties not specified in the request body will be unchanged.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<JobDefinition, JobDefinitionUpdateParameters>;

  /**
   * Deletes a Job Definition resource.
   */
  delete is ArmResourceDeleteAsync<
    JobDefinition,
    BaseParameters<JobDefinition>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all Job Definitions in a Project.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobDefinitions_List")
  list is ArmResourceListByParent<JobDefinition>;

  /**
   * Requests an Agent to start a new instance of this Job Definition, generating a new Job Run resource.
   */
  startJob is ArmResourceActionSync<JobDefinition, void, JobRunResourceId>;

  /**
   * Requests the Agent of any active instance of this Job Definition to stop.
   */
  stopJob is ArmResourceActionSync<JobDefinition, void, JobRunResourceId>;
}

@@projectedName(JobDefinitions.createOrUpdate::parameters.resource,
  "json",
  "jobDefinition"
);
@@extension(JobDefinitions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "jobDefinition"
);
@@doc(JobDefinitions.createOrUpdate::parameters.resource, "");
@@projectedName(JobDefinitions.update::parameters.properties,
  "json",
  "jobDefinition"
);
@@extension(JobDefinitions.update::parameters.properties,
  "x-ms-client-name",
  "jobDefinition"
);
@@doc(JobDefinitions.update::parameters.properties, "");
