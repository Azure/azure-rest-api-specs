# Security Insight

> see https://aka.ms/autorest

This is the AutoRest configuration file for SecurityInsights.

---

## Getting Started

To build the SDK for SecurityInsights, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the SecurityInsights API.

``` yaml
openapi-type: arm
tag: package-2023-11
```

---


### Tag: package-2023-11

These settings apply only when `--tag=package-2023-11` is specified on the command line.

```yaml $(tag) == 'package-2023-11'
input-file:
  - Microsoft.SecurityInsights/stable/2023-11-01/AlertRules.json
  - Microsoft.SecurityInsights/stable/2023-11-01/AutomationRules.json
  - Microsoft.SecurityInsights/stable/2023-11-01/Bookmarks.json
  - Microsoft.SecurityInsights/stable/2023-11-01/ContentPackages.json
  - Microsoft.SecurityInsights/stable/2023-11-01/ContentProductPackages.json
  - Microsoft.SecurityInsights/stable/2023-11-01/ContentProductTemplates.json
  - Microsoft.SecurityInsights/stable/2023-11-01/ContentTemplates.json
  - Microsoft.SecurityInsights/stable/2023-11-01/DataConnectors.json
  - Microsoft.SecurityInsights/stable/2023-11-01/Incidents.json
  - Microsoft.SecurityInsights/stable/2023-11-01/Metadata.json
  - Microsoft.SecurityInsights/stable/2023-11-01/OnboardingStates.json
  - Microsoft.SecurityInsights/stable/2023-11-01/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/stable/2023-11-01/SourceControls.json
  - Microsoft.SecurityInsights/stable/2023-11-01/ThreatIntelligence.json
  - Microsoft.SecurityInsights/stable/2023-11-01/Watchlists.json
  - Microsoft.SecurityInsights/stable/2023-11-01/operations.json
```
### Tag: package-preview-2023-10

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-10'
input-file:
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/BillingStatistics.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/ContentPackages.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/ContentProductPackages.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/ContentProductTemplates.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/ContentTemplates.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/FileImports.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/Hunts.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/Recommendations.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/TriggeredAnalyticsRuleRuns.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/WorkspaceManagerAssignments.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/WorkspaceManagerConfigurations.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/WorkspaceManagerGroups.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/WorkspaceManagerMembers.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/dataConnectorDefinitions.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2023-10-01-preview/operations.json
```

### Tag: package-preview-2023-09

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-09'
input-file:
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/BillingStatistics.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/ContentPackages.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/ContentProductPackages.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/ContentProductTemplates.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/ContentTemplates.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/FileImports.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/Hunts.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/Recommendations.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/TriggeredAnalyticsRuleRuns.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/WorkspaceManagerAssignments.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/WorkspaceManagerConfigurations.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/WorkspaceManagerGroups.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/WorkspaceManagerMembers.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/dataConnectorDefinitions.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2023-09-01-preview/operations.json
```

### Tag: package-preview-2023-08

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-08'
input-file:
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/BillingStatistics.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/ContentPackages.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/ContentProductPackages.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/ContentProductTemplates.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/ContentTemplates.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/FileImports.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/Hunts.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/Recommendations.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/TriggeredAnalyticsRuleRuns.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/WorkspaceManagerAssignments.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/WorkspaceManagerConfigurations.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/WorkspaceManagerGroups.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/WorkspaceManagerMembers.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/dataConnectorDefinitions.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2023-08-01-preview/operations.json
```

### Tag: package-preview-2023-07

These settings apply only when `--tag=package-preview-2023-07` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-07'
input-file:
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/BillingStatistics.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/ContentPackages.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/ContentProductPackages.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/ContentProductTemplates.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/ContentTemplates.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/FileImports.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/Hunts.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/Recommendations.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/TriggeredAnalyticsRuleRuns.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/WorkspaceManagerAssignments.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/WorkspaceManagerConfigurations.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/WorkspaceManagerGroups.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/WorkspaceManagerMembers.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/dataConnectorDefinitions.json
  - Microsoft.SecurityInsights/preview/2023-07-01-preview/operations.json
```

### Tag: package-preview-2023-06

These settings apply only when `--tag=package-preview-2023-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-06'
input-file:
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/BillingStatistics.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/ContentPackages.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/ContentProductPackages.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/ContentProductTemplates.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/ContentTemplates.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/FileImports.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/Hunts.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/Recommendations.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/TriggeredAnalyticsRuleRuns.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/WorkspaceManagerAssignments.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/WorkspaceManagerConfigurations.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/WorkspaceManagerGroups.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/WorkspaceManagerMembers.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2023-06-01-preview/operations.json
```

### Tag: package-preview-2023-05

These settings apply only when `--tag=package-preview-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-05'
input-file:
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/BillingStatistics.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/ContentPackages.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/ContentProductPackages.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/ContentProductTemplates.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/ContentTemplates.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/FileImports.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/Hunts.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/Recommendations.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/TriggeredAnalyticsRuleRuns.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/WorkspaceManagerAssignments.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/WorkspaceManagerConfigurations.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/WorkspaceManagerGroups.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/WorkspaceManagerMembers.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2023-05-01-preview/operations.json
```

### Tag: package-preview-2023-04

These settings apply only when `--tag=package-preview-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-04'
input-file:
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/ContentPackages.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/ContentProductPackages.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/ContentProductTemplates.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/ContentTemplates.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/FileImports.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/Hunts.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/Recommendations.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/TriggeredAnalyticsRuleRuns.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/WorkspaceManagerGroups.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/WorkspaceManagerAssignments.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/WorkspaceManagerConfigurations.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/WorkspaceManagerMembers.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2023-04-01-preview/operations.json
```

### Tag: package-preview-2023-03

These settings apply only when `--tag=package-preview-2023-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-03'
input-file:
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/FileImports.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/Recommendations.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/TriggeredAnalyticsRuleRuns.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2023-03-01-preview/operations.json
```

### Tag: package-2023-02

These settings apply only when `--tag=package-2023-02` is specified on the command line.

``` yaml $(tag) == 'package-2023-02'
input-file:
  - Microsoft.SecurityInsights/stable/2023-02-01/AlertRules.json
  - Microsoft.SecurityInsights/stable/2023-02-01/AutomationRules.json
  - Microsoft.SecurityInsights/stable/2023-02-01/Bookmarks.json
  - Microsoft.SecurityInsights/stable/2023-02-01/DataConnectors.json
  - Microsoft.SecurityInsights/stable/2023-02-01/Incidents.json
  - Microsoft.SecurityInsights/stable/2023-02-01/Metadata.json
  - Microsoft.SecurityInsights/stable/2023-02-01/OnboardingStates.json
  - Microsoft.SecurityInsights/stable/2023-02-01/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/stable/2023-02-01/ThreatIntelligence.json
  - Microsoft.SecurityInsights/stable/2023-02-01/Watchlists.json
  - Microsoft.SecurityInsights/stable/2023-02-01/operations.json
```

### Tag: package-preview-2023-02

These settings apply only when `--tag=package-preview-2023-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-02'
input-file:
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/TriggeredAnalyticsRuleRuns.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/FileImports.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/Recommendations.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2023-02-01-preview/operations.json
```

### Tag: package-preview-2022-12

These settings apply only when `--tag=package-preview-2022-12` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-12'
input-file:
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/FileImports.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/Recommendations.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2022-12-01-preview/operations.json
```

### Tag: package-2022-11

These settings apply only when `--tag=package-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-2022-11'
input-file:
  - Microsoft.SecurityInsights/stable/2022-11-01/AlertRules.json
  - Microsoft.SecurityInsights/stable/2022-11-01/AutomationRules.json
  - Microsoft.SecurityInsights/stable/2022-11-01/Bookmarks.json
  - Microsoft.SecurityInsights/stable/2022-11-01/DataConnectors.json
  - Microsoft.SecurityInsights/stable/2022-11-01/Incidents.json
  - Microsoft.SecurityInsights/stable/2022-11-01/OnboardingStates.json
  - Microsoft.SecurityInsights/stable/2022-11-01/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/stable/2022-11-01/ThreatIntelligence.json
  - Microsoft.SecurityInsights/stable/2022-11-01/Watchlists.json
  - Microsoft.SecurityInsights/stable/2022-11-01/operations.json
```

### Tag: package-preview-2022-11

These settings apply only when `--tag=package-preview-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-11'
input-file:
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/FileImports.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/Recommendations.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2022-11-01-preview/operations.json
```

### Tag: package-preview-2022-10

These settings apply only when `--tag=package-preview-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-10'
input-file:
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/FileImports.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2022-10-01-preview/operations.json
```

### Tag: package-preview-2022-09

These settings apply only when `--tag=package-preview-2022-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-09'
input-file:
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/FileImports.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2022-09-01-preview/operations.json
```

### Tag: package-preview-2022-08

These settings apply only when `--tag=package-preview-2022-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-08'
input-file:
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/FileImports.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2022-08-01-preview/operations.json
```

### Tag: package-preview-2022-07

These settings apply only when `--tag=package-preview-2022-07` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-07'
input-file:
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2022-07-01-preview/operations.json
```

### Tag: package-2022-08

These settings apply only when `--tag=package-2022-08` is specified on the command line.

``` yaml $(tag) == 'package-2022-08'
input-file:
  - Microsoft.SecurityInsights/stable/2022-08-01/AlertRules.json
  - Microsoft.SecurityInsights/stable/2022-08-01/AutomationRules.json
  - Microsoft.SecurityInsights/stable/2022-08-01/Bookmarks.json
  - Microsoft.SecurityInsights/stable/2022-08-01/DataConnectors.json
  - Microsoft.SecurityInsights/stable/2022-08-01/Incidents.json
  - Microsoft.SecurityInsights/stable/2022-08-01/OnboardingStates.json
  - Microsoft.SecurityInsights/stable/2022-08-01/ThreatIntelligence.json
  - Microsoft.SecurityInsights/stable/2022-08-01/Watchlists.json
  - Microsoft.SecurityInsights/stable/2022-08-01/operations.json
```

### Tag: package-preview-2022-06

These settings apply only when `--tag=package-preview-2022-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-06'
input-file:
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2022-06-01-preview/operations.json
```

### Tag: package-preview-2022-05

These settings apply only when `--tag=package-preview-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-05'
input-file:
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/SecurityMLAnalyticsSettings.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2022-05-01-preview/operations.json
```

### Tag: package-preview-2022-04

These settings apply only when `--tag=package-preview-2022-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-04'
input-file:
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2022-04-01-preview/operations.json
```

### Tag: package-preview-2022-01

These settings apply only when `--tag=package-preview-2022-01` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-01'
input-file:
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2022-01-01-preview/operations.json
```

### Tag: package-preview-2021-10

These settings apply only when `--tag=package-preview-2021-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-10'
input-file:
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/AlertRules.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/AutomationRules.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/Bookmarks.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/Enrichment.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/Entities.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/EntityQueries.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/EntityQueryTemplates.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/Incidents.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/Metadata.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/OfficeConsents.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/OnboardingStates.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/Settings.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/SourceControls.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/ThreatIntelligence.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/Watchlists.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/dataConnectors.json
  - Microsoft.SecurityInsights/preview/2021-10-01-preview/operations.json
```

### Tag: package-preview-2021-09

These settings apply only when `--tag=package-preview-2021-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-09'
input-file:
- Microsoft.SecurityInsights/preview/2021-09-01-preview/AlertRules.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/AutomationRules.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/Bookmarks.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/Enrichment.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/EntityQueries.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/Entities.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/Incidents.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/Metadata.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/OnboardingStates.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/Settings.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/SourceControls.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/Watchlists.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/dataConnectors.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/ThreatIntelligence.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/operations.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/OfficeConsents.json
- Microsoft.SecurityInsights/preview/2021-09-01-preview/EntityQueryTemplates.json
```

---

### Tag: package-2021-10

These settings apply only when `--tag=package-2021-10` is specified on the command line.

``` yaml $(tag) == 'package-2021-10'
input-file:
  - Microsoft.SecurityInsights/stable/2021-10-01/Incidents.json
  - Microsoft.SecurityInsights/stable/2021-10-01/ThreatIntelligence.json
  - Microsoft.SecurityInsights/stable/2021-10-01/Watchlists.json
  - Microsoft.SecurityInsights/stable/2021-10-01/operations.json
  - Microsoft.SecurityInsights/stable/2021-10-01/OnboardingStates.json
  - Microsoft.SecurityInsights/stable/2021-10-01/AlertRules.json
  - Microsoft.SecurityInsights/stable/2021-10-01/Bookmarks.json
  - Microsoft.SecurityInsights/stable/2021-10-01/DataConnectors.json
  - Microsoft.SecurityInsights/stable/2021-10-01/AutomationRules.json
```

### Tag: package-2021-04-01-only

These settings apply only when `--tag=package-2021-04-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2021-04-01-only'
input-file:
- Microsoft.SecurityInsights/stable/2021-04-01/Incidents.json
- Microsoft.SecurityInsights/stable/2021-04-01/operations.json
- Microsoft.SecurityInsights/stable/2021-04-01/Watchlists.json
- Microsoft.SecurityInsights/stable/2021-04-01/ThreatIntelligence.json
```

---

### Tag: package-2020-01

These settings apply only when `--tag=package-2020-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-01'
input-file:
- Microsoft.SecurityInsights/stable/2020-01-01/AlertRules.json
- Microsoft.SecurityInsights/stable/2020-01-01/Bookmarks.json
- Microsoft.SecurityInsights/stable/2020-01-01/DataConnectors.json
- Microsoft.SecurityInsights/stable/2020-01-01/SecurityInsights.json
```

---

### Tag: package-2021-03-preview-only

These settings apply only when `--tag=package-2021-03-preview-only` is specified on the command line.

``` yaml $(tag) == 'package-2021-03-preview-only'
input-file:
- Microsoft.SecurityInsights/preview/2021-03-01-preview/Incidents.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/Settings.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/OnboardingStates.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/operations.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/SourceControls.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/dataConnectors.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/Watchlists.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/AlertRules.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/EntityQueries.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/EntityQueryTemplates.json
- Microsoft.SecurityInsights/preview/2021-03-01-preview/Metadata.json
```

---

### Tag: package-2019-01-preview

These settings apply only when `--tag=package-2019-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-01-preview'
input-file:
- Microsoft.SecurityInsights/preview/2019-01-01-preview/Aggregations.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/AutomationRules.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/Bookmarks.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/Cases.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/DataConnectorsCheckRequirements.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/Enrichment.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/Entities.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/OfficeConsents.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/SecurityInsights.json
- Microsoft.SecurityInsights/preview/2019-01-01-preview/ThreatIntelligence.json
```

---

## Suppression

``` yaml
directive:
  - suppress: R4017
    reason: Our resources do not support list by subscription. They're not top-level resources. To get a SecurityInsights resource, we should have a subscription as well as a resource group and Log Analytics workspace.
  - suppress: OBJECT_ADDITIONAL_PROPERTIES
    reason: 'Caused by a duplicate Resource definition in our common directory that contains systemData. We were instructed to supress this by Swagger reviewr.'
  - suppress: GuidUsage
    reason: 'Tenent Id should be a Guid'
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-java
  - repo: azure-cli-extensions
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.SecurityInsights
  payload-flattening-threshold: 2
  output-folder: $(csharp-sdks-folder)/securityinsights/Microsoft.Azure.Management.SecurityInsights/src/Generated
  clear-output-folder: true
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Node.js

See configuration in [readme.nodejs.md](./readme.nodejs.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
