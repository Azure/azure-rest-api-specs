import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BillingBenefits;
/**
 * Resource definition for Discounts.
 */
model Discount is Azure.ResourceManager.TrackedResource<DiscountProperties> {
  ...ResourceNameParameter<
    Resource = Discount,
    KeyName = "discountName",
    SegmentName = "discounts",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;
}

@armResourceOperations
interface Discounts {
  /**
   * Get discount at resource group level
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Discount_Get")
  get is ArmResourceRead<Discount>;

  /**
   * Create discount.
   */
  create is ArmResourceCreateOrReplaceAsync<Discount>;

  /**
   * Update discounts
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header"
  @patch(#{ implicitOptionality: false })
  @operationId("Discount_Update")
  update is ArmCustomPatchAsync<
    Discount,
    PatchModel = DiscountPatchRequest,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Discount> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete discount. Clears the metadata from the user's view.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Discount,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List discounts at resource group level
   */
  resourceGroupList is ArmResourceListByParent<
    Discount,
    Response = ArmResponse<DiscountList>
  >;

  /**
   * List discounts at subscription level
   */
  subscriptionList is ArmListBySubscription<
    Discount,
    Response = ArmResponse<DiscountList>
  >;

  /**
   * Cancel discount. Stops applying the benefit.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header"
  cancel is ArmResourceActionAsync<
    Discount,
    void,
    ArmResponse<Discount>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(Discount.name, "Name of the discount");
@@doc(Discount.properties, "Discount properties");
@@doc(Discounts.create::parameters.resource,
  "Request body for creating a discount."
);
@@doc(Discounts.update::parameters.properties,
  "Request body for updating discounts"
);
