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

model AutomationRule is Azure.ResourceManager.ProxyResource<
  AutomationRuleProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = AutomationRule,
    KeyName = "automationRuleId",
    SegmentName = "automationRules",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations(#{ omitTags: true })
interface AutomationRules {
  /**
   * Gets the automation rule.
   */
  @tag("automationRules")
  get is Extension.Read<
    OperationalInsights,
    AutomationRule,
    Error = CloudError
  >;

  /**
   * Creates or updates the automation rule.
   */
  @tag("automationRules")
  createOrUpdate is Azure.ResourceManager.Legacy.Extension.CreateOrReplaceSync<
    OperationalInsights,
    AutomationRule,
    Error = CloudError,
    OptionalRequestBody = true
  >;

  /**
   * Delete the automation rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("automationRules")
  delete is Extension.DeleteSync<
    OperationalInsights,
    AutomationRule,
    Response =
      | ArmResponse<unknown>
      | (NoContentResponse & {
          #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
          @body body: unknown;
        }),
    Error = CloudError
  >;

  /**
   * Gets all automation rules.
   */
  @tag("automationRules")
  list is Extension.ListByTarget<
    OperationalInsights,
    AutomationRule,
    Response = ArmResponse<AutomationRulesList>,
    Error = CloudError
  >;
}

@@doc(AutomationRule.name, "Automation rule ID");
@@doc(AutomationRule.properties, "Automation rule properties");
@@doc(
  AutomationRules.createOrUpdate::parameters.resource,
  "The automation rule"
);
