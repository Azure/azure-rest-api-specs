import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;

/**
 * Alert rule.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("kind")
model AlertRule
  is Azure.ResourceManager.Legacy.DiscriminatedProxyResource<AlertRuleKind> {
  ...ResourceNameParameter<
    Resource = AlertRule,
    KeyName = "ruleId",
    SegmentName = "alertRules",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations(#{ omitTags: true })
interface AlertRules {
  /**
   * Gets the alert rule.
   */
  @tag("Alert Rules")
  get is Extension.Read<OperationalInsights, AlertRule, Error = CloudError>;

  /**
   * Creates or updates the alert rule.
   */
  @tag("Alert Rules")
  createOrUpdate is Extension.CreateOrReplaceSync<
    OperationalInsights,
    AlertRule,
    Error = CloudError
  >;

  /**
   * Delete the alert rule.
   */
  @tag("Alert Rules")
  delete is Extension.DeleteSync<
    OperationalInsights,
    AlertRule,
    Error = CloudError
  >;

  /**
   * Gets all alert rules.
   */
  @tag("Alert Rules")
  list is Extension.ListByTarget<
    OperationalInsights,
    AlertRule,
    Response = ArmResponse<AlertRulesList>,
    Error = CloudError
  >;

  /**
   * triggers analytics rule run
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("alertRule_TriggerRuleRun")
  @tag("trigger analytics rule run")
  triggerRuleRun is Extension.ActionAsyncBase<
    OperationalInsights,
    AlertRule,
    Request = AnalyticsRuleRunTrigger,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = AlertRule>>,
    Error = ErrorResponse
  >;
}

@@doc(AlertRule.name, "Alert rule ID");
@@doc(AlertRules.createOrUpdate::parameters.resource, "The alert rule");
