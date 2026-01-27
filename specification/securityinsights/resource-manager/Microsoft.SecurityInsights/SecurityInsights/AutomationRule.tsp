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

model AutomationRule
  is Azure.ResourceManager.ProxyResource<AutomationRuleProperties, false> {
  ...ResourceNameParameter<
    Resource = AutomationRule,
    KeyName = "automationRuleId",
    SegmentName = "automationRules",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

// Added manually only to fix optional request body
alias AutomationRuleOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.OperationalInsights";

    /**
     * The name of the workspace.
     */
    @segment("workspaces")
    @key
    @path
    @minLength(1)
    @maxLength(90)
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    workspaceName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<AutomationRule>;
  },
  {
    ...Extension.ExtensionProviderNamespace<AutomationRule>;

    /**
     * The automation rule ID.
     */
    @path
    @key
    @segment("automationRules")
    automationRuleId: string;
  }
>;

@armResourceOperations
interface AutomationRules {
  /**
   * Gets the automation rule.
   */
  get is Extension.Read<
    OperationalInsights,
    AutomationRule,
    Error = CloudError
  >;

  /**
   * Creates or updates the automation rule.
   */
  createOrUpdate is AutomationRuleOps.CreateOrUpdateSync<
    AutomationRule,
    OptionalRequestBody = true,
    ErrorType = CloudError
  >;

  /**
   * Delete the automation rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "For backward compatibility"
  delete is Extension.DeleteSync<
    OperationalInsights,
    AutomationRule,
    Response = ArmResponse<{}> | (NoContentResponse & {
      @body body: {};
    }),
    Error = CloudError
  >;

  /**
   * Gets all automation rules.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    AutomationRule,
    Response = ArmResponse<AutomationRulesList>,
    Error = CloudError
  >;
}

@@doc(AutomationRule.name, "Automation rule ID");
@@doc(AutomationRule.properties, "Automation rule properties");
@@doc(AutomationRules.createOrUpdate::parameters.resource,
  "The automation rule"
);
