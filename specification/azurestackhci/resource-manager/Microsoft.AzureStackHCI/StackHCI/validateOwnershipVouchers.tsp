import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2026_03_01_preview)
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

@@doc(OwnershipVouchers.validate::parameters.body,
  "Ownership vouchers to be validated."
);
@@clientName(OwnershipVouchers.validate::parameters.body, "validationRequest");
