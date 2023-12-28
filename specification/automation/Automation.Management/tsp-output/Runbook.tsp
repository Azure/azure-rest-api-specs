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
model Runbook is TrackedResource<RunbookProperties> {
  @doc("The runbook name.")
  @key("runbookName")
  @segment("runbooks")
  name: string;

  @doc("Gets or sets the etag of the resource.")
  etag?: string;
}

@armResourceOperations
interface Runbook {
  @doc("Retrieve the runbook identified by runbook name.")
  get is ArmResourceRead<Runbook>;
  @doc("Create the runbook identified by runbook name.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Runbook>;
  @doc("Update the runbook identified by runbook name.")
  update is ArmCustomPatchSync<Runbook, RunbookUpdateParameters>;
  @doc("Delete the runbook by name.")
  delete is ArmResourceDeleteSync<Runbook>;
  @doc("Retrieve a list of runbooks.")
  listByAutomationAccount is ArmResourceListByParent<Runbook>;
  @doc("Publish runbook draft.")
  publish is ArmResourceActionNoResponseContentAsync<Runbook, void>;
  @doc("Retrieve the content of runbook identified by runbook name.")
  // FIXME: Runbook_GetContent could not be converted to a resource operation
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
}

@armResourceOperations
interface RunbookDraft {
  @doc("Undo draft edit to last known published state identified by runbook name.")
  undoEdit is ArmResourceActionSync<Runbook, void, RunbookDraftUndoEditResult>;
  @doc("Retrieve the content of runbook draft identified by runbook name.")
  // FIXME: RunbookDraft_GetContent could not be converted to a resource operation
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
  // FIXME: RunbookDraft_Get could not be converted to a resource operation
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
}

@armResourceOperations
interface TestJob {
  @doc("Resume the test job.")
  resume is ArmResourceActionSync<Runbook, void, void>;
  @doc("Stop the test job.")
  stop is ArmResourceActionSync<Runbook, void, void>;
  @doc("Suspend the test job.")
  suspend is ArmResourceActionSync<Runbook, void, void>;
  @doc("Retrieve the test job for the specified runbook.")
  // FIXME: TestJob_Get could not be converted to a resource operation
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

@armResourceOperations
interface TestJobStreams {
  @doc("Retrieve a test job stream of the test job identified by runbook name and stream id.")
  // FIXME: TestJobStreams_Get could not be converted to a resource operation
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
  // FIXME: TestJobStreams_ListByTestJob could not be converted to a resource operation
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
}
