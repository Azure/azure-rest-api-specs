import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace GovernanceAPI;
/**
 * Governance rule over a given scope
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model GovernanceRule
  is Azure.ResourceManager.ExtensionResource<GovernanceRuleProperties> {
  ...ResourceNameParameter<
    Resource = GovernanceRule,
    KeyName = "ruleId",
    SegmentName = "governanceRules",
    NamePattern = ""
  >;
}

alias GovernanceRuleOperationResultsOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /**
     * The scope of the governance rule.
     */
    @path(#{ allowReserved: true })
    @key
    scope: string;

    /**
     * The provider namespace.
     */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";
  },
  {},
  {
    /**
     * The governance rule key.
     */
    @path
    @segment("governanceRules")
    @key
    ruleId: string;

    /**
     * The governance rule long running operation unique key.
     */
    @path
    @segment("operationResults")
    @key
    operationId: string;
  }
>;

@armResourceOperations
interface GovernanceRules {
  /**
   * Get a specific governance rule for the requested scope by ruleId
   */
  get is Azure.ResourceManager.Extension.Read<
    Azure.ResourceManager.Extension.ScopeParameter,
    GovernanceRule,
    Error = CloudError
  >;

  /**
   * Creates or updates a governance rule over a given scope
   */
  createOrUpdate is Azure.ResourceManager.Extension.CreateOrReplaceSync<
    Azure.ResourceManager.Extension.ScopeParameter,
    GovernanceRule,
    Error = CloudError
  >;

  /**
   * Delete a Governance rule over a given scope
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is Azure.ResourceManager.Extension.DeleteWithoutOkAsync<
    Azure.ResourceManager.Extension.ScopeParameter,
    GovernanceRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Get a list of all relevant governance rules over a scope
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.ScopeParameter,
    GovernanceRule,
    Response = ArmResponse<GovernanceRuleList>,
    Error = CloudError
  >;

  /**
   * Execute a governance rule
   */
  execute is Azure.ResourceManager.Extension.ActionAsyncBase<
    Azure.ResourceManager.Extension.ScopeParameter,
    GovernanceRule,
    ExecuteGovernanceRuleParams,
    ArmAcceptedLroResponse,
    OptionalRequestBody = true,
    Error = CloudError
  >;

  /**
   * Get governance rules long run operation result for the requested scope by ruleId and operationId
   */
  @get
  operationResults is GovernanceRuleOperationResultsOps.Read<
    OperationResult,
    Response = ArmResponse<OperationResult> | (AcceptedResponse & {
      @doc("Location URL for the execution status")
      @header("Location")
      location: string;
    }),
    ErrorType = CloudError
  >;
}

@@doc(GovernanceRule.name,
  "The governance rule key - unique key for the standard governance rule (GUID)"
);
@@doc(GovernanceRule.properties, "Properties of a governance rule");
@@doc(GovernanceRules.createOrUpdate::parameters.resource,
  "Governance rule over a given scope"
);
@@doc(GovernanceRules.execute::parameters.body,
  "Execute governance rule over a given scope"
);



