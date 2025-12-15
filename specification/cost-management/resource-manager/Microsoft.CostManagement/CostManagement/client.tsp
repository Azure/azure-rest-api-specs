import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Http;
using Azure.ClientGenerator.Core;
using Microsoft.CostManagement;

// Rename PivotTypeType back to PivotType for Java
@@clientName(PivotTypeType, "PivotType", "java,javascript");

// Rename KpiTypeType back to KpiType for Java
@@clientName(KpiTypeType, "KpiType", "java,javascript");

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

@@clientName(Microsoft.CostManagement, "CostManagementClient", "python");
@@clientName(Azure.ResourceManager.CommonTypes.ErrorResponse,
  "ArmErrorResponse",
  "python,javascript"
);
@@clientName(Term.P1Y, "P1_Y", "python");
@@clientName(Term.P3Y, "P3_Y", "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op GetGenerateDetailedCostReportOperationResultCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  extensionProvider: "Microsoft.CostManagement",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path("operationId")
  operationId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path(#{ allowReserved: true })
  scope: string,
): GenerateDetailedCostReportOperationResult;

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op GetGenerateDetailedCostReportOperationStatusCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  extensionProvider: "Microsoft.CostManagement",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path("operationId")
  operationId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path(#{ allowReserved: true })
  scope: string,
): GenerateDetailedCostReportOperationStatus;

@@override(GenerateDetailedCostReportOperationResults.get,
  GetGenerateDetailedCostReportOperationResultCustomized,
  "python,go,java,javascript"
);
@@override(GenerateDetailedCostReportOperationStatus.get,
  GetGenerateDetailedCostReportOperationStatusCustomized,
  "python,go,java,javascript"
);
@@clientName(DimensionsOperationGroup.byExternalCloudProviderType,
  "listByExternalCloudProviderType",
  "javascript"
);
