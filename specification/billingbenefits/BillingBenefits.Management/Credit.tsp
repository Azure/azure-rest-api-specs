import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.BillingBenefits;
/**
 * Credit resource definition
 */
model Credit is Azure.ResourceManager.TrackedResource<CreditProperties> {
  ...ResourceNameParameter<
    Resource = Credit,
    KeyName = "creditName",
    SegmentName = "credits",
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
  identity?: CommonTypes.ManagedServiceIdentity;

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
interface Credits {
  /**
   * Get a credit.
   */
  get is ArmResourceRead<Credit>;

  /**
   * Create a credit.
   */
  @Azure.Core.useFinalStateVia("original-uri")
  create is ArmResourceCreateOrReplaceAsync<
    Credit,
    Response = (ArmResponse<Credit> &
      ArmAsyncOperationHeader<FinalResult = Credit>) | (ArmResourceCreatedResponse<
      Credit,
      LroHeaders = ArmCombinedLroHeaders<FinalResult = Credit>
    > &
      Azure.Core.Foundations.RetryAfterHeader)
  >;

  /**
   * Update a credit.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Credit,
    PatchModel = CreditPatchRequest,
    Response = (ArmResponse<Credit> &
      ArmAsyncOperationHeader<FinalResult = Credit>) | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Credit>> &
      Azure.Core.Foundations.RetryAfterHeader)
  >;

  /**
   * Delete a credit.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Credit,
    Response = (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> &
      Azure.Core.Foundations.RetryAfterHeader) | (NoContentResponse &
      ArmAsyncOperationHeader)
  >;

  /**
   * List Credits under a resource group from primary service admin.
   */
  listByResourceGroup is ArmResourceListByParent<
    Credit,
    Response = ArmResponse<CreditsList>
  >;

  /**
   * List credits under a subscription from primary service tenant.
   */
  listBySubscription is ArmListBySubscription<
    Credit,
    Response = ArmResponse<CreditsList>
  >;

  /**
   * Cancels a credit.
   */
  @Azure.Core.useFinalStateVia("location")
  cancel is ArmResourceActionAsyncBase<
    Credit,
    Request = void,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ConditionalCredit>,
    Response = (ArmResponse<Credit> &
      ArmAsyncOperationHeader<FinalResult = Credit>) | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Credit>>
  >;
}

@@doc(Credit.name, "Name of the credit");
@@doc(Credit.properties, "Credit properties");
@@doc(Credits.create::parameters.resource, "Credit create request");
@@doc(Credits.update::parameters.properties, "Credit patch request");
