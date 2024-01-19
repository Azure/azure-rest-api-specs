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
@doc("Container Apps Job execution.")
@parentResource(Job)
model JobExecution is ProxyResource<{}> {
  @doc("Job execution name.")
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("jobExecutionName")
  @segment("executions")
  name: string;

  @doc("Current running State of the job")
  @visibility("read")
  status?: JobExecutionRunningState;

  @doc("Job execution start time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Job execution end time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Job's execution container.")
  template?: JobExecutionTemplate;
}

@armResourceOperations
interface JobExecutions {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get details of a single job execution")
  @operationId("JobExecution")
  jobExecution is ArmResourceRead<JobExecution>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a Container Apps Job's executions")
  @operationId("JobsExecutions_List")
  list is ArmResourceListByParent<
    JobExecution,
    {
      ...BaseParameters<JobExecution>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Terminates execution of a running container apps job")
  @operationId("Jobs_StopExecution")
  stopExecution is ArmResourceActionAsync<
    JobExecution,
    void,
    void,
    BaseParameters<JobExecution>,
    ArmLroLocationHeader
  >;
}
