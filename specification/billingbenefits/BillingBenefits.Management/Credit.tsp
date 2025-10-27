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
 * Credit resource definition
 */
@added(Versions.v2025_05_01_preview)
model Credit is Azure.ResourceManager.TrackedResource<CreditProperties> {
  ...ResourceNameParameter<
    Resource = Credit,
    KeyName = "creditName",
    SegmentName = "credits",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;
}

@armResourceOperations
@added(Versions.v2025_05_01_preview)
interface Credits {
  /**
   * Get a credit.
   */
  get is ArmResourceRead<Credit>;

  /**
   * Create a credit.
   */
  create is ArmResourceCreateOrReplaceAsync<Credit>;

  /**
   * Update a credit.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Credit,
    PatchModel = CreditPatchRequest,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader
  >;

  /**
   * Delete a credit.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Credit>;

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
  cancel is ArmResourceActionAsync<Credit, void, ArmResponse<Credit>>;
}

@@doc(Credit.name, "Name of the credit");
@@doc(Credit.properties, "Credit properties");
@@doc(Credits.create::parameters.resource, "Credit create request");
@@doc(Credits.update::parameters.properties, "Credit patch request");
