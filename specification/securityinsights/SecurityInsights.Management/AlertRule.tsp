import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./virtualResource.tsp";

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
   * The alert rule kind
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: AlertRuleKind;
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
    Error = CloudError
  >;
}

@@doc(AlertRule.name, "Alert rule ID");
@@doc(AlertRules.createOrUpdate::parameters.resource, "The alert rule");
