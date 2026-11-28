import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(ContentSafety.Versions.v2026_10_15_preview)
namespace Customizations;

@client({
  name: "ContentSafetyClient",
  service: ContentSafety,
})
interface ContentSafetyClient {
  analyzeImage is ContentSafety.ImageOperations.analyzeImage;
  analyzeText is ContentSafety.TextOperations.analyzeText;
  detectTextProtectedMaterial is ContentSafety.TextOperations.detectTextProtectedMaterial;
  shieldPrompt is ContentSafety.TextOperations.shieldPrompt;
  unifiedModerate is ContentSafety.UnifiedOperations.unifiedModerate;
}

@client({
  name: "ContentProvenanceClient",
  service: ContentSafety,
})
@TypeSpec.Http.route("/provenance")
interface ContentProvenanceClient {
  detect is ContentSafety.ContentProvenanceOperations.detect;
  getOperationStatus is ContentSafety.ContentProvenanceOperations.getOperationStatus;
}

@client({
  name: "BlocklistClient",
  service: ContentSafety,
})
interface BlocklistClient {
  addOrUpdateBlocklistItems is ContentSafety.TextBlocklists.addOrUpdateBlocklistItems;
  @convenientAPI(false, "csharp") // csharp is not ready for patch operations, therefore hide the convenience API of this operation
  createOrUpdateTextBlocklist is ContentSafety.TextBlocklists.createOrUpdateTextBlocklist;
  deleteTextBlocklist is ContentSafety.TextBlocklists.deleteTextBlocklist;
  getTextBlocklist is ContentSafety.TextBlocklists.getTextBlocklist;
  getTextBlocklistItem is ContentSafety.TextBlocklists.getTextBlocklistItem;
  listTextBlocklistItems is ContentSafety.TextBlocklists.listTextBlocklistItems;
  listTextBlocklists is ContentSafety.TextBlocklists.listTextBlocklists;
  removeBlocklistItems is ContentSafety.TextBlocklists.removeBlocklistItems;
}
@@clientName(
  ContentSafety.UnifiedModerateOptions,
  "UnifiedModerateConfig",
  "csharp"
);
@@clientName(
  Azure.Core.Foundations.ResourceBody.resource,
  "options",
  "!autorest"
);

@@clientName(ContentSafety.AgentContext.timestamp, "createdAt");
@@clientName(ContentSafety.AgentContext.agentInit, "initialization");
@@clientName(ContentSafety.AgentStartupContext.agentInit, "initialization");
@@clientName(ContentSafety.AgentEvidence.artefact, "artifact");
@@clientName(ContentSafety.AgentHarmResult.url, "uri", "csharp");

// Use native duration types without changing Agent Hooks' fractional numeric wire values.
#suppress "@azure-tools/typespec-azure-core/known-encoding" "Agent Hooks duration_ms is a JSON number in milliseconds. Encoding a Java or .NET duration as ISO 8601 text or seconds would change its wire value."
@encode(DurationKnownEncoding.milliseconds, float64)
scalar MillisecondDuration extends duration;

@encode(DurationKnownEncoding.seconds, float64)
scalar SecondDuration extends duration;

@@alternateType(
  ContentSafety.AgentToolResult.durationMs,
  MillisecondDuration,
  "java,csharp"
);
@@clientName(
  ContentSafety.AgentToolResult.durationMs,
  "duration",
  "java,csharp"
);
@@alternateType(
  ContentSafety.AgentSummary.durationSeconds,
  SecondDuration,
  "java,csharp"
);
@@clientName(
  ContentSafety.AgentSummary.durationSeconds,
  "duration",
  "java,csharp"
);
@@alternateType(
  ContentSafety.AgentBudgets.elapsedSeconds,
  SecondDuration,
  "java,csharp"
);
@@clientName(
  ContentSafety.AgentBudgets.elapsedSeconds,
  "elapsed",
  "java,csharp"
);
