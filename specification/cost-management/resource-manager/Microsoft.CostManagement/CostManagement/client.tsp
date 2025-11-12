import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.CostManagement;

// Rename PivotTypeType back to PivotType for Java
@@clientName(PivotTypeType, "PivotType", "java");

// Rename KpiTypeType back to KpiType for Java
@@clientName(KpiTypeType, "KpiType", "java");

// Rename DownloadURL back to DownloadUrl for Java
@@clientName(DownloadURL, "DownloadUrl", "java");

// Rename ReportURL back to ReportUrl for Java
@@clientName(ReportURL, "ReportUrl", "java");

// Rename statusModificationUserName back to statusModificationUsername for Java
@@clientName(AlertProperties.statusModificationUserName,
  "statusModificationUsername",
  "java"
);

@@alternateType(AlertPropertiesDetails.tagFilter, unknown, "java");

// Rename eTag back to etag for Java (backward compatibility)
@@clientName(CostManagementProxyResource.eTag, "etag", "java");
@@clientName(CostManagementResource.eTag, "etag", "java");
@@clientName(View.eTag, "etag", "java");
@@clientName(ScheduledAction.eTag, "etag", "java");
@@clientName(Export.eTag, "etag", "java");
@@clientName(Alert.eTag, "etag", "java");
