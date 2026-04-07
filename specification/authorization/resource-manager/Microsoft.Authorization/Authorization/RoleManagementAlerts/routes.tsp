// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.RoleManagementAlerts;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AlertsOperationGroup {
  /**
   * Refresh all alerts for a resource scope.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Alerts")
  @autoRoute
  @action("roleManagementAlerts/refresh")
  refreshAll is ArmProviderActionAsync<
    Response = AlertOperationResult | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = AlertOperationResult> &
      Azure.Core.Foundations.RetryAfterHeader,
    Scope = ExtensionActionScope,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AlertOperationOperationGroup {
  /**
   * Get the specified alert operation.
   */
  @tag("AlertOperations")
  @route("/{+scope}/providers/Microsoft.Authorization/roleManagementAlertOperations/{+operationId}")
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
  ): ArmResponse<AlertOperationResult> | CloudError;
}
