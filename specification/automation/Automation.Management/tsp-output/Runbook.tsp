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
/**
 * Definition of the runbook type.
 */
@parentResource(AutomationAccount)
model Runbook is TrackedResource<RunbookProperties> {
  /**
   * The runbook name.
   */
  @path
  @key("runbookName")
  @segment("runbooks")
  name: string;

  /**
   * Gets or sets the etag of the resource.
   */
  etag?: string;
}

@armResourceOperations
interface Runbooks {
  /**
   * Retrieve the runbook identified by runbook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Runbook_Get")
  get is ArmResourceRead<Runbook>;

  /**
   * Create the runbook identified by runbook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Runbook_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Runbook>;

  /**
   * Update the runbook identified by runbook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Runbook_Update")
  update is ArmCustomPatchSync<Runbook, RunbookUpdateParameters>;

  /**
   * Delete the runbook by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Runbook_Delete")
  delete is ArmResourceDeleteSync<Runbook>;

  /**
   * Retrieve a list of runbooks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Runbook_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<Runbook>;

  /**
   * Undo draft edit to last known published state identified by runbook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RunbookDraft_UndoEdit")
  undoEdit is ArmResourceActionSync<Runbook, void, RunbookDraftUndoEditResult>;

  /**
   * Publish runbook draft.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Runbook_Publish")
  publish is ArmResourceActionNoResponseContentAsync<Runbook, void>;

  /**
   * Resume the test job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TestJob_Resume")
  resume is ArmResourceActionSync<Runbook, void, void>;

  /**
   * Stop the test job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TestJob_Stop")
  stop is ArmResourceActionSync<Runbook, void, void>;

  /**
   * Suspend the test job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TestJob_Suspend")
  suspend is ArmResourceActionSync<Runbook, void, void>;

  /**
   * Retrieve the content of runbook draft identified by runbook name.
   */
  // FIXME: RunbookDraft_GetContent could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RunbookDraft_GetContent")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft/content")
  @get
  getContent is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The runbook name.
       */
      @path
      runbookName: string;

      /**
       * Accept header
       */
      @header
      accept: "text/powershell";
    },
    void
  >;

  /**
   * Retrieve the runbook draft identified by runbook name.
   */
  // FIXME: RunbookDraft_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RunbookDraft_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The runbook name.
       */
      @path
      runbookName: string;
    },
    RunbookDraft
  >;

  /**
   * Retrieve the content of runbook identified by runbook name.
   */
  // FIXME: Runbook_GetContent could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Runbook_GetContent")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/content")
  @get
  getContent is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The runbook name.
       */
      @path
      runbookName: string;

      /**
       * Accept header
       */
      @header
      accept: "text/powershell";
    },
    void
  >;

  /**
   * Retrieve a test job stream of the test job identified by runbook name and stream id.
   */
  // FIXME: TestJobStreams_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TestJobStreams_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft/testJob/streams/{jobStreamId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The runbook name.
       */
      @path
      runbookName: string;

      /**
       * The job stream id.
       */
      @path
      jobStreamId: string;
    },
    JobStream
  >;

  /**
   * Retrieve a list of test job streams identified by runbook name.
   */
  // FIXME: TestJobStreams_ListByTestJob could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TestJobStreams_ListByTestJob")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft/testJob/streams")
  @get
  listByTestJob is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The runbook name.
       */
      @path
      runbookName: string;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    JobStreamListResult
  >;

  /**
   * Retrieve the test job for the specified runbook.
   */
  // FIXME: TestJob_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TestJob_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/runbooks/{runbookName}/draft/testJob")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The runbook name.
       */
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
