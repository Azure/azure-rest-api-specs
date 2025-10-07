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
 * Microsoft Azure Consumption Commitment.
 */
@added(Versions.v2025_05_01_preview)
model Macc is Azure.ResourceManager.TrackedResource<MaccModelProperties> {
  ...ResourceNameParameter<
    Resource = Macc,
    KeyName = "maccName",
    SegmentName = "maccs",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;
}

@added(Versions.v2025_05_01_preview)
@armResourceOperations
interface Maccs {
  /**
   * Get a MACC.
   */
  get is ArmResourceRead<Macc>;

  /**
   * Create MACC.
   */
  create is ArmResourceCreateOrReplaceAsync<Macc>;

  /**
   * Update MACC.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Macc,
    PatchModel = MaccPatchRequest,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader
  >;

  /**
   * Delete MACC.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Macc,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader
  >;

  /**
   * List MACCs under a resource group for primary service admin.
   */
  listByResourceGroup is ArmResourceListByParent<
    Macc,
    Response = ArmResponse<MaccList>
  >;

  /**
   * List MACCs under a subscription from primary service tenant.
   */
  listBySubscription is ArmListBySubscription<
    Macc,
    Response = ArmResponse<MaccList>
  >;

  /**
   * Represents an operation to cancel MACC contract. This operation does not indicate deletion of the MACC, but rather stops applying the benefit to the account.
   */
  cancel is ArmResourceActionAsync<
    Macc,
    void,
    ArmResponse<Macc>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader
  >;

  /**
   * Operation to waive a customer's pending MACC balance (Shortfall) from their account, ensuring they are not charged for the outstanding amount.
   */
  writeOff is ArmResourceActionAsync<
    Macc,
    void,
    ArmResponse<Macc>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader
  >;
}

@@doc(Macc.name, "Name of primary MACC.");
@@doc(Macc.properties, "MACC properties");
@@doc(Maccs.create::parameters.resource, "Request body for creating MACC.");
@@doc(Maccs.update::parameters.properties, "Request body for updating MACC.");
