import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.CostManagement;

// Java-specific customizations to mitigate breaking changes

// Rename PivotTypeType back to PivotType for Java
@@clientName(PivotTypeType, "PivotType", "java");

// Rename KpiTypeType back to KpiType for Java
@@clientName(KpiTypeType, "KpiType", "java");

// Rename DownloadURL back to DownloadUrl for Java
@@clientName(DownloadURL, "DownloadUrl", "java");

// Rename statusModificationUserName back to statusModificationUsername for Java
@@clientName(AlertPropertiesDetails.statusModificationUserName,
  "statusModificationUsername",
  "java"
);
@@clientName(DismissAlertPayload.statusModificationUserName,
  "statusModificationUsername",
  "java"
);

// Keep tagFilter as Object instead of Map for Java
@@alternateType(AlertPropertiesDetails.tagFilter, unknown, "java");
