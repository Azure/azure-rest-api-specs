import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * The triggered analytics rule run
 */
model TriggeredAnalyticsRuleRun
  is Azure.ResourceManager.ProxyResource<
    TriggeredAnalyticsRuleRunProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = TriggeredAnalyticsRuleRun,
    KeyName = "ruleRunId",
    SegmentName = "triggeredAnalyticsRuleRuns",
    NamePattern = ""
  >;
}

@armResourceOperations
interface triggeredAnalyticsRuleRun {
  /**
   * Gets the triggered analytics rule run.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("triggeredAnalyticsRuleRun_Get")
  get is Extension.Read<
    workspaceExternalResource,
    TriggeredAnalyticsRuleRun,
    Error = CloudError
  >;

  /**
   * Gets the triggered analytics rule runs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("getTriggeredAnalyticsRuleRuns_List")
  list is Extension.ListByTarget<
    workspaceExternalResource,
    TriggeredAnalyticsRuleRun,
    Response = ArmResponse<TriggeredAnalyticsRuleRuns>,
    Error = CloudError
  >;
}

@@doc(TriggeredAnalyticsRuleRun.name, "the triggered rule id");
@@doc(TriggeredAnalyticsRuleRun.properties,
  "The triggered analytics rule run Properties"
);
