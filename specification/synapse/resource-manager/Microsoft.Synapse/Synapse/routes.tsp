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

namespace Microsoft.Synapse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationsOperationGroup {
  /**
   * Check whether a workspace name is available
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Check name availability")
  @operationId("Operations_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityRequest,
    Response = CheckNameAvailabilityResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;

  /**
   * Get the result of an operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operation"
  @operationId("Operations_GetLocationHeaderResult")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/operationResults/{operationId}")
  @get
  getLocationHeaderResult(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    @path workspaceName: string,
    @path operationId: string,
  ):
    | OkResponse
    | CreatedResponse
    | AcceptedResponse
    | NoContentResponse
    | ErrorResponse;

  /**
   * Get the status of an operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operation"
  @operationId("Operations_GetAzureAsyncHeaderResult")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/operationStatuses/{operationId}")
  @get
  getAzureAsyncHeaderResult(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    @path workspaceName: string,
    @path operationId: string,
  ): ArmResponse<OperationResource> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface IntegrationRuntimeOperationStatusOperationGroup {
  /**
   * Get an integration runtime start operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operation"
  @operationId("Get_IntegrationRuntimeStart")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/integrationRuntimes/{integrationRuntimeName}/start/operationstatuses/{integrationRuntimeOperationId}")
  @get
  getStartStatus(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    @path workspaceName: string,
    @path integrationRuntimeName: string,
    @path integrationRuntimeOperationId: string,
  ): ArmResponse<IntegrationRuntimeOperationStatus> | ErrorResponse;

  /**
   * Get an integration runtime stop operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operation"
  @operationId("Get_IntegrationRuntimeStop")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/integrationRuntimes/{integrationRuntimeName}/stop/operationstatuses/{integrationRuntimeOperationId}")
  @get
  getStopStatus(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    @path workspaceName: string,
    @path integrationRuntimeName: string,
    @path integrationRuntimeOperationId: string,
  ): ArmResponse<IntegrationRuntimeStopOperationStatus> | ErrorResponse;

  /**
   * Get an integration runtime interactive query operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operation"
  @operationId("Get_IntegrationRuntimeEnableInteractivequery")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/integrationRuntimes/{integrationRuntimeName}/enableinteractivequery/operationstatuses/{integrationRuntimeOperationId}")
  @get
  getEnableInteractiveQueryStatus(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    @path workspaceName: string,
    @path integrationRuntimeName: string,
    @path integrationRuntimeOperationId: string,
  ): ArmResponse<IntegrationRuntimeEnableinteractivequery> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface KustoOperationsOperationGroup {
  /**
   * Lists available operations for the Kusto sub-resources inside Microsoft.Synapse provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoOperations_List")
  @autoRoute
  @get
  @action("kustooperations")
  list is ArmProviderActionSync<Response = Azure.ResourceManager.CommonTypes.OperationListResult>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface KustoPoolsOperationGroup {
  /**
   * Lists eligible SKUs for Kusto Pool resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPools_ListSkus")
  @autoRoute
  @get
  @action("skus")
  listSkus is ArmProviderActionSync<
    Response = SkuDescriptionList,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Checks that the kusto pool name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPools_CheckNameAvailability")
  @autoRoute
  @action("kustoPoolCheckNameAvailability")
  checkNameAvailability is ArmProviderActionSync<
    Request = KustoPoolCheckNameRequest,
    Response = CheckNameResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
