import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Billing;
/**
 * Details of the transfer.
 */
@tenantResource
model RecipientTransferDetails
  is Azure.ResourceManager.ProxyResource<RecipientTransferProperties> {
  ...ResourceNameParameter<
    Resource = RecipientTransferDetails,
    KeyName = "transferName",
    SegmentName = "transfers",
    NamePattern = "^[a-z0-9]*$"
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations
interface RecipientTransfers {
  /**
   * Gets a transfer request by ID. The caller must be the recipient of the transfer request.
   */
  @summary("Gets a transfer request by ID. The caller must be the recipient of the transfer request.")
  get is ArmResourceRead<
    RecipientTransferDetails,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the transfer requests received by the caller.
   */
  @summary("Lists the transfer requests received by the caller.")
  list is ArmResourceListByParent<
    RecipientTransferDetails,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<RecipientTransferDetailsListResult>
  >;

  /**
   * Accepts a transfer request.
   */
  @summary("Accepts a transfer request.")
  accept is ArmResourceActionSync<
    RecipientTransferDetails,
    AcceptTransferRequest,
    ArmResponse<RecipientTransferDetails>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Validates if a subscription or a reservation can be transferred. Use this operation to validate your subscriptions or reservation before using the accept transfer operation.
   */
  @summary("Validates if a subscription or a reservation can be transferred. Use this operation to validate your subscriptions or reservation before using the accept transfer operation.")
  @list
  validate is ArmResourceActionSync<
    RecipientTransferDetails,
    AcceptTransferRequest,
    ArmResponse<ValidateTransferListResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Declines a transfer request.
   */
  @summary("Declines a transfer request.")
  decline is ArmResourceActionSync<
    RecipientTransferDetails,
    void,
    ArmResponse<RecipientTransferDetails>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(RecipientTransferDetails.name,
  "The ID that uniquely identifies a transfer request."
);
@@doc(RecipientTransferDetails.properties, "Details of the transfer.");
@@doc(RecipientTransfers.accept::parameters.body,
  "Request parameters that are provided to the accept transfer operation."
);
@@doc(RecipientTransfers.validate::parameters.body,
  "Request parameters that are provided to the validate transfer operation."
);
