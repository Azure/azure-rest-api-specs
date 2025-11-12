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

namespace Microsoft.NetworkCloud;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface RegisteredSubscriptionsOperationGroup {
  /**
   * Get a list of Registered Subscriptions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("List Registered Subscriptions.")
  @operationId("RegisteredSubscriptions_List")
  @autoRoute
  @get
  @action("registeredSubscriptions")
  @list
  list is ArmProviderActionSync<
    Response = RegisteredSubscriptionList,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
  /**
   * Get a Registered Subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get a Registered Subscription.")
  @operationId("RegisteredSubscriptions_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetworkCloud/registeredSubscriptions/{registeredSubscriptionName}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The ID of the registered subscription.
     */
    @pattern("^default$")
    @path
    registeredSubscriptionName: string,
  ): ArmResponse<RegisteredSubscription> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OperationStatusOperationGroup {
  /**
   * Get the properties of the provided operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Retrieve the operation status.")
  @operationId("OperationStatus_Get")
  @route("/{operationStatusId}")
  @get
  get(
    ...ApiVersionParameter,

    /**
     * The ID of the operation status.
     */
    @path
    operationStatusId: string,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;

  /**
   * Create a new operation status or update properties of the operation status if it exists.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or update the operation status.")
  @operationId("OperationStatus_CreateOrUpdate")
  @route("/{operationStatusId}")
  @put
  createOrUpdate(
    ...ApiVersionParameter,

    /**
     * The ID of the operation status.
     */
    @path
    operationStatusId: string,

    /**
     * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @header
    `If-Match`?: string,

    /**
     * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @header
    `If-None-Match`?: string,

    /**
     * The request body.
     */
    @bodyRoot
    operationStatusParameters: OperationStatusResult,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;

  /**
   * Patch properties of the provided operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Patch the operation status.")
  @operationId("OperationStatus_Update")
  @route("/{operationStatusId}")
  @patch(#{ implicitOptionality: false })
  update(
    ...ApiVersionParameter,

    /**
     * The ID of the operation status.
     */
    @path
    operationStatusId: string,

    /**
     * The request body.
     */
    @bodyRoot
    operationStatusParameters: OperationStatusResult,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;
}
