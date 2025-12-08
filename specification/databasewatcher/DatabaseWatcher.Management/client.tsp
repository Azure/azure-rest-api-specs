import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DatabaseWatcher;

@@clientName(Microsoft.DatabaseWatcher, "DatabaseWatcherMgmtClient", "python");
@@clientName(Microsoft.DatabaseWatcher,
  "DatabaseWatcherManagementClient",
  "java"
);

// csharp
@@clientName(AlertRuleResource, "DatabaseWatcherAlertRule", "csharp");
@@clientName(AlertRuleResourceProperties,
  "DatabaseWatcherAlertRuleProperties",
  "csharp"
);
@@clientName(HealthValidation, "DatabaseWatcherHealthValidation", "csharp");
@@clientName(HealthValidationProperties,
  "DatabaseWatcherHealthValidationProperties",
  "csharp"
);
@@clientName(SharedPrivateLinkResource,
  "DatabaseWatcherSharedPrivateLinkResource",
  "csharp"
);
@@clientName(SharedPrivateLinkResourceProperties,
  "DatabaseWatcherSharedPrivateLinkResourceProperties",
  "csharp"
);
@@clientName(SharedPrivateLinkResourceStatus,
  "DatabaseWatcherSharedPrivateLinkResourceStatus",
  "csharp"
);
@@clientName(Target, "DatabaseWatcherTarget", "csharp");
@@clientName(TargetProperties, "DatabaseWatcherTargetProperties", "csharp");
@@clientName(Watcher, "DatabaseWatcher", "csharp");
@@clientName(WatcherProperties, "DatabaseWatcherProperties", "csharp");
@@clientName(validationStatus,
  "DatabaseWatcherHealthValidationStatus",
  "csharp"
);
@@clientName(ValidationIssue, "DatabaseWatcherHealthValidationIssue", "csharp");
@@clientName(Datastore, "DatabaseWatcherDatastore", "csharp");
@@clientName(SqlDbElasticPoolTargetProperties,
  "SqlDBElasticPoolTargetProperties",
  "csharp"
);
@@clientName(SqlDbSingleDatabaseTargetProperties,
  "SqlDBSingleDatabaseTargetProperties",
  "csharp"
);
@@clientName(SqlMiTargetProperties, "SqlMITargetProperties", "csharp");
@@clientName(VaultSecret, "TargetAuthenticationVaultSecret", "csharp");
@@clientName(WatcherStatus, "DatabaseWatcherStatus", "csharp");
@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "DatabaseWatcherResourceProvisioningState",
  "csharp"
);
@@clientName(alertRuleCreationProperties,
  "alertRuleCreationProperty",
  "csharp"
);
@@alternateType(Datastore.kustoClusterUri, url, "csharp");
@@alternateType(Datastore.kustoDataIngestionUri, url, "csharp");
@@alternateType(Datastore.kustoManagementUrl, url, "csharp");
@@alternateType(ValidationIssue.relatedResourceType,
  Azure.Core.armResourceType,
  "csharp"
);
