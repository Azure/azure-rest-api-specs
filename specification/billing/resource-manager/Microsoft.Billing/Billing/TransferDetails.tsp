import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "./models.tsp";
import "./InvoiceSection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Billing;
/**
 * Details of the transfer.
 */
@tenantResource
@parentResource(InvoiceSection)
model TransferDetails
  is Azure.ResourceManager.ProxyResource<TransferProperties> {
  ...ResourceNameParameter<
    Resource = TransferDetails,
    KeyName = "transferName",
    SegmentName = "transfers",
    NamePattern = LowerAlphaNumericPattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "A transfer is not a living resource, so it does not support delete operation."
@armResourceOperations
interface Transfers {
  /**
   * Gets a transfer request by ID. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  get is ArmResourceRead<
    TransferDetails,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Sends a request to a user in another billing account to transfer billing ownership of their subscriptions. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  initiate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    TransferDetails,
    Request = TransferDetails,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the transfer requests for an invoice section. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  list is ArmResourceListByParent<
    TransferDetails,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<TransferDetailsListResult>
  >;

  /**
   * Cancels a transfer request. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  cancel is ArmResourceActionSync<
    TransferDetails,
    void,
    ArmResponse<TransferDetails>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(
  TransferDetails.name,
  "The ID that uniquely identifies a transfer request."
);
@@doc(TransferDetails.properties, "Details of the transfer.");
@@typeChangedFrom(
  Transfers.initiate::parameters.resource,
  Versions.v2024_08_01_preview,
  InitiateTransferRequest
);
@@doc(
  Transfers.initiate::parameters.resource,
  "Request parameters that are provided to the initiate transfer operation."
);
