import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./JobDefinition.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageMover;
/**
 * The Job Run resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(JobDefinition)
@Azure.ResourceManager.Private.armResourceInternal(JobRunProperties)
@includeInapplicableMetadataInPayload(false)
model JobRun extends ProxyResourceBase {
  /**
   * The name of the Job Run resource.
   */
  @path
  @key("jobRunName")
  @segment("jobRuns")
  name: string;

  /**
   * Job run properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: JobRunProperties;
}

@armResourceOperations
interface JobRuns {
  /**
   * Gets a Job Run resource.
   */
  get is ArmResourceRead<JobRun>;

  /**
   * Lists all Job Runs in a Job Definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobRuns_List")
  list is ArmResourceListByParent<JobRun>;
}
