import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@access(Azure.AI.Projects.Telemetry.getAppInsights, Access.internal);
@@access(Azure.AI.Projects.GetAppInsightsResponse, Access.internal);
@@access(Azure.AI.Projects.AppInsightsProperties, Access.internal);
