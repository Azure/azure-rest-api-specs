import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace Azure.AI.Projects;

/** Operations for reading budget policy usage. */
interface Budget {
  /** Lists the current usage counters for the specified budget policy. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Budget usage is a computed view rather than an Azure.Core resource collection."
  @summary("List budget policy usage")
  @route("/budget-policies/{policyName}/usage")
  @get
  @list
  list is FoundryDataPlaneOperation<BudgetUsageListRequest, BudgetUsageListResult>;
}
