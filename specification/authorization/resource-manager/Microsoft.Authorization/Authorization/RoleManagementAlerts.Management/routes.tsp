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

namespace Microsoft.Authorization;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AlertsOperationGroup {
  /**
   * Refresh all alerts for a resource scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Alerts_RefreshAll")
  @autoRoute
  @action("roleManagementAlerts/refresh")
  refreshAll is ArmProviderActionAsync<Scope = ExtensionActionScope>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AlertOperationOperationGroup {
  /**
   * Get the specified alert operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AlertOperation_Get")
  @route("/{scope}/providers/Microsoft.Authorization/roleManagementAlertOperations/{operationId}")
  @get
  get(
    ...ApiVersionParameter,

    /**
     * The scope of the alert operation.
     */
    @path
    scope: string,

    /**
     * The id of the alert operation.
     */
    @path
    operationId: string,
  ): ArmResponse<AlertOperationResult> | ErrorResponse;
}
