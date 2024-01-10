import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Automation;
@doc("Definition of the job.")
@parentResource(AutomationAccount)
model Job is ProxyResource<JobProperties> {
  @doc("The job name.")
  @key("jobName")
  @segment("jobs")
  name: string;
}

@armResourceOperations
@projectedName("client", "Job")
interface Jobs_Job {
  @doc("Retrieve the job identified by job name.")
  get is ArmResourceRead<
    Job,
    {
      ...BaseParameters<Job>;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    }
  >;

  @doc("Create a job of the runbook.")
  create is ArmResourceCreateOrReplaceSync<
    Job,
    {
      ...BaseParameters<Job>;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    }
  >;

  @doc("Retrieve a list of jobs.")
  listByAutomationAccount is ArmResourceListByParent<
    Job,
    {
      ...BaseParameters<Job>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    }
  >;

  @doc("Suspend the job identified by job name.")
  suspend is ArmResourceActionSync<
    Job,
    void,
    void,
    {
      ...BaseParameters<Job>;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    }
  >;

  @doc("Stop the job identified by jobName.")
  stop is ArmResourceActionSync<
    Job,
    void,
    void,
    {
      ...BaseParameters<Job>;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    }
  >;

  @doc("Resume the job identified by jobName.")
  resume is ArmResourceActionSync<
    Job,
    void,
    void,
    {
      ...BaseParameters<Job>;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    }
  >;

  @doc("Retrieve the job output identified by job name.")
  // FIXME: Job_GetOutput could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/jobs/{jobName}/output")
  @get
  GetOutput is Azure.Core.Foundations.Operation<
    {
      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("The name of the job to be created.")
      @path
      jobName: string;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;

      @doc("Accept header")
      @header
      accept: "text/plain";
    },
    void
  >;

  @doc("Retrieve the runbook content of the job identified by job name.")
  // FIXME: Job_GetRunbookContent could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/jobs/{jobName}/runbookContent")
  @get
  GetRunbookContent is Azure.Core.Foundations.Operation<
    {
      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("The job name.")
      @path
      jobName: string;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;

      @doc("Accept header")
      @header
      accept: "text/powershell";
    },
    void
  >;
}

@armResourceOperations
@projectedName("client", "JobStream")
interface Jobs_JobStream {
  @doc("Retrieve the job stream identified by job stream id.")
  // FIXME: JobStream_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/jobs/{jobName}/streams/{jobStreamId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("The job name.")
      @path
      jobName: string;

      @doc("The job stream id.")
      @path
      jobStreamId: string;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    },
    JobStream
  >;

  @doc("Retrieve a list of jobs streams identified by job name.")
  // FIXME: JobStream_ListByJob could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/jobs/{jobName}/streams")
  @get
  ListByJob is Azure.Core.Foundations.Operation<
    {
      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("The job name.")
      @path
      jobName: string;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    },
    JobStreamListResult
  >;
}
