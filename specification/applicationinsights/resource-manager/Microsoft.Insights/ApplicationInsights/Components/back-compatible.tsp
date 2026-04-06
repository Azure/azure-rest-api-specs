import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Components;

// @@clientName(ApplicationInsightsComponentProperties.ApplicationId,
//   "applicationId"
// );
// @@clientName(ApplicationInsightsComponentProperties.AppId, "appId");
// @@clientName(ApplicationInsightsComponentProperties.Name, "name");
// @@clientName(ApplicationInsightsComponentProperties.Application_Type,
//   "applicationType"
// );
// @@clientName(ApplicationInsightsComponentProperties.Flow_Type, "flowType");
// @@clientName(ApplicationInsightsComponentProperties.Request_Source,
//   "requestSource"
// );
// @@clientName(ApplicationInsightsComponentProperties.InstrumentationKey,
//   "instrumentationKey"
// );
// @@clientName(ApplicationInsightsComponentProperties.CreationDate,
//   "creationDate"
// );
// @@clientName(ApplicationInsightsComponentProperties.TenantId, "tenantId");
// @@clientName(ApplicationInsightsComponentProperties.HockeyAppId, "hockeyAppId");
// @@clientName(ApplicationInsightsComponentProperties.HockeyAppToken,
//   "hockeyAppToken"
// );
// @@clientName(ApplicationInsightsComponentProperties.SamplingPercentage,
//   "samplingPercentage"
// );
// @@clientName(ApplicationInsightsComponentProperties.ConnectionString,
//   "connectionString"
// );
// @@clientName(ApplicationInsightsComponentProperties.RetentionInDays,
//   "retentionInDays"
// );
// @@clientName(ApplicationInsightsComponentProperties.DisableIpMasking,
//   "disableIpMasking"
// );
// @@clientName(ApplicationInsightsComponentProperties.ImmediatePurgeDataOn30Days,
//   "immediatePurgeDataOn30Days"
// );
// @@clientName(ApplicationInsightsComponentProperties.WorkspaceResourceId,
//   "workspaceResourceId"
// );
// @@clientName(ApplicationInsightsComponentProperties.LaMigrationDate,
//   "laMigrationDate"
// );
// @@clientName(ApplicationInsightsComponentProperties.PrivateLinkScopedResources,
//   "privateLinkScopedResources"
// );
// @@clientName(ApplicationInsightsComponentProperties.IngestionMode,
//   "ingestionMode"
// );
// @@clientName(ApplicationInsightsComponentProperties.DisableLocalAuth,
//   "disableLocalAuth"
// );
// @@clientName(ApplicationInsightsComponentProperties.ForceCustomerStorageForProfiler,
//   "forceCustomerStorageForProfiler"
// );

// @@clientName(PrivateLinkScopedResource.ResourceId, "resourceId");
// @@clientName(PrivateLinkScopedResource.ScopeId, "scopeId");

@@clientLocation(ApplicationInsightsComponents.get, "Components");
@@clientLocation(ApplicationInsightsComponents.createOrUpdate, "Components");
@@clientName(ApplicationInsightsComponents.createOrUpdate::parameters.resource,
  "InsightProperties"
);
@@clientLocation(ApplicationInsightsComponents.updateTags, "Components");
@@clientName(ApplicationInsightsComponents.updateTags::parameters.properties,
  "ComponentTags"
);
@@clientLocation(ApplicationInsightsComponents.delete, "Components");
@@clientLocation(ApplicationInsightsComponents.listByResourceGroup,
  "Components"
);
@@clientLocation(ApplicationInsightsComponents.list, "Components");
@@clientLocation(ApplicationInsightsComponents.purge, "Components");
@@clientLocation(ComponentPurgeStatusOperationGroup.getPurgeStatus,
  "Components"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationInsightsComponent.properties);
