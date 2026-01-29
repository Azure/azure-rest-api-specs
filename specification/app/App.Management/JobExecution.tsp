import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Job.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Container Apps Job execution.
 */
@parentResource(Job)
model JobExecution
  is Azure.ResourceManager.ProxyResource<JobExecutionProperties> {
  ...ResourceNameParameter<
    Resource = JobExecution,
    KeyName = "jobExecutionName",
    SegmentName = "executions",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@armResourceOperations
interface JobExecutions {
  /**
   * Get details of a single job execution
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("JobExecution")
  jobExecution is ArmResourceRead<JobExecution>;

  /**
   * Get a Container Apps Job's executions
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("JobsExecutions_List")
  list is ArmResourceListByParent<
    JobExecution,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<ContainerAppJobExecutions>
  >;

  /**
   * Terminates execution of a running container apps job
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Jobs_StopExecution")
  @action("stop")
  stopExecution is ArmResourceActionAsync<JobExecution, void, OkResponse>;
}

@@doc(JobExecution.name, "Job execution name.");
@@doc(JobExecution.properties,
  "Container Apps Job execution specific properties."
);
