import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

@tag("Budget")
@route("/budget-policies")
interface Budget {
  /**
   * Retrieves current consumption for the specified budget policy and counter-key dimension.
   * The returned values are a bounded, potentially stale view of the durable enforcement counters.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The operation returns a paged runtime usage projection rather than a standard resource."
  @summary("Get budget usage")
  @get
  @route("/{policyName}/usage")
  get is FoundryDataPlaneOperation<
    BudgetUsageRequest,
    BudgetUsageResponse,
    BudgetUsageErrorResponse
  >;
}
