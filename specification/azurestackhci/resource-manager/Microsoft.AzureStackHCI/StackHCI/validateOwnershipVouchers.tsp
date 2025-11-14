import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_12_01_preview)
interface OwnershipVouchers {
  /**
   * Validates ownership vouchers.
   */
  @doc("Validates ownership vouchers.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/locations/{location}/validateOwnershipVouchers")
  @post
  validate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...LocationResourceParameter,

    /**
     * Ownership vouchers to be validated.
     */
    @doc("Ownership vouchers to be validated.")
    @bodyRoot
    validationRequest: ValidateOwnershipVouchersRequest,
  ): ArmResponse<ValidateOwnershipVouchersResponse> | ErrorResponse;
}

@added(Versions.v2025_12_01_preview)
@doc("Validate Ownership Voucher Request")
model ValidateOwnershipVouchersRequest {
  @doc("Ownership Voucher Details.")
  @identifiers(#[])
  ownershipVoucherDetails?: OwnershipVoucherDetails[];
}

@added(Versions.v2025_12_01_preview)
@doc("Validate Ownership Voucher Response")
model ValidateOwnershipVouchersResponse {
  @doc("Ownership Voucher Validation Details.")
  @identifiers(#["id"])
  ownershipVoucherValidationDetails?: OwnershipVoucherValidationDetails[];
}

@added(Versions.v2025_12_01_preview)
@doc("Ownership Voucher Validation Details")
model OwnershipVoucherValidationDetails {
  @doc("The ownership voucher validation status.")
  validationStatus?: OwnershipVoucherValidationStatus;

  @doc("Serial number of the device.")
  serialNumber?: string;

  @doc("FDO guid of the Ownership Voucher.")
  id?: string;

  @doc("Name of the manufacturer.")
  manufacturer?: string;

  @doc("Name of the model.")
  modelName?: string;

  @doc("Version of the Ownership Voucher format")
  version?: string;

  @doc("Azure Machine Id of the Ownership voucher")
  azureMachineId?: string;

  @doc("Error details if the validation failed.")
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

@added(Versions.v2025_12_01_preview)
@doc("Ownership Voucher validation Status.")
union OwnershipVoucherValidationStatus {
  string,

  @doc("Voucher evaluated as valid.")
  Valid: "Valid",

  @doc("Voucher evaluated as invalid.")
  Invalid: "Invalid",
}
