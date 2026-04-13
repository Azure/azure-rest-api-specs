import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
/**
 * Workspace data summary rules definition.
 */
model SummaryLogs
  is Azure.ResourceManager.ProxyResource<SummaryLogsProperties> {
  ...ResourceNameParameter<
    Resource = SummaryLogs,
    KeyName = "summaryLogsName",
    SegmentName = "summaryLogs",
    NamePattern = "[^/]+"
  >;
}

@armResourceOperations
interface SummaryLogsOperationGroup {
  /**
   * Gets Log Analytics workspace Summary rules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SummaryLogs_Get")
  get is ArmResourceRead<SummaryLogs>;

  /**
   * Creates or updates Log Analytics workspace Summary rules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SummaryLogs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SummaryLogs>;

  /**
   * Deletes Log Analytics workspace Summary rules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("SummaryLogs_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SummaryLogs,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets all summary rules for the specified Log Analytics workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SummaryLogs_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<SummaryLogs>;

  /**
   * Starts an inactive Summary rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SummaryLogs_Start")
  start is ArmResourceActionAsyncBase<
    SummaryLogs,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = SummaryLogs> &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SummaryLogs>
  >;

  /**
   * Stops an active Summary rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SummaryLogs_Stop")
  stop is ArmResourceActionSync<SummaryLogs, void, OkResponse>;

  /**
   * Retries a failed Summary rule bin.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SummaryLogs_RetryBin")
  @action("retrybin")
  retryBin is ArmResourceActionAsyncBase<
    SummaryLogs,
    SummaryLogsRetryBin,
    ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = SummaryLogs> &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SummaryLogs>
  >;
}

@@doc(SummaryLogs.name, "The name of the summary logs. Must not contain '/'.");
@@doc(SummaryLogs.properties, "Summary rule properties.");
@@doc(SummaryLogsOperationGroup.createOrUpdate::parameters.resource,
  "The parameters required to update summary rules properties."
);
@@doc(SummaryLogsOperationGroup.retryBin::parameters.body,
  "The parameters required to retry a Summary rule bin."
);
