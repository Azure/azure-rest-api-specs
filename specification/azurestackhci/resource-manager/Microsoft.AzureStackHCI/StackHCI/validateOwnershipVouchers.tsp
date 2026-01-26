import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
interface OwnershipVouchers {
  /**
   * Validates ownership vouchers.
   */
  @action("validateOwnershipVouchers")
  validate is ArmResourceActionSync<
    ResourceGroupLocationResource,
    ValidateOwnershipVouchersRequest,
    ValidateOwnershipVouchersResponse
  >;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Validate Ownership Voucher Request")
model ValidateOwnershipVouchersRequest {
  @doc("Ownership Voucher Details.")
  @identifiers(#[])
  @minItems(1)
  ownershipVoucherDetails: OwnershipVoucherDetails[];
}
@@doc(OwnershipVouchers.validate::parameters.body,
  "Ownership vouchers to be validated."
);
@@clientName(OwnershipVouchers.validate::parameters.body, "validationRequest");

@@clientName(OwnershipVouchers.validate::parameters.body, "validationRequest");

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Validate Ownership Voucher Response")
model ValidateOwnershipVouchersResponse {
  @doc("Ownership Voucher Validation Details.")
  @identifiers(#["id"])
  ownershipVoucherValidationDetails: OwnershipVoucherValidationDetails[];
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
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
@removed(Versions.v2026_02_01)
@doc("Ownership Voucher validation Status.")
union OwnershipVoucherValidationStatus {
  string,

  @doc("Voucher evaluated as valid.")
  Valid: "Valid",

  @doc("Voucher evaluated as invalid.")
  Invalid: "Invalid",
}
