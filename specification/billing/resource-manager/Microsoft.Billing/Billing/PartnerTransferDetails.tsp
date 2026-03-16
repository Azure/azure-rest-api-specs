import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Customer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Billing;
/**
 * Details of the transfer.
 */
@tenantResource
@parentResource(Customer)
model PartnerTransferDetails
  is Azure.ResourceManager.ProxyResource<PartnerTransferProperties> {
  ...ResourceNameParameter<
    Resource = PartnerTransferDetails,
    KeyName = "transferName",
    SegmentName = "transfers",
    NamePattern = "^[a-z0-9]*$"
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface PartnerTransfers {
  /**
   * Gets a transfer request by ID. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("Transfers")
  get is ArmResourceRead<
    PartnerTransferDetails,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Sends a request to a user in a customer's billing account to transfer billing ownership of their subscriptions. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("Transfers")
  initiate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    PartnerTransferDetails,
    Request = PartnerInitiateTransferRequest,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists the transfer requests sent to a customer. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("Transfers")
  list is ArmResourceListByParent<
    PartnerTransferDetails,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<PartnerTransferDetailsListResult>
  >;

  /**
   * Cancels a transfer request. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("Transfers")
  cancel is ArmResourceActionSync<
    PartnerTransferDetails,
    void,
    ArmResponse<PartnerTransferDetails>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(PartnerTransferDetails.name,
  "The ID that uniquely identifies a transfer request."
);
@@doc(PartnerTransferDetails.properties, "Details of the transfer.");
@@doc(PartnerTransfers.initiate::parameters.resource,
  "Request parameters that are provided to the initiate transfer operation."
);
