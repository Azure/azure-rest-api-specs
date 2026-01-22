// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.SerialConsole;

/**
 * Gets whether or not Serial Console is disabled for a given subscription
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("Get the disabled status for a subscription")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.SerialConsole/consoleServices/{default}")
@get
op getConsoleStatus(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  /**
   * Default parameter. Leave the value as "default".
   */
  @path default: string,
): ArmResponse<SerialConsoleStatus> | GetSerialConsoleSubscriptionNotFoundError | CloudError;

/**
 * Disables the Serial Console service for all VMs and VM scale sets in the provided subscription
 */
@summary("Disable Serial Console for a subscription")
@autoRoute
op disableConsole is ArmProviderActionSync<
  Response = DisableSerialConsoleResult | GetSerialConsoleSubscriptionNotFoundError,
  Scope = SubscriptionActionScope,
  Parameters = {
    /**
     * Default parameter. Leave the value as "default".
     */
    @path
    @segment("consoleServices")
    default: string;
  },
  Error = CloudError
>;

/**
 * Enables the Serial Console service for all VMs and VM scale sets in the provided subscription
 */
@summary("Enable Serial Console for a subscription")
@autoRoute
op enableConsole is ArmProviderActionSync<
  Response = EnableSerialConsoleResult | GetSerialConsoleSubscriptionNotFoundError,
  Scope = SubscriptionActionScope,
  Parameters = {
    /**
     * Default parameter. Leave the value as "default".
     */
    @path
    @segment("consoleServices")
    default: string;
  },
  Error = CloudError
>;
