import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ActivityLogsApi;

@@clientLocation(ActivityLogsOperationGroup.list, "ActivityLogs");

@@clientLocation(EventCategoriesOperationGroup.list, "EventCategories");

@@clientLocation(TenantActivityLogsOperationGroup.list, "TenantActivityLogs");
