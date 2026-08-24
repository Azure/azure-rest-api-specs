// This file moves Agent Insights preview operations to Azure.AI.Projects.Beta for the
// Python and JavaScript SDKs. Other language entry points do not import Agent Insights.

using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects.Beta;

interface AgentInsightMonitors {}
@@clientLocation(
  Azure.AI.Projects.AgentInsightMonitors.list,
  AgentInsightMonitors
);
@@clientLocation(
  Azure.AI.Projects.AgentInsightMonitors.create,
  AgentInsightMonitors
);
@@clientLocation(
  Azure.AI.Projects.AgentInsightMonitors.get,
  AgentInsightMonitors
);
@@clientLocation(
  Azure.AI.Projects.AgentInsightMonitors.delete,
  AgentInsightMonitors
);
@@clientLocation(
  Azure.AI.Projects.AgentInsightMonitors.update,
  AgentInsightMonitors
);
@@clientLocation(
  Azure.AI.Projects.AgentInsightMonitors.reset,
  AgentInsightMonitors
);
@@clientLocation(
  Azure.AI.Projects.AgentInsightMonitors.createRun,
  AgentInsightMonitors
);
@@clientLocation(
  Azure.AI.Projects.AgentInsightMonitors.listRuns,
  AgentInsightMonitors
);
@@clientLocation(
  Azure.AI.Projects.AgentInsightMonitors.getRun,
  AgentInsightMonitors
);
@@clientLocation(
  Azure.AI.Projects.AgentInsightMonitors.cancelRun,
  AgentInsightMonitors
);
@@clientLocation(
  Azure.AI.Projects.AgentInsightMonitors.listInsights,
  AgentInsightMonitors
);
@@clientLocation(
  Azure.AI.Projects.AgentInsightMonitors.getInsight,
  AgentInsightMonitors
);
@@clientLocation(
  Azure.AI.Projects.AgentInsightMonitors.updateInsight,
  AgentInsightMonitors
);
