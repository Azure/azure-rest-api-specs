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

  /**
   * The fully qualified resource ID of the resource that manages this resource. Indicates if this resource is managed by another Azure resource. If this is present, complete mode deployment will not delete the resource if it is removed from the template since it is managed by another resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  managedBy?: string;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type. E.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^[-\\w\\._,\\(\\)]+$")
  kind?: string;

  /**
   * The etag field is *not* required. If it is provided in the response body, it must also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Managed service identity (system assigned and/or user assigned identities)
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedServiceIdentity;

  /**
   * The resource model definition representing SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;

  /**
   * Plan for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  plan?: Plan;
}

@armResourceOperations
interface Discounts {
  /**
   * Get discount at resource group level
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<Discount>;

  /**
   * Create discount.
   */
  create is ArmResourceCreateOrReplaceAsync<Discount>;

  /**
   * Update discounts
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Discount,
    PatchModel = DiscountPatchRequest,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Discount> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete discount. Clears the metadata from the user's view.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  cancel is ArmResourceActionAsync<
    Discount,
    void,
    ArmResponse<Discount>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Discount> &
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
