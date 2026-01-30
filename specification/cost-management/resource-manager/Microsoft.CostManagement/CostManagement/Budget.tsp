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
 * A budget resource.
 */
model Budget is Azure.ResourceManager.ExtensionResource<BudgetProperties> {
  ...ResourceNameParameter<
    Resource = Budget,
    KeyName = "budgetName",
    SegmentName = "budgets",
    NamePattern = "^[a-zA-Z0-9_-]+$"
  >;

  /**
   * eTag of the resource. To handle concurrent update scenario, this field will be used to determine whether the user is updating the latest version or not.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: Azure.Core.eTag;
}

@armResourceOperations
interface Budgets {
  /**
   * Gets the budget for the scope by budget name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/CostManagement/")
  get is Extension.Read<
    Extension.ScopeParameter,
    Budget,
    Error = ErrorResponse
  >;

  /**
   * The operation to create or update a budget. You can optionally provide an eTag if desired as a form of concurrency control. To obtain the latest eTag for a given budget, perform a get operation prior to your put operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/CostManagement/")
  createOrUpdate is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    Budget,
    Error = ErrorResponse
  >;

  /**
   * The operation to delete a budget.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/CostManagement/")
  delete is Extension.DeleteSync<
    Extension.ScopeParameter,
    Budget,
    Response = ArmDeletedResponse,
    Error = ErrorResponse
  >;

  /**
   * Lists all budgets for the defined scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/CostManagement/")
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    Budget,
    Parameters = {
      /**
       * OData filter option. May be used to filter budgets by properties/category. The filter supports 'eq' only.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<BudgetsListResult>,
    Error = ErrorResponse
  >;
}

@@maxLength(Budget.name, 63);
@@minLength(Budget.name, 1);
@@doc(Budget.name, "Budget Name.");
@@doc(Budget.properties, "The properties of the budget.");
@@doc(Budgets.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create Budget operation."
);
