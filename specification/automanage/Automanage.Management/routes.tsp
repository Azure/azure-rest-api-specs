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

namespace Microsoft.Automanage;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ConfigurationProfileAssignmentsOperationGroup {
  /**
   * Get list of configuration profile assignments
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationProfileAssignments_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automanage/configurationProfileAssignments")
  @get
  list(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,
  ): ArmResponse<ConfigurationProfileAssignmentList> | ErrorResponse;
}
