import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AnalyticsItems;

// @@clientName(ApplicationInsightsComponentAnalyticsItem.Id, "id");
// @@clientName(ApplicationInsightsComponentAnalyticsItem.Name, "name");
// @@clientName(ApplicationInsightsComponentAnalyticsItem.Content, "content");
// @@clientName(ApplicationInsightsComponentAnalyticsItem.Version, "version");
// @@clientName(ApplicationInsightsComponentAnalyticsItem.Scope, "scope");
// @@clientName(ApplicationInsightsComponentAnalyticsItem.Type, "type");
// @@clientName(ApplicationInsightsComponentAnalyticsItem.TimeCreated,
//   "timeCreated"
// );
// @@clientName(ApplicationInsightsComponentAnalyticsItem.TimeModified,
//   "timeModified"
// );
// @@clientName(ApplicationInsightsComponentAnalyticsItem.Properties,
//   "properties"
// );

@@clientLocation(AnalyticsItemsOperationGroup.list, "AnalyticsItems");
@@clientLocation(AnalyticsItemsOperationGroup.get, "AnalyticsItems");
@@clientLocation(AnalyticsItemsOperationGroup.put, "AnalyticsItems");
@@clientLocation(AnalyticsItemsOperationGroup.delete, "AnalyticsItems");
