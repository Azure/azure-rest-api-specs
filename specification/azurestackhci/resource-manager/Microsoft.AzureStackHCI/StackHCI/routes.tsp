// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./private-preview/validateOwnershipVouchers-pvt.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ServiceOperationGroup {
  /**
   * This method does all the necessary validation on the ownership voucher details provided by the customer.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/locations/{location}/validateOwnershipVouchers")
  @post
  validateOwnershipVouchers(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...LocationResourceParameter,

    /**
     * Inputs of the customer.
     */
    @bodyRoot
    validationRequest: ValidateOwnershipVouchersRequest,
  ): ArmResponse<ValidateOwnershipVouchersResponse> | ErrorResponse;
}
