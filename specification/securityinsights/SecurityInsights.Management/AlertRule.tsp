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
// FIXME: AlertRule has no properties property
/**
 * Alert rule.
 */
model AlertRule is Azure.ResourceManager.ProxyResource<{}> {
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

  /**
   * The kind of the alert rule
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: AlertRuleKind;
}

alias workspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface AlertRules {
  /**
   * Gets the alert rule.
   */
  get is ArmResourceRead<AlertRule>;

  /**
   * Creates or updates the alert rule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<AlertRule>;

  /**
   * Delete the alert rule.
   */
  delete is ArmResourceDeleteSync<AlertRule>;

  /**
   * Gets all alert rules.
   */
  list is ArmResourceListByParent<
    AlertRule,
    Response = ArmResponse<AlertRulesList>
  >;

  /**
   * triggers analytics rule run
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("alertRule_TriggerRuleRun")
  triggerRuleRun is ArmResourceActionAsyncBase<
    AlertRule,
    AnalyticsRuleRunTrigger,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<AlertRule>
  >;
}

@@doc(AlertRule.name, "Alert rule ID");
@@doc(AlertRules.createOrUpdate::parameters.resource, "The alert rule");
@@doc(AlertRules.triggerRuleRun::parameters.body,
  "The Analytics Rule Run Trigger parameter"
);
