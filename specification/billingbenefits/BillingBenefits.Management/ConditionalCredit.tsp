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
 * Resource definition for Conditional Credits.
 */
model ConditionalCredit
  is Azure.ResourceManager.TrackedResource<ConditionalCreditProperties> {
  ...ResourceNameParameter<
    Resource = ConditionalCredit,
    KeyName = "conditionalCreditName",
    SegmentName = "conditionalCredits",
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
interface ConditionalCredits {
  /**
   * Get a conditional credit.
   */
  get is ArmResourceRead<ConditionalCredit>;

  /**
   * Create or update a conditional credit.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ConditionalCredit,
    Response = (ArmResponse<ConditionalCredit> &
      ArmAsyncOperationHeader<FinalResult = ConditionalCredit>) | (ArmResourceCreatedResponse<
      ConditionalCredit,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = ConditionalCredit>
    > &
      Azure.Core.Foundations.RetryAfterHeader)
  >;

  /**
   * Update a conditional credit.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ConditionalCredit,
    PatchModel = ConditionalCreditPatchRequest,
    Response = (ArmResponse<ConditionalCredit> &
      ArmAsyncOperationHeader<FinalResult = ConditionalCredit>) | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ConditionalCredit>> &
      Azure.Core.Foundations.RetryAfterHeader)
  >;

  /**
   * Delete a conditional credit.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    ConditionalCredit,
    Response = (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = void>> &
      Azure.Core.Foundations.RetryAfterHeader) | (NoContentResponse &
      ArmAsyncOperationHeader<FinalResult = void>)
  >;

  /**
   * List conditional credits by resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ConditionalCredit,
    Response = ArmResponse<ConditionalCreditList>
  >;

  /**
   * List conditional credits by subscription.
   */
  listBySubscription is ArmListBySubscription<
    ConditionalCredit,
    Response = ArmResponse<ConditionalCreditList>
  >;

  /**
   * Cancel conditional credit. Stops applying the benefit.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  cancel is ArmResourceActionAsyncBase<
    ConditionalCredit,
    Request = void,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ConditionalCredit>,
    Response = ArmResponse<ConditionalCredit> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ConditionalCredit>> &
      Azure.Core.Foundations.RetryAfterHeader)
  >;
}

@@doc(ConditionalCredit.name, "Name of the conditional credit");
@@doc(ConditionalCredit.properties, "Conditional credit properties");
@@doc(ConditionalCredits.createOrUpdate::parameters.resource,
  "Request body for creating a conditional credit"
);
@@doc(ConditionalCredits.update::parameters.properties,
  "Request body for updating a conditional credit"
);
