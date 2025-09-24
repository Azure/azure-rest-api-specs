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

namespace Microsoft.Devices;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface IotDpsResourceOperationGroup {
  /**
   * Check if a provisioning service name is available. This will validate if the name is syntactically valid and if the name is usable
   */
  @summary("Check if a provisioning service name is available.")
  @autoRoute
  checkProvisioningServiceNameAvailability is ArmProviderActionSync<
    Request = OperationInputs,
    Response = NameAvailabilityInfo,
    Scope = SubscriptionActionScope,
    Error = ErrorDetails
  >;
}
