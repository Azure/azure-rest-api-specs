import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.SecurityInsights;

alias OperationalInsights = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "workspaceName",
  Description = "The name of the monitor workspace.",
  NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$"
>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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

@@minLength(Extension.ExternalResource.name, 1);
@@maxLength(Extension.ExternalResource.name, 90);
