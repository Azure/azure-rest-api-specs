import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.SecurityInsights;

alias OperationalInsights = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "workspaceName",
  Description = "The name of the monitor workspace."
>;

@armVirtualResource
@singleton("main")
model ThreatIntelligenceMain {
  ...ResourceNameParameter<
    Resource = ThreatIntelligenceMain,
    KeyName = "threatIntelligenceName",
    SegmentName = "threatIntelligence",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$"
  >;
}
