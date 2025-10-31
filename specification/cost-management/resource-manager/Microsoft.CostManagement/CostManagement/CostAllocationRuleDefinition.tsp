import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CostManagement;
/**
 * The cost allocation rule model definition
 */
@tenantResource
model CostAllocationRuleDefinition
  is Azure.ResourceManager.ProxyResource<CostAllocationRuleProperties> {
  ...ResourceNameParameter<
    Resource = CostAllocationRuleDefinition,
    KeyName = "ruleName",
    SegmentName = "costAllocationRules",
    NamePattern = "[A-Za-z0-9\\-_]+"
  >;
}

alias CostAllocationRuleDefinitionsOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.Billing";

    /**
     * BillingAccount ID
     */
    @path
    @segment("billingAccounts")
    billingAccountId: string;
  },
  {
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    ...Azure.ResourceManager.Legacy.Provider;

    /**
     * Cost allocation rule name. The name cannot include spaces or any non alphanumeric characters other than '_' and '-'. The max length is 260 characters.
     */
    @path
    @segment("costAllocationRules")
    @pattern("[A-Za-z0-9\\-_]+")
    ruleName: string;
  }
>;

@armResourceOperations
interface CostAllocationRuleDefinitions {
  /**
   * Get a cost allocation rule by rule name and billing account or enterprise enrollment.
   */
  get is CostAllocationRuleDefinitionsOps.Read<
    CostAllocationRuleDefinition,
    ErrorType = ErrorResponse
  >;

  /**
   * Create/Update a rule to allocate cost between different resources within a billing account or enterprise enrollment.
   */
  createOrUpdate is CostAllocationRuleDefinitionsOps.CreateOrUpdateSync<
    CostAllocationRuleDefinition,
    ErrorType = ErrorResponse
  >;

  /**
   * Delete cost allocation rule for billing account or enterprise enrollment.
   */
  delete is CostAllocationRuleDefinitionsOps.DeleteSync<
    CostAllocationRuleDefinition,
    ErrorType = ErrorResponse
  >;

  /**
   * Get the list of all cost allocation rules for a billing account or enterprise enrollment.
   */
  list is CostAllocationRuleDefinitionsOps.List<
    CostAllocationRuleDefinition,
    Response = ArmResponse<CostAllocationRuleList>,
    ErrorType = ErrorResponse
  >;
}

@@doc(CostAllocationRuleDefinition.name,
  "Cost allocation rule name. The name cannot include spaces or any non alphanumeric characters other than '_' and '-'. The max length is 260 characters."
);
@@doc(CostAllocationRuleDefinition.properties,
  "Cost allocation rule properties"
);
@@doc(CostAllocationRuleDefinitions.createOrUpdate::parameters.resource,
  "Cost allocation rule to be created or updated"
);
