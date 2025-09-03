import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Consumption;
/**
 * A budget resource.
 */
@extensionResource
model Budget is Azure.ResourceManager.ExtensionResource<BudgetProperties> {
  ...ResourceNameParameter<
    Resource = Budget,
    KeyName = "budgetName",
    SegmentName = "budgets",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Budgets {
  /**
   * Gets the budget for the scope by budget name.
   */
  get is Extension.Read<Extension.ScopeParameter, Budget>;

  /**
   * The operation to create or update a budget. You can optionally provide an eTag if desired as a form of concurrency control. To obtain the latest eTag for a given budget, perform a get operation prior to your put operation.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    Budget
  >;

  /**
   * The operation to delete a budget.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is Extension.DeleteSync<
    Extension.ScopeParameter,
    Budget,
    Response = ArmDeletedResponse
  >;

  /**
   * Lists all budgets for the defined scope.
   */
  list is Extension.ListByTarget<Extension.ScopeParameter, Budget>;
}

@@doc(Budget.name, "Budget Name.");
@@doc(Budget.properties, "The properties of the budget.");
@@doc(Budgets.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create Budget operation."
);
