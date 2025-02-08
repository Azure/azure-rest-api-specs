import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
import "./telemetry/client.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Azure.AI.Telemetry, "AITelemetryClient");

@@access(Azure.AI.Telemetry.getAppInsights, Access.internal);
@@access(Azure.AI.Telemetry.GetAppInsightsResponse, Access.internal);
@@access(Azure.AI.Telemetry.AppInsightsProperties, Access.internal);
