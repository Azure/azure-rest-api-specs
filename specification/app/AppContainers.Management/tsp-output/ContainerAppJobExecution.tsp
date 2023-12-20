import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerAppJob.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppContainers;
// FIXME: ContainerAppJobExecution has no properties property
@doc("Container Apps Job execution.")
@parentResource(ContainerAppJob)
model ContainerAppJobExecution is ProxyResource<{}> {
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
interface ContainerAppJobExecutions {
  @doc("Get details of a single job execution")
  jobExecution is ArmResourceRead<ContainerAppJobExecution>;
  @doc("Get a Container Apps Job's executions")
  list is ArmResourceListByParent<
    ContainerAppJobExecution,
    {
      ...BaseParameters<ContainerAppJobExecution>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Terminates execution of a running container apps job")
  stopExecution is ArmResourceActionAsync<ContainerAppJobExecution, void, void>;
}
