import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-client-generator-core";
import "./DataCollection.Management/main.tsp";
import "./PrivateLinkScopes.Management/main.tsp";
import "./Autoscale.Management/main.tsp";
import "./ActivityLogs.Management/main.tsp";
import "./Metrics.Management/main.tsp";
import "./ServiceDiagnosticsSettings.Management/main.tsp";
import "./AlertRulesIncidents.Management/main.tsp";
import "./LogProfiles.Management/main.tsp";
import "./ActivityLogAlerts.Management/main.tsp";
import "./MetricAlert.Management/main.tsp";
import "./ScheduledQueryRule.Management/main.tsp";
import "./MetricBaselines.Management/main.tsp";
import "./ActionGroups.Management/main.tsp";
import "./NetworkSecurityPerimeter.Management/main.tsp";

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
