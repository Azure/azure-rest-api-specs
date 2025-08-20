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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ConfigurationProfileAssignmentsOperationGroup {
  /**
   * Get list of configuration profile assignments
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ConfigurationProfileAssignments_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Automanage/configurationProfileAssignments")
  @list
  list(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,
  ): ArmResponse<ConfigurationProfileAssignmentList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface BestPracticesVersionsOperationGroup {
  /**
   * Retrieve a list of Automanage best practices under a given tenant
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("BestPracticesVersions_ListByTenant")
  @route("/providers/microsoft.Automanage/bestPractices/{bestPracticeName}/versions")
  @list
  listByTenant(
    ...ApiVersionParameter,

    /** The Automanage best practice name. */
    @path
    @segment("bestPractices")
    @key
    bestPracticeName: string,
  ): ArmResponse<BestPracticeList> | ErrorResponse;
}
