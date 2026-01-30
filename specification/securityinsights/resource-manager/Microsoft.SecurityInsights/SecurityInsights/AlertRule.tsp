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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@discriminator("kind")
model AlertRule
  is Azure.ResourceManager.Legacy.DiscriminatedExtensionResource<AlertRuleKind> {
  ...ResourceNameParameter<
    Resource = AlertRule,
    KeyName = "ruleId",
    SegmentName = "alertRules",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface AlertRules {
  /**
   * Gets the alert rule.
   */
  get is Extension.Read<OperationalInsights, AlertRule, Error = CloudError>;

  /**
   * Creates or updates the alert rule.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    OperationalInsights,
    AlertRule,
    Error = CloudError
  >;

  /**
   * Delete the alert rule.
   */
  delete is Extension.DeleteSync<
    OperationalInsights,
    AlertRule,
    Error = CloudError
  >;

  /**
   * Gets all alert rules.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    AlertRule,
    Response = ArmResponse<AlertRulesList>,
    Error = CloudError
  >;

  /**
   * triggers analytics rule run
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("alertRule_TriggerRuleRun")
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
