import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

@doc("Validate Ownership Voucher Request")
model ValidateOwnershipVouchersRequest {
  @doc("Ownership Voucher Details.")
  @identifiers(#[])
  ownershipVoucherDetails?: OwnershipVoucherDetails[];
}

@doc("Validate Ownership Voucher Response")
model ValidateOwnershipVouchersResponse {
  @doc("Ownership Voucher Validation Details.")
  @identifiers(#[])
  ownershipVoucherValidationDetails?: OwnershipVoucherValidationDetails[];
}

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

@doc("Ownership Voucher validation Status.")
union OwnershipVoucherValidationStatus {
  string,

  @doc("Voucher evaluated as valid.")
  Valid: "Valid",

  @doc("Voucher evaluated as invalid.")
  Invalid: "Invalid",
}
