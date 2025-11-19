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

namespace Microsoft.ApiManagement;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ApiExportOperationGroup {
  /**
   * Gets the details of the API specified by its identifier in the format specified to the Storage Blob with SAS Key valid for 5 minutes.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/apis/{apiId}?export=true")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the API Management service.
     */
    @maxLength(50)
    @minLength(1)
    @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
    @path
    serviceName: string,

    /**
     * API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number.
     */
    @maxLength(256)
    @minLength(1)
    @pattern("^[^*#&+:<>?]+$")
    @path
    apiId: string,

    /**
     * Format in which to export the Api Details to the Storage Blob with Sas Key valid for 5 minutes. New formats can be added in the future.
     */
    @query("format")
    format: ExportFormat,

    /**
     * Query parameter required to export the API details.
     */
    @query("export")
    export: ExportApi,
  ): ArmResponse<ApiExportResult> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DeletedServicesOperationGroup {
  /**
   * Lists all soft-deleted services available for undelete for the given subscription.
   */
  @autoRoute
  @get
  @action("deletedservices")
  @list
  listBySubscription is ArmProviderActionSync<
    Response = DeletedServicesCollection,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ApiManagementServiceOperationGroup {
  /**
   * Checks availability and correctness of a name for an API Management service.
   */
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = ApiManagementServiceCheckNameAvailabilityParameters,
    Response = ApiManagementServiceNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
  /**
   * Get the custom domain ownership identifier for an API Management service.
   */
  @autoRoute
  getDomainOwnershipIdentifier is ArmProviderActionSync<
    Response = ApiManagementServiceGetDomainOwnershipIdentifierResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ApiManagementSkusOperationGroup {
  /**
   * Gets the list of Microsoft.ApiManagement SKUs available for your Subscription.
   */
  @autoRoute
  @get
  @action("skus")
  @list
  list is ArmProviderActionSync<
    Response = ArmResponse<ApiManagementSkusResult>,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface WorkspaceApiExportOperationGroup {
  /**
   * Gets the details of the API specified by its identifier in the format specified to the Storage Blob with SAS Key valid for 5 minutes.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/workspaces/{workspaceId}/apis/{apiId}?export=true")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the API Management service.
     */
    @maxLength(50)
    @minLength(1)
    @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
    @path
    serviceName: string,

    /**
     * Workspace identifier. Must be unique in the current API Management service instance.
     */
    @maxLength(80)
    @minLength(1)
    @pattern("^[^*#&+:<>?]+$")
    @path
    workspaceId: string,

    /**
     * API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number.
     */
    @maxLength(256)
    @minLength(1)
    @pattern("^[^*#&+:<>?]+$")
    @path
    apiId: string,

    /**
     * Format in which to export the Api Details to the Storage Blob with Sas Key valid for 5 minutes.
     */
    @query("format")
    format: ExportFormat,

    /**
     * Query parameter required to export the API details.
     */
    @query("export")
    export: ExportApi,
  ): ArmResponse<ApiExportResult> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OperationStatusOperationGroup {
  /**
   * Returns the current status of an async operation.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ApiManagement/locations/{location}/operationStatuses/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The ID of an ongoing async operation.
     */
    @path
    @minLength(1)
    @maxLength(80)
    operationId: string,
  ): ArmResponse<CommonTypes.OperationStatusResult> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OperationsResultsOperationGroup {
  /**
   * Returns operation results for long running operations executing DELETE or PATCH on the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ApiManagement/locations/{location}/operationResults/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The ID of an ongoing async operation.
     */
    @path
    @minLength(1)
    @maxLength(80)
    operationId: string,
  ): OkResponse | (ArmAcceptedResponse & {
    /**
     * URL for determining when an operation has completed.
     **/
    @header("Location")
    location: string;
  }) | ErrorResponse;
}
