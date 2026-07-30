import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Billing;
/**
 * A product.
 */
@tenantResource
@parentResource(BillingAccount)
model Product is Azure.ResourceManager.ProxyResource<ProductProperties> {
  ...ResourceNameParameter<
    Resource = Product,
    KeyName = "productName",
    SegmentName = "products",
    NamePattern = GuidPattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

@armResourceOperations(#{ omitTags: true })
interface Products {
  /**
   * Gets a product by ID. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("Product")
  get is ArmResourceRead<
    Product,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Updates the properties of a Product. Currently, auto renew can be updated. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("Product")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Product,
    PatchModel = Product,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the products for a billing account. These don't include products billed based on usage. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement or Microsoft Partner Agreement.
   */
  @tag("Product")
  listByBillingAccount is ArmResourceListByParent<
    Product,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      ...DefaultODataParameters;
    },
    Response = ArmResponse<ProductListResult>
  >;

  /**
   * Moves a product's charges to a new invoice section. The new invoice section must belong to the same billing profile as the existing invoice section. This operation is supported only for products that are purchased with a recurring charge and for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("Product")
  move is ArmResourceActionAsync<
    Product,
    MoveProductRequest,
    Product,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Validates if a product's charges can be moved to a new invoice section. This operation is supported only for products that are purchased with a recurring charge and for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("Product")
  validateMoveEligibility is ArmResourceActionSync<
    Product,
    MoveProductRequest,
    ArmResponse<MoveProductEligibilityResult>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(Product.name, "The ID that uniquely identifies a product.");
@@doc(Product.properties, "A product.");
@@doc(Products.update::parameters.properties, "A product.");
@@doc(
  Products.move::parameters.body,
  "The properties of the product to initiate a transfer."
);
@@doc(
  Products.validateMoveEligibility::parameters.body,
  "The properties of the product to initiate a transfer."
);
