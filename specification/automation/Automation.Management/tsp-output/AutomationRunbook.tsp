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
@doc("Definition of the runbook type.")
@parentResource(AutomationAccount)
model AutomationRunbook is TrackedResource<RunbookProperties> {
  @doc("The runbook name.")
  @path
  @key("runbookName")
  @segment("runbooks")
  name: string;
}

@armResourceOperations
interface AutomationRunbooks {
  @doc("Retrieve the runbook identified by runbook name.")
  get is ArmResourceRead<AutomationRunbook>;
  @doc("Create the runbook identified by runbook name.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutomationRunbook>;
  @doc("Update the runbook identified by runbook name.")
  update is ArmResourcePatchSync<AutomationRunbook, RunbookProperties>;
  @doc("Delete the runbook by name.")
  delete is ArmResourceDeleteSync<AutomationRunbook>;
  @doc("Retrieve a list of runbooks.")
  listByAutomationAccount is ArmResourceListByParent<AutomationRunbook>;
  @doc("Undo draft edit to last known published state identified by runbook name.")
  undoEdit is ArmResourceActionSync<
    AutomationRunbook,
    {},
    RunbookDraftUndoEditResult
  >;
  @doc("Publish runbook draft.")
  publish is ArmResourceActionNoResponseContentAsync<AutomationRunbook, {}>;
  @doc("Resume the test job.")
  resume is ArmResourceActionSync<AutomationRunbook, {}, {}>;
  @doc("Stop the test job.")
  stop is ArmResourceActionSync<AutomationRunbook, {}, {}>;
  @doc("Suspend the test job.")
  suspend is ArmResourceActionSync<AutomationRunbook, {}, {}>;
  @doc("Retrieve the content of runbook draft identified by runbook name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft/content")
  @get
  GetContent is Azure.Core.Foundations.Operation<
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

      @doc("The runbook name.")
      @path
      runbookName: string;

      @doc("Accept header")
      @header
      accept: "text/powershell";
    },
    void
  >;

  @doc("Retrieve the runbook draft identified by runbook name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft")
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

      @doc("The runbook name.")
      @path
      runbookName: string;
    },
    RunbookDraft
  >;

  @doc("Retrieve the content of runbook identified by runbook name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/content")
  @get
  GetContent is Azure.Core.Foundations.Operation<
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

      @doc("The runbook name.")
      @path
      runbookName: string;

      @doc("Accept header")
      @header
      accept: "text/powershell";
    },
    void
  >;

  @doc("Retrieve a test job stream of the test job identified by runbook name and stream id.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft/testJob/streams/{jobStreamId}")
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

      @doc("The runbook name.")
      @path
      runbookName: string;

      @doc("The job stream id.")
      @path
      jobStreamId: string;
    },
    JobStream
  >;

  @doc("Retrieve a list of test job streams identified by runbook name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft/testJob/streams")
  @get
  ListByTestJob is Azure.Core.Foundations.Operation<
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

      @doc("The runbook name.")
      @path
      runbookName: string;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    },
    JobStreamListResult
  >;

  @doc("Retrieve the test job for the specified runbook.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft/testJob")
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

      @doc("The runbook name.")
      @path
      runbookName: string;
    },
    TestJob
  >;
}
