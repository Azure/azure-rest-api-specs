import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the runbook type.
 */
@parentResource(AutomationAccount)
model Runbook is Azure.ResourceManager.TrackedResource<RunbookProperties> {
  ...ResourceNameParameter<
    Resource = Runbook,
    KeyName = "runbookName",
    SegmentName = "runbooks",
    NamePattern = "^[a-zA-Z][a-zA-Z-_0-9]*$"
  >;

  /**
   * Gets or sets the etag of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface Runbooks {
  /**
   * Retrieve the runbook identified by runbook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Runbook_Get")
  get is ArmResourceRead<Runbook>;

  /**
   * Create the runbook identified by runbook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Runbook_CreateOrUpdate")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    Runbook,
    Request = RunbookCreateOrUpdateParameters
  >;

  /**
   * Update the runbook identified by runbook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Runbook_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Runbook, PatchModel = RunbookUpdateParameters>;

  /**
   * Delete the runbook by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Runbook_Delete")
  delete is ArmResourceDeleteSync<Runbook>;

  /**
   * Retrieve a list of runbooks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Runbook_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<Runbook>;

  /**
   * Retrieve the content of runbook draft identified by runbook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RunbookDraft_GetContent")
  @get
  @action("content")
  getContent is ArmResourceActionSync<
    Runbook,
    void,
    ArmResponse<binary & {
      @header
      contentType: "text/powershell";
    }>
  >;

  /**
   * Replaces the runbook draft content.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RunbookDraft_ReplaceContent")
  @put
  @action("content")
  replaceContent is ArmResourceActionAsync<
    Runbook,
    bytes,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Retrieve the runbook draft identified by runbook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RunbookDraft_Get")
  @get
  @action("draft")
  runbookDraftGet is ArmResourceActionSync<
    Runbook,
    void,
    ArmResponse<RunbookDraft>
  >;

  /**
   * Undo draft edit to last known published state identified by runbook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RunbookDraft_UndoEdit")
  undoEdit is ArmResourceActionSync<
    Runbook,
    void,
    ArmResponse<RunbookDraftUndoEditResult>
  >;

  /**
   * Publish runbook draft.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Runbook_Publish")
  publish is ArmResourceActionAsyncBase<
    Runbook,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Runbook>
  >;

  /**
   * Retrieve the content of runbook identified by runbook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Runbook_GetContent")
  @get
  @action("content")
  runbookGetContent is ArmResourceActionSync<
    Runbook,
    void,
    ArmResponse<binary & {
      @header
      contentType: "text/powershell";
    }>
  >;

  /**
   * Retrieve a test job stream of the test job identified by runbook name and stream id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TestJobStreams_Get")
  @get
  @action("{jobStreamId}")
  testJobStreamsGet is ArmResourceActionSync<
    Runbook,
    void,
    ArmResponse<JobStream>,
    Parameters = {
      /**
       * The job stream id.
       */
      @path
      jobStreamId: string;
    }
  >;

  /**
   * Retrieve a list of test job streams identified by runbook name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TestJobStreams_ListByTestJob")
  @list
  @get
  @action("streams")
  listByTestJob is ArmResourceActionSync<
    Runbook,
    void,
    ArmResponse<JobStreamListResult>,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Create a test job of the runbook.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TestJob_Create")
  @put
  @action("testJob")
  create is ArmResourceActionSync<
    Runbook,
    TestJobCreateParameters,
    ArmResourceCreatedSyncResponse<TestJob>
  >;

  /**
   * Retrieve the test job for the specified runbook.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TestJob_Get")
  @get
  @action("testJob")
  testJobGet is ArmResourceActionSync<Runbook, void, ArmResponse<TestJob>>;

  /**
   * Resume the test job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TestJob_Resume")
  resume is ArmResourceActionSync<Runbook, void, OkResponse>;

  /**
   * Stop the test job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TestJob_Stop")
  stop is ArmResourceActionSync<Runbook, void, OkResponse>;

  /**
   * Suspend the test job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TestJob_Suspend")
  suspend is ArmResourceActionSync<Runbook, void, OkResponse>;
}

@@doc(Runbook.name, "The runbook name.");
@@doc(Runbook.properties, "Gets or sets the runbook properties.");
@@doc(Runbooks.createOrUpdate::parameters.resource,
  "The create or update parameters for runbook. Provide either content link for a published runbook or draft, not both."
);
@@doc(Runbooks.update::parameters.properties,
  "The update parameters for runbook."
);
@@doc(Runbooks.replaceContent::parameters.body, "The runbook draft content.");
@@doc(Runbooks.create::parameters.body,
  "The parameters supplied to the create test job operation."
);
