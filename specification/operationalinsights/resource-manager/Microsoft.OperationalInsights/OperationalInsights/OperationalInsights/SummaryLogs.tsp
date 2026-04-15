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

@armResourceOperations(#{omitTags: true})
interface SummaryLogsOperationGroup {
  /**
   * Gets Log Analytics workspace Summary rules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SummaryLogs_Get")
  @tag("SummaryRules")
  get is SummaryLogsOps.Read<SummaryLogs>;

  /**
   * Creates or updates Log Analytics workspace Summary rules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SummaryLogs_CreateOrUpdate")
  @tag("SummaryRules")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is SummaryLogsOps.CreateOrUpdateAsync<
    SummaryLogs,
    Response = (ArmResourceUpdatedResponse<SummaryLogs> &
      ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader) | ArmResourceCreatedResponse<
      SummaryLogs,
      LroHeaders = ArmCombinedLroHeaders &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Deletes Log Analytics workspace Summary rules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("SummaryLogs_Delete")
  @tag("SummaryRules")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is SummaryLogsOps.DeleteWithoutOkAsync<
    SummaryLogs,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets all summary rules for the specified Log Analytics workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SummaryLogs_ListByWorkspace")
  @tag("SummaryRules")
  listByWorkspace is SummaryLogsOps.List<SummaryLogs>;

  /**
   * Starts an inactive Summary rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SummaryLogs_Start")
  @tag("SummaryRules")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  start is SummaryLogsOps.ActionAsync<
    SummaryLogs,
    void,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = SummaryLogs> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Stops an active Summary rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SummaryLogs_Stop")
  @tag("SummaryRules")
  stop is SummaryLogsOps.ActionSync<SummaryLogs, void, OkResponse>;

  /**
   * Retries a failed Summary rule bin.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SummaryLogs_RetryBin")
  @tag("SummaryRules")
  @action("retrybin")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  retryBin is SummaryLogsOps.ActionAsync<
    SummaryLogs,
    SummaryLogsRetryBin,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = SummaryLogs> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;
}

alias SummaryLogsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Legacy.Provider;

    /**
     * The name of the workspace.
     */
    @path
    @segment("workspaces")
    @key("workspaceName")
    @minLength(4)
    @maxLength(63)
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    workspaceName: string;
  },
  {
    /**
     * The name of the summary logs. Must not contain '/'.
     */
    @path
    @segment("summaryLogs")
    @key("summaryLogsName")
    @pattern("[^/]+")
    summaryLogsName: string;
  }
>;

@@doc(SummaryLogs.name, "The name of the summary logs. Must not contain '/'.");
@@doc(SummaryLogs.properties, "Summary rule properties.");
@@doc(SummaryLogsOperationGroup.createOrUpdate::parameters.resource,
  "The parameters required to update summary rules properties."
);
@@doc(SummaryLogsOperationGroup.retryBin::parameters.body,
  "The parameters required to retry a Summary rule bin."
);
