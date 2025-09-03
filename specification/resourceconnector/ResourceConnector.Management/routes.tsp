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

namespace Microsoft.ResourceConnector;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AppliancesOperationGroup {
  /**
   * Gets the telemetry config.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the telemetry config.")
  @operationId("Appliances_GetTelemetryConfig")
  @autoRoute
  @get
  @action("telemetryconfig")
  getTelemetryConfig is ArmProviderActionSync<
    Response = ApplianceGetTelemetryConfigResult,
    Scope = SubscriptionActionScope
  >;
}
