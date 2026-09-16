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
#suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-api-version" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-interface" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("Get the disabled status for a subscription")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.SerialConsole/consoleServices/{default}")
@get
@tag("SerialConsole")
op getConsoleStatus(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  /**
   * Default parameter. Leave the value as "default".
   */
  @path default: string,
):
  | ArmResponse<SerialConsoleStatus>
  | GetSerialConsoleSubscriptionNotFoundError
  | CloudError;

alias ConsoleServiceDefaultParameter = {
  /**
   * Default parameter. Leave the value as "default".
   */
  @path
  @segment("consoleServices")
  default: string;
};

/**
 * Disables the Serial Console service for all VMs and VM scale sets in the provided subscription
 */
#suppress "@azure-tools/typespec-azure-resource-manager/use-interface" "The operation is top-level to preserve the existing DisableConsole operationId without using @operationId."
@summary("Disable Serial Console for a subscription")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.SerialConsole/consoleServices/{default}/disableConsole")
@post
@tag("SerialConsole")
op disableConsole(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ConsoleServiceDefaultParameter,
):
  | DisableSerialConsoleResult
  | GetSerialConsoleSubscriptionNotFoundError
  | CloudError;

/**
 * Enables the Serial Console service for all VMs and VM scale sets in the provided subscription
 */
#suppress "@azure-tools/typespec-azure-resource-manager/use-interface" "The operation is top-level to preserve the existing EnableConsole operationId without using @operationId."
@summary("Enable Serial Console for a subscription")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.SerialConsole/consoleServices/{default}/enableConsole")
@post
@tag("SerialConsole")
op enableConsole(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ConsoleServiceDefaultParameter,
):
  | EnableSerialConsoleResult
  | GetSerialConsoleSubscriptionNotFoundError
  | CloudError;
