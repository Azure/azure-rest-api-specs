// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface TasksOperationGroup {
  /**
   * Recommended tasks that will help improve the security of the subscription proactively
   */
  @tag("Tasks")
  @autoRoute
  @get
  @list
  @action("tasks")
  list is ArmProviderActionSync<
    Response = SecurityTaskList,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * OData filter. Optional.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = CloudError
  >;
}
