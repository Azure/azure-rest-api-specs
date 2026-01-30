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
 * Alert rule template.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
model AlertRuleTemplate
  is Azure.ResourceManager.Legacy.DiscriminatedExtensionResource<AlertRuleKind> {
  ...ResourceNameParameter<
    Resource = AlertRuleTemplate,
    KeyName = "alertRuleTemplateId",
    SegmentName = "alertRuleTemplates",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AlertRuleTemplates {
  /**
   * Gets the alert rule template.
   */
  get is Extension.Read<
    OperationalInsights,
    AlertRuleTemplate,
    Error = CloudError
  >;

  /**
   * Gets all alert rule templates.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    AlertRuleTemplate,
    Response = ArmResponse<AlertRuleTemplatesList>,
    Error = CloudError
  >;
}

@@doc(AlertRuleTemplate.name, "Alert rule template ID");
