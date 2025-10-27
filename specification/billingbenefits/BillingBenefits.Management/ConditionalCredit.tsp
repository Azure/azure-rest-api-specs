import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
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
@added(Versions.v2025_05_01_preview)
model ConditionalCredit
  is Azure.ResourceManager.TrackedResource<ConditionalCreditProperties> {
  ...ResourceNameParameter<
    Resource = ConditionalCredit,
    KeyName = "conditionalCreditName",
    SegmentName = "conditionalCredits",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;
}

@armResourceOperations
@added(Versions.v2025_05_01_preview)
interface ConditionalCredits {
  /**
   * Get a conditional credit.
   */
  get is ArmResourceRead<ConditionalCredit>;

  /**
   * Create or update a conditional credit.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ConditionalCredit>;

  /**
   * Update a conditional credit.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ConditionalCredit,
    PatchModel = ConditionalCreditPatchRequest,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader
  >;

  /**
   * Delete a conditional credit.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ConditionalCredit,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader
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
}

@@doc(ConditionalCredit.name, "Name of the conditional credit");
@@doc(ConditionalCredit.properties, "Conditional credit properties");
@@doc(ConditionalCredits.createOrUpdate::parameters.resource,
  "Request body for creating a conditional credit"
);
@@doc(ConditionalCredits.update::parameters.properties,
  "Request body for updating a conditional credit"
);
