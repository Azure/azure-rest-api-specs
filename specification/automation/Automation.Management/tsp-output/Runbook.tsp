import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
@doc("Definition of the runbook type.")
@parentResource(AutomationAccount)
model Runbook is TrackedResource<RunbookProperties> {
  @doc("The runbook name.")
  @path
  @key("runbookName")
  @segment("runbooks")
  name: string;

  @doc("Gets or sets the etag of the resource.")
  etag?: string;
}

@armResourceOperations
interface Runbooks {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the runbook identified by runbook name.")
  @operationId("Runbook_Get")
  get is ArmResourceRead<Runbook>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create the runbook identified by runbook name.")
  @operationId("Runbook_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Runbook>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update the runbook identified by runbook name.")
  @operationId("Runbook_Update")
  update is ArmCustomPatchSync<Runbook, RunbookUpdateParameters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the runbook by name.")
  @operationId("Runbook_Delete")
  delete is ArmResourceDeleteSync<Runbook>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of runbooks.")
  @operationId("Runbook_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<Runbook>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Undo draft edit to last known published state identified by runbook name.")
  @operationId("RunbookDraft_UndoEdit")
  undoEdit is ArmResourceActionSync<Runbook, void, RunbookDraftUndoEditResult>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Publish runbook draft.")
  @operationId("Runbook_Publish")
  publish is ArmResourceActionNoResponseContentAsync<Runbook, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Resume the test job.")
  @operationId("TestJob_Resume")
  resume is ArmResourceActionSync<Runbook, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Stop the test job.")
  @operationId("TestJob_Stop")
  stop is ArmResourceActionSync<Runbook, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Suspend the test job.")
  @operationId("TestJob_Suspend")
  suspend is ArmResourceActionSync<Runbook, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RunbookDraft_GetContent")
  @doc("Retrieve the content of runbook draft identified by runbook name.")
  // FIXME: RunbookDraft_GetContent could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft/content")
  @get
  getContent is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RunbookDraft_Get")
  @doc("Retrieve the runbook draft identified by runbook name.")
  // FIXME: RunbookDraft_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft")
  @get
  get is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Runbook_GetContent")
  @doc("Retrieve the content of runbook identified by runbook name.")
  // FIXME: Runbook_GetContent could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/content")
  @get
  getContent is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TestJobStreams_Get")
  @doc("Retrieve a test job stream of the test job identified by runbook name and stream id.")
  // FIXME: TestJobStreams_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft/testJob/streams/{jobStreamId}")
  @get
  get is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TestJobStreams_ListByTestJob")
  @doc("Retrieve a list of test job streams identified by runbook name.")
  // FIXME: TestJobStreams_ListByTestJob could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft/testJob/streams")
  @get
  listByTestJob is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TestJob_Get")
  @doc("Retrieve the test job for the specified runbook.")
  // FIXME: TestJob_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft/testJob")
  @get
  get is Azure.Core.Foundations.Operation<
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

@@projectedName(Runbooks.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Runbooks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Runbooks.createOrUpdate::parameters.resource,
  "The create or update parameters for runbook. Provide either content link for a published runbook or draft, not both."
);
@@projectedName(Runbooks.update::parameters.properties, "json", "parameters");
@@extension(Runbooks.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Runbooks.update::parameters.properties,
  "The update parameters for runbook."
);
