import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Job.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
// FIXME: JobExecution has no properties property
/**
 * Container Apps Job execution.
 */
@parentResource(Job)
model JobExecution is ProxyResource<{}> {
  /**
   * Job execution name.
   */
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("jobExecutionName")
  @segment("executions")
  @visibility("read")
  name: string;

  /**
   * Current running State of the job
   */
  @visibility("read")
  status?: JobExecutionRunningState;

  /**
   * Job execution start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Job execution end time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Job's execution container.
   */
  template?: JobExecutionTemplate;
}

@armResourceOperations
interface JobExecutions {
  /**
   * Get details of a single job execution
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobExecution")
  jobExecution is ArmResourceRead<JobExecution>;

  /**
   * Get a Container Apps Job's executions
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobsExecutions_List")
  list is ArmResourceListByParent<
    JobExecution,
    {
      ...BaseParameters<JobExecution>;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Terminates execution of a running container apps job
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Jobs_StopExecution")
  stopExecution is ArmResourceActionAsync<
    JobExecution,
    void,
    void,
    BaseParameters<JobExecution>,
    ArmLroLocationHeader
  >;
}
