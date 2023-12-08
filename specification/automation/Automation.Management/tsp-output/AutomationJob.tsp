import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Automation;
@doc("Definition of the job.")
@parentResource(AutomationAccount)
model AutomationJob is ProxyResource<JobProperties> {
  @doc("The job name.")
  @path
  @key("jobName")
  @segment("jobs")
  name: string;
}

@armResourceOperations
interface AutomationJobs {
  @doc("Retrieve the job identified by job name.")
  get is ArmResourceRead<
    AutomationJob,
    {
      ...BaseParameters<AutomationJob>;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    }
  >;
  @doc("Create a job of the runbook.")
  create is ArmResourceCreateOrReplaceSync<
    AutomationJob,
    {
      ...BaseParameters<AutomationJob>;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    }
  >;
  @doc("Retrieve a list of jobs.")
  listByAutomationAccount is ArmResourceListByParent<
    AutomationJob,
    {
      ...BaseParameters<AutomationJob>;

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
    AutomationJob,
    {},
    {},
    {
      ...BaseParameters<AutomationJob>;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    }
  >;
  @doc("Stop the job identified by jobName.")
  stop is ArmResourceActionSync<
    AutomationJob,
    {},
    {},
    {
      ...BaseParameters<AutomationJob>;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    }
  >;
  @doc("Resume the job identified by jobName.")
  resume is ArmResourceActionSync<
    AutomationJob,
    {},
    {},
    {
      ...BaseParameters<AutomationJob>;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    }
  >;
  @doc("Retrieve the job output identified by job name.")
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

  @doc("Retrieve the job stream identified by job stream id.")
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
