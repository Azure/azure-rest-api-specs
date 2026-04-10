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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("kind")
model AlertRuleTemplate
  is Azure.ResourceManager.Legacy.DiscriminatedProxyResource<AlertRuleKind> {
  ...ResourceNameParameter<
    Resource = AlertRuleTemplate,
    KeyName = "alertRuleTemplateId",
    SegmentName = "alertRuleTemplates",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface AlertRuleTemplates {
  /**
   * Gets the alert rule template.
   */
  @tag("Alert Rule Templates")
  get is Extension.Read<
    OperationalInsights,
    AlertRuleTemplate,
    Error = CloudError
  >;

  /**
   * Gets all alert rule templates.
   */
  @tag("Alert Rule Templates")
  list is Extension.ListByTarget<
    OperationalInsights,
    AlertRuleTemplate,
    Response = ArmResponse<AlertRuleTemplatesList>,
    Error = CloudError
  >;
}

@@doc(AlertRuleTemplate.name, "Alert rule template ID");
