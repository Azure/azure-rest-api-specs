import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-client-generator-core";
import "./DataCollection/main.tsp";
import "./PrivateLinkScopes/main.tsp";
import "./AutoScale/main.tsp";
import "./ActivityLogs/main.tsp";
import "./Metrics/main.tsp";
import "./ServiceDiagnosticsSettings/main.tsp";
import "./AlertRulesIncidents/main.tsp";
import "./LogProfiles/main.tsp";
import "./ActivityLogAlerts/main.tsp";
import "./MetricAlert/main.tsp";
import "./ScheduledQueryRule/main.tsp";
import "./MetricBaselines/main.tsp";
import "./ActionGroups/main.tsp";
import "./NetworkSecurityPerimeter/main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using Microsoft.Insights;

@client({
  name: "CombineClient",
  service: [
    Microsoft.DataCollection,
    Microsoft.PrivateLinkScopes,
    Microsoft.AutoScale,
    Microsoft.ActivityLogs,
    Microsoft.Metrics,
    Microsoft.ServiceDiagnosticsSettings,
    Microsoft.AlertRulesIncidents,
    Microsoft.LogProfiles,
    Microsoft.ActivityLogAlerts,
    Microsoft.MetricAlert,
    Microsoft.ScheduledQueryRule,
    Microsoft.MetricBaselines,
    Microsoft.ActionGroups,
    Microsoft.NetworkSecurityPerimeter
  ],
  autoMergeService: true,
})
namespace Microsoft.InsightsCombinedClient;
