// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AppServiceCertificateOrdersOperationGroup {
  /**
   * Description for Validate information for a certificate order.
   */
  @summary("Validate information for a certificate order.")
  @autoRoute
  @action("validateCertificateRegistrationInformation")
  validatePurchaseInformation is ArmProviderActionSync<
    Request = AppServiceCertificateOrder,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = DefaultErrorResponse
  >;
}
