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
 * Microsoft Azure Consumption Commitment.
 */
model Macc is Azure.ResourceManager.TrackedResource<MaccModelProperties> {
  ...ResourceNameParameter<
    Resource = Macc,
    KeyName = "maccName",
    SegmentName = "maccs",
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
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is ArmCustomPatchAsync<
    Macc,
    PatchModel = MaccPatchRequest,
    Response = ArmResponse<Macc> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Macc> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Delete MACC.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    Macc,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader> | NoContentResponse
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
  @Azure.Core.useFinalStateVia("azure-async-operation")
  cancel is ArmResourceActionAsyncBase<
    Macc,
    Request = void,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Macc>,
    Response = ArmResponse<Macc> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Macc> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Operation to waive a customer's pending MACC balance (Shortfall) from their account, ensuring they are not charged for the outstanding amount.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  writeOff is ArmResourceActionAsyncBase<
    Macc,
    Request = void,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Macc>,
    Response = ArmResponse<Macc> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Macc> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Operation to charge shortfall to a customer's account, ensuring they are charged for the outstanding amount of MACC credit.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  chargeShortfall is ArmResourceActionAsyncBase<
    Macc,
    Request = ChargeShortfallRequest,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Macc>,
    Response = ArmResponse<Macc> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Macc> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;
}

@@doc(Macc.name, "Name of primary MACC.");
@@doc(Macc.properties, "MACC properties");
@@doc(Maccs.create::parameters.resource, "Request body for creating MACC.");
@@doc(Maccs.update::parameters.properties, "Request body for updating MACC.");
@@doc(Maccs.chargeShortfall::parameters.body,
  "Request body for charging shortfall."
);
