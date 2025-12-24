import "./main.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using Http;
using Azure.ClientGenerator.Core;
using Microsoft.Web;
using Azure.ResourceManager;

// python
@@clientName(Microsoft.Web, "WebSiteManagementClient", "python");
@@clientName(WebApps.swapSlotSlot, "swapSlot", "python");

@@clientName(SupportedTlsVersions.`1.0`, "ONE0", "python");
@@clientName(SupportedTlsVersions.`1.1`, "ONE1", "python");
@@clientName(SupportedTlsVersions.`1.2`, "ONE2", "python");
@@clientName(SupportedTlsVersions.`1.3`, "ONE3", "python");

@@clientName(TlsCipherSuites.TLS_AES_256_GCM_SHA384,
  "TLS_AES256_GCM_SHA384",
  "python"
);
@@clientName(TlsCipherSuites.TLS_AES_128_GCM_SHA256,
  "TLS_AES128_GCM_SHA256",
  "python"
);
@@clientName(TlsCipherSuites.TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,
  "TLS_ECDHE_ECDSA_WITH_AES256_GCM_SHA384",
  "python"
);
@@clientName(TlsCipherSuites.TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,
  "TLS_ECDHE_ECDSA_WITH_AES128_CBC_SHA256",
  "python"
);
@@clientName(TlsCipherSuites.TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,
  "TLS_ECDHE_ECDSA_WITH_AES128_GCM_SHA256",
  "python"
);
@@clientName(TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,
  "TLS_ECDHE_RSA_WITH_AES256_GCM_SHA384",
  "python"
);
@@clientName(TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,
  "TLS_ECDHE_RSA_WITH_AES128_GCM_SHA256",
  "python"
);
@@clientName(TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384,
  "TLS_ECDHE_RSA_WITH_AES256_CBC_SHA384",
  "python"
);
@@clientName(TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,
  "TLS_ECDHE_RSA_WITH_AES128_CBC_SHA256",
  "python"
);
@@clientName(TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,
  "TLS_ECDHE_RSA_WITH_AES256_CBC_SHA",
  "python"
);
@@clientName(TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,
  "TLS_ECDHE_RSA_WITH_AES128_CBC_SHA",
  "python"
);
@@clientName(TlsCipherSuites.TLS_RSA_WITH_AES_256_GCM_SHA384,
  "TLS_RSA_WITH_AES256_GCM_SHA384",
  "python"
);
@@clientName(TlsCipherSuites.TLS_RSA_WITH_AES_128_GCM_SHA256,
  "TLS_RSA_WITH_AES128_GCM_SHA256",
  "python"
);
@@clientName(TlsCipherSuites.TLS_RSA_WITH_AES_256_CBC_SHA256,
  "TLS_RSA_WITH_AES256_CBC_SHA256",
  "python"
);
@@clientName(TlsCipherSuites.TLS_RSA_WITH_AES_128_CBC_SHA256,
  "TLS_RSA_WITH_AES128_CBC_SHA256",
  "python"
);
@@clientName(TlsCipherSuites.TLS_RSA_WITH_AES_256_CBC_SHA,
  "TLS_RSA_WITH_AES256_CBC_SHA",
  "python"
);
@@clientName(TlsCipherSuites.TLS_RSA_WITH_AES_128_CBC_SHA,
  "TLS_RSA_WITH_AES128_CBC_SHA",
  "python"
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op diagnosticsExecuteSiteAnalysisSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  siteName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  diagnosticCategory: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  analysisName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  /**
   * Start Time
   */
  @query("startTime")
  startTime?: utcDateTime,

  /**
   * End Time
   */
  @query("endTime")
  endTime?: utcDateTime,

  /**
   * Time Grain
   */
  @pattern("PT[1-9][0-9]+[SMH]")
  @query("timeGrain")
  timeGrain?: string,

  @body
  body: void,
): ArmResponse<DiagnosticAnalysis>;

@@override(AnalysisDefinitionOperationGroup.executeSiteAnalysisSlot,
  diagnosticsExecuteSiteAnalysisSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op diagnosticsExecuteSiteDetectorCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  siteName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  detectorName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  diagnosticCategory: string,

  /**
   * Start Time
   */
  @query("startTime")
  startTime?: utcDateTime,

  /**
   * End Time
   */
  @query("endTime")
  endTime?: utcDateTime,

  /**
   * Time Grain
   */
  @pattern("PT[1-9][0-9]+[SMH]")
  @query("timeGrain")
  timeGrain?: string,

  @body
  body: void,
): ArmResponse<DiagnosticDetectorResponse>;

@@override(DetectorDefinitionResources.executeSiteDetector,
  diagnosticsExecuteSiteDetectorCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op diagnosticsExecuteSiteDetectorSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  siteName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  detectorName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  diagnosticCategory: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  /**
   * Start Time
   */
  @query("startTime")
  startTime?: utcDateTime,

  /**
   * End Time
   */
  @query("endTime")
  endTime?: utcDateTime,

  /**
   * Time Grain
   */
  @pattern("PT[1-9][0-9]+[SMH]")
  @query("timeGrain")
  timeGrain?: string,

  @body
  body: void,
): ArmResponse<DiagnosticDetectorResponse>;

@@override(DetectorDefinitionResourceOperationGroup.executeSiteDetectorSlot,
  diagnosticsExecuteSiteDetectorSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op diagnosticsGetSiteAnalysisSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  siteName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  diagnosticCategory: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  analysisName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<AnalysisDefinition>;

@@override(AnalysisDefinitionOperationGroup.getSiteAnalysisSlot,
  diagnosticsGetSiteAnalysisSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op diagnosticsGetSiteDetectorResponseSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  siteName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  detectorName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  /**
   * Start Time
   */
  @query("startTime")
  startTime?: utcDateTime,

  /**
   * End Time
   */
  @query("endTime")
  endTime?: utcDateTime,

  /**
   * Time Grain
   */
  @pattern("PT[1-9][0-9]+[SMH]")
  @query("timeGrain")
  timeGrain?: string,
): ArmResponse<DetectorResponse>;

@@override(DetectorResponseOperationGroup.getSiteDetectorResponseSlot,
  diagnosticsGetSiteDetectorResponseSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op diagnosticsGetSiteDetectorSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  siteName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  diagnosticCategory: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  detectorName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<DetectorDefinitionResource>;

@@override(DetectorDefinitionResourceOperationGroup.getSiteDetectorSlot,
  diagnosticsGetSiteDetectorSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op diagnosticsGetSiteDiagnosticCategorySlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  siteName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  diagnosticCategory: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<DiagnosticCategory>;

@@override(DiagnosticCategoryOperationGroup.getSiteDiagnosticCategorySlot,
  diagnosticsGetSiteDiagnosticCategorySlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op diagnosticsListSiteAnalysesSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  siteName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  diagnosticCategory: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<DiagnosticAnalysisCollection>;

@@override(AnalysisDefinitionOperationGroup.listSiteAnalysesSlot,
  diagnosticsListSiteAnalysesSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op diagnosticsListSiteDetectorsSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  siteName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  diagnosticCategory: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<DiagnosticDetectorCollection>;

@@override(DetectorDefinitionResourceOperationGroup.listSiteDetectorsSlot,
  diagnosticsListSiteDetectorsSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op recommendationsDisableRecommendationForHostingEnvironmentCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query
  environmentName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  hostingEnvironmentName: string,

  @body
  body: void,
): {
  @body body: void;
};

@@override(RecommendationRules.disableRecommendationForHostingEnvironment,
  recommendationsDisableRecommendationForHostingEnvironmentCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsAddPremierAddOnSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  premierAddOnName: string,

  @body
  premierAddOn: PremierAddOn,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResourceUpdatedResponse<PremierAddOn>;

@@override(PremierAddOnOperationGroup.addPremierAddOnSlot,
  webAppsAddPremierAddOnSlotCustomized
);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsApproveOrRejectPrivateEndpointConnectionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  privateEndpointConnectionName: string,

  @body
  privateEndpointWrapper: RemotePrivateEndpointConnectionARMResource,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResourceUpdatedResponse<RemotePrivateEndpointConnectionARMResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = RemotePrivateEndpointConnectionARMResource>> & {
  @bodyRoot
  _: RemotePrivateEndpointConnectionARMResource;
});

@@override(PrivateEndpointConnectionSlotOperationGroup.approveOrRejectPrivateEndpointConnectionSlot,
  webAppsApproveOrRejectPrivateEndpointConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateInstanceFunctionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  functionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @body
  function_envelope: FunctionEnvelope,
): ArmResourceCreatedResponse<
  FunctionEnvelope,
  ArmLroLocationHeader<FinalResult = FunctionEnvelope> &
    Azure.Core.Foundations.RetryAfterHeader
>;

@@override(FunctionEnvelopeOperationGroup.createInstanceFunctionSlot,
  webAppsCreateInstanceFunctionSlotCustomized
);
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeletePrivateEndpointConnectionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  privateEndpointConnectionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<unknown> | (ArmDeleteAcceptedLroResponse & {
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @body
  _: unknown;
}) | (ArmDeletedNoContentResponse & {
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @body
  _: unknown;
});

@@override(PrivateEndpointConnectionSlotOperationGroup.deletePrivateEndpointConnectionSlot,
  webAppsDeletePrivateEndpointConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsInstallSiteExtensionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  siteExtensionId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  resource: void,
): ArmResponse<SiteExtensionInfo> | ArmResourceCreatedResponse<
  SiteExtensionInfo,
  LroHeaders = ArmLroLocationHeader<FinalResult = SiteExtensionInfo> &
    Azure.Core.Foundations.RetryAfterHeader
> | ArmTooManyRequestsResponse;

@@override(SiteExtensionInfoOperationGroup.installSiteExtensionSlot,
  webAppsInstallSiteExtensionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsMigrateStorageCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query
  subscriptionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  @body
  migrationOptions: StorageMigrationOptions,
): ArmResponse<StorageMigrationResponse> &
  ArmLroLocationHeader<FinalResult = StorageMigrationResponse>;

@@override(Sites.migrateStorage, webAppsMigrateStorageCustomized);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsRestoreSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  backupId: string,

  @body
  request: RestoreRequest,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): {
  @body body: void;
};

@@override(BackupItemOperationGroup.restoreSlot, webAppsRestoreSlotCustomized);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateDeploymentSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  id: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  deployment: Deployment,
): ArmResourceUpdatedResponse<Deployment>;

@@override(DeploymentOperationGroup.createDeploymentSlot,
  webAppsCreateDeploymentSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateOrUpdateDomainOwnershipIdentifierSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  domainOwnershipIdentifierName: string,

  @body
  domainOwnershipIdentifier: Identifier,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResourceUpdatedResponse<Identifier>;

@@override(IdentifierOperationGroup.createOrUpdateDomainOwnershipIdentifierSlot,
  webAppsCreateOrUpdateDomainOwnershipIdentifierSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateOrUpdateFunctionSecretSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  functionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  keyName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  key: KeyInfo,
): ArmResponse<KeyInfo> | ArmResourceCreatedSyncResponse<KeyInfo>;

@@override(FunctionEnvelopeOperationGroup.createOrUpdateFunctionSecretSlot,
  webAppsCreateOrUpdateFunctionSecretSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateOrUpdateHostNameBindingSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  hostName: string,

  @body
  hostNameBinding: HostNameBinding,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResourceUpdatedResponse<HostNameBinding>;

@@override(HostNameBindingOperationGroup.createOrUpdateHostNameBindingSlot,
  webAppsCreateOrUpdateHostNameBindingSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateOrUpdateHostSecretSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  keyType: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  keyName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  key: KeyInfo,
): ArmResponse<KeyInfo> | ArmResourceCreatedSyncResponse<KeyInfo> | DefaultErrorResponse;

@@override(WebApps.createOrUpdateHostSecretSlot,
  webAppsCreateOrUpdateHostSecretSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateOrUpdateHybridConnectionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  namespaceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  relayName: string,

  @body
  connectionEnvelope: HybridConnection,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResourceUpdatedResponse<HybridConnection>;

@@override(HybridConnectionSlotOperationGroup.createOrUpdateHybridConnectionSlot,
  webAppsCreateOrUpdateHybridConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateOrUpdatePublicCertificateSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  publicCertificateName: string,

  @body
  publicCertificate: PublicCertificate,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResourceUpdatedResponse<PublicCertificate>;

@@override(PublicCertificateOperationGroup.createOrUpdatePublicCertificateSlot,
  webAppsCreateOrUpdatePublicCertificateSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateOrUpdateRelayServiceConnectionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  entityName: string,

  @body
  connectionEnvelope: RelayServiceConnectionEntity,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResourceUpdatedResponse<RelayServiceConnectionEntity>;

@@override(RelayServiceConnectionEntityOperationGroup.createOrUpdateRelayServiceConnectionSlot,
  webAppsCreateOrUpdateRelayServiceConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateOrUpdateVnetConnectionGatewaySlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  vnetName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  gatewayName: string,

  @body
  connectionEnvelope: VnetGateway,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResourceUpdatedResponse<VnetGateway>;

@@override(VnetGatewayOperationGroup.createOrUpdateVnetConnectionGatewaySlot,
  webAppsCreateOrUpdateVnetConnectionGatewaySlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateOrUpdateVnetConnectionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  vnetName: string,

  @body
  connectionEnvelope: VnetInfoResource,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResourceUpdatedResponse<VnetInfoResource>;

@@override(VnetInfoResourceOperationGroup.createOrUpdateVnetConnectionSlot,
  webAppsCreateOrUpdateVnetConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteBackupSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  backupId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmDeletedResponse | ArmNotFoundResponse;

@@override(BackupItemOperationGroup.deleteBackupSlot,
  webAppsDeleteBackupSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteContinuousWebJobSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  webJobName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmDeletedResponse | ArmDeletedNoContentResponse;

@@override(ContinuousWebJobOperationGroup.deleteContinuousWebJobSlot,
  webAppsDeleteContinuousWebJobSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteDeploymentSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  id: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmDeletedResponse | ArmDeletedNoContentResponse;

@@override(DeploymentOperationGroup.deleteDeploymentSlot,
  webAppsDeleteDeploymentSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteDomainOwnershipIdentifierSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  domainOwnershipIdentifierName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmDeletedResponse | ArmDeletedNoContentResponse;

@@override(IdentifierOperationGroup.deleteDomainOwnershipIdentifierSlot,
  webAppsDeleteDomainOwnershipIdentifierSlotCustomized
);
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteFunctionSecretSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  functionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  keyName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): NoContentResponse | ArmNotFoundResponse;

@@override(FunctionEnvelopeOperationGroup.deleteFunctionSecretSlot,
  webAppsDeleteFunctionSecretSlotCustomized
);
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteHostSecretSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  keyType: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  keyName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  body: void,
): NoContentResponse | ArmNotFoundResponse;

@@override(WebApps.deleteHostSecretSlot, webAppsDeleteHostSecretSlotCustomized);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteHybridConnectionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  namespaceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  relayName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmDeletedResponse | ArmNotFoundResponse;

@@override(HybridConnectionSlotOperationGroup.deleteHybridConnectionSlot,
  webAppsDeleteHybridConnectionSlotCustomized
);
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteInstanceFunctionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  functionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmDeletedNoContentResponse | ArmNotFoundResponse;

@@override(FunctionEnvelopeOperationGroup.deleteInstanceFunctionSlot,
  webAppsDeleteInstanceFunctionSlotCustomized
);
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteInstanceProcessCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  instanceId: string,
): ArmDeletedNoContentResponse | ArmNotFoundResponse;

@@override(ProcessInfos.deleteInstanceProcess,
  webAppsDeleteInstanceProcessCustomized
);
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteInstanceProcessSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  instanceId: string,
): ArmDeletedNoContentResponse | ArmNotFoundResponse;

@@override(InstanceProcessSlotOperationGroup.deleteInstanceProcessSlot,
  webAppsDeleteInstanceProcessSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeletePremierAddOnSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  premierAddOnName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmDeletedResponse;

@@override(PremierAddOnOperationGroup.deletePremierAddOnSlot,
  webAppsDeletePremierAddOnSlotCustomized
);
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteProcessSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmDeletedNoContentResponse | ArmNotFoundResponse;

@@override(ProcessSlotOperationGroup.deleteProcessSlot,
  webAppsDeleteProcessSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteRelayServiceConnectionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  entityName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmDeletedResponse | ArmNotFoundResponse;

@@override(RelayServiceConnectionEntityOperationGroup.deleteRelayServiceConnectionSlot,
  webAppsDeleteRelayServiceConnectionSlotCustomized
);
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppDeleteSiteExtensionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  siteExtensionId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmDeletedNoContentResponse | ArmNotFoundResponse;

@@override(SiteExtensionInfoOperationGroup.deleteSiteExtensionSlot,
  webAppDeleteSiteExtensionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteTriggeredWebJobSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  webJobName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmDeletedResponse | ArmDeletedNoContentResponse;

@@override(TriggeredWebJobs.deleteTriggeredWebJobSlot,
  webAppsDeleteTriggeredWebJobSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteVnetConnectionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  vnetName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmDeletedResponse | ArmNotFoundResponse;

@@override(VnetInfoResourceOperationGroup.deleteVnetConnectionSlot,
  webAppsDeleteVnetConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetAppSettingKeyVaultReferenceSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  appSettingKey: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  configreferences: "configreferences",
): ArmResponse<ApiKVReference>;

@@override(AppSettingKeyVaultReferenceSlot.getAppSettingKeyVaultReferenceSlot,
  webAppsGetAppSettingKeyVaultReferenceSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetBackupStatusSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  backupId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<BackupItem>;

@@override(BackupItemOperationGroup.getBackupStatusSlot,
  webAppsGetBackupStatusSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetConfigurationSnapshotSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  snapshotId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  web: "web",
): ArmResponse<SiteConfigResource>;

@@override(SiteConfigSnapshotSlotResourceOperationGroup.getConfigurationSnapshotSlot,
  webAppsGetConfigurationSnapshotSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetContinuousWebJobSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  webJobName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<ContinuousWebJob> | ArmNotFoundResponse;

@@override(ContinuousWebJobOperationGroup.getContinuousWebJobSlot,
  webAppsGetContinuousWebJobSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetDeploymentSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  id: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<Deployment>;

@@override(DeploymentOperationGroup.getDeploymentSlot,
  webAppsGetDeploymentSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetDomainOwnershipIdentifierSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  domainOwnershipIdentifierName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<Identifier>;

@@override(IdentifierOperationGroup.getDomainOwnershipIdentifierSlot,
  webAppsGetDomainOwnershipIdentifierSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetHybridConnectionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  namespaceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  relayName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<HybridConnection>;

@@override(HybridConnectionSlotOperationGroup.getHybridConnectionSlot,
  webAppsGetHybridConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetInstanceFunctionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  functionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<FunctionEnvelope>;

@@override(FunctionEnvelopeOperationGroup.getInstanceFunctionSlot,
  webAppsGetInstanceFunctionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetInstanceInfoSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  instanceId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<WebSiteInstanceStatus>;

@@override(WebSiteInstanceStatusOperationGroup.getInstanceInfoSlot,
  webAppsGetInstanceInfoSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetInstanceProcessCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  instanceId: string,
): ArmResponse<ProcessInfo>;

@@override(ProcessInfos.getInstanceProcess,
  webAppsGetInstanceProcessCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetInstanceProcessDumpCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  instanceId: string,

  @body
  body: void,
): {
  @header("Content-Type")
  contentType: "*/*";

  @doc("Receipt body in COSE format")
  @bodyRoot
  body: bytes;
} | ArmNotFoundResponse;

@@override(ProcessInfos.getInstanceProcessDump,
  webAppsGetInstanceProcessDumpCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetInstanceProcessDumpSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  instanceId: string,

  @body
  body: void,
): {
  @header("Content-Type")
  contentType: "*/*";

  @doc("Receipt body in COSE format")
  @bodyRoot
  body: bytes;
} | ArmNotFoundResponse;

@@override(InstanceProcessSlotOperationGroup.getInstanceProcessDumpSlot,
  webAppsGetInstanceProcessDumpSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetInstanceProcessModuleCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  baseAddress: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  instanceId: string,
): ArmResponse<ProcessModuleInfo> | ArmNotFoundResponse;

@@override(ProcessModuleInfos.getInstanceProcessModule,
  webAppsGetInstanceProcessModuleCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetInstanceProcessModuleSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  baseAddress: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  instanceId: string,
): ArmResponse<ProcessModuleInfo> | ArmNotFoundResponse;

@@override(InstanceProcessModuleSlotOperationGroup.getInstanceProcessModuleSlot,
  webAppsGetInstanceProcessModuleSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetInstanceProcessSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  instanceId: string,
): ArmResponse<ProcessInfo> | ArmNotFoundResponse;

@@override(InstanceProcessSlotOperationGroup.getInstanceProcessSlot,
  webAppsGetInstanceProcessSlotCustomized
);
#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetNetworkTraceOperationSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  operationId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  body: void,
): ArmResponse<NetworkTrace[]> | (AcceptedResponse & {
  @identifiers(#[])
  @bodyRoot
  _: NetworkTrace[];
});

@@override(WebApps.getNetworkTraceOperationSlot,
  webAppsGetNetworkTraceOperationSlotCustomized
);
#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetNetworkTraceOperationSlotV2Customized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  operationId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  body: void,
): ArmResponse<NetworkTrace[]> | (AcceptedResponse & {
  @identifiers(#[])
  @bodyRoot
  _: NetworkTrace[];
});

@@override(WebApps.getNetworkTraceOperationSlotV2,
  webAppsGetNetworkTraceOperationSlotV2Customized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetNetworkTracesSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  operationId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  body: void,
): ArmResponse<NetworkTrace[]>;

@@override(WebApps.getNetworkTracesSlot, webAppsGetNetworkTracesSlotCustomized);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetNetworkTracesSlotV2Customized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  operationId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  body: void,
): ArmResponse<NetworkTrace[]>;

@@override(WebApps.getNetworkTracesSlotV2,
  webAppsGetNetworkTracesSlotV2Customized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetPremierAddOnSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  premierAddOnName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<PremierAddOn>;

@@override(PremierAddOnOperationGroup.getPremierAddOnSlot,
  webAppsGetPremierAddOnSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetPrivateEndpointConnectionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  privateEndpointConnectionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<RemotePrivateEndpointConnectionARMResource>;

@@override(PrivateEndpointConnectionSlotOperationGroup.getPrivateEndpointConnectionSlot,
  webAppsGetPrivateEndpointConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetProcessDumpSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  body: void,
): {
  @header("Content-Type")
  contentType: "*/*";

  @doc("Receipt body in COSE format")
  @bodyRoot
  body: bytes;
} | ArmNotFoundResponse;

@@override(ProcessSlotOperationGroup.getProcessDumpSlot,
  webAppsGetProcessDumpSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetProcessModuleSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  baseAddress: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<ProcessModuleInfo> | ArmNotFoundResponse;

@@override(ProcessModuleSlotOperationGroup.getProcessModuleSlot,
  webAppsGetProcessModuleSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetProcessSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<ProcessInfo> | ArmNotFoundResponse;

@@override(ProcessSlotOperationGroup.getProcessSlot,
  webAppsGetProcessSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetRelayServiceConnectionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  entityName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<RelayServiceConnectionEntity>;

@@override(RelayServiceConnectionEntityOperationGroup.getRelayServiceConnectionSlot,
  webAppsGetRelayServiceConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetSiteConnectionStringKeyVaultReferenceSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  connectionStringKey: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  configreferences: "configreferences",
): ArmResponse<ApiKVReference>;

@@override(SiteConnectionStringKeyVaultReferenceSlot.getSiteConnectionStringKeyVaultReferenceSlot,
  webAppsGetSiteConnectionStringKeyVaultReferenceSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetSiteExtensionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  siteExtensionId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<SiteExtensionInfo> | ArmNotFoundResponse;

@@override(SiteExtensionInfoOperationGroup.getSiteExtensionSlot,
  webAppsGetSiteExtensionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetTriggeredWebJobHistorySlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  webJobName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  id: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<TriggeredJobHistory> | ArmNotFoundResponse;

@@override(TriggeredJobHistories.getTriggeredWebJobHistorySlot,
  webAppsGetTriggeredWebJobHistorySlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetTriggeredWebJobSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  webJobName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<TriggeredWebJob> | ArmNotFoundResponse;

@@override(TriggeredWebJobs.getTriggeredWebJobSlot,
  webAppsGetTriggeredWebJobSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetVnetConnectionGatewaySlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  vnetName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  gatewayName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<VnetGateway> | ArmNotFoundResponse;

@@override(VnetGatewayOperationGroup.getVnetConnectionGatewaySlot,
  webAppsGetVnetConnectionGatewaySlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetVnetConnectionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  vnetName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<VnetInfoResource>;

@@override(VnetInfoResourceOperationGroup.getVnetConnectionSlot,
  webAppsGetVnetConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsGetWebJobSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  webJobName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<WebJob>;

@@override(WebJobs.getWebJobSlot, webAppsGetWebJobSlotCustomized);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsListBackupStatusSecretsSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  backupId: string,

  @body
  request: BackupRequest,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<BackupItem>;

@@override(BackupItemOperationGroup.listBackupStatusSecretsSlot,
  webAppsListBackupStatusSecretsSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsListDeploymentLogSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  id: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  body: void,
): ArmResponse<Deployment>;

@@override(DeploymentOperationGroup.listDeploymentLogSlot,
  webAppsListDeploymentLogSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsListFunctionKeysSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  functionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  body: void,
): ArmResponse<StringDictionary>;

@@override(FunctionEnvelopeOperationGroup.listFunctionKeysSlot,
  webAppsListFunctionKeysSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsListFunctionSecretsSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  functionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  body: void,
): ArmResponse<FunctionSecrets>;

@@override(FunctionEnvelopeOperationGroup.listFunctionSecretsSlot,
  webAppsListFunctionSecretsSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsListNetworkFeaturesSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  view: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<NetworkFeatures> | ArmNotFoundResponse;

@@override(NetworkFeaturesSlotOperationGroup.listNetworkFeaturesSlot,
  webAppsListNetworkFeaturesSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsListInstanceProcessModulesCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  instanceId: string,
): ArmResponse<ProcessModuleInfoCollection> | ArmNotFoundResponse;

@@override(ProcessModuleInfos.listInstanceProcessModules,
  webAppsListInstanceProcessModulesCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsListInstanceProcessModulesSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  instanceId: string,
): ArmResponse<ProcessModuleInfoCollection> | ArmNotFoundResponse;

@@override(InstanceProcessModuleSlotOperationGroup.listInstanceProcessModulesSlot,
  webAppsListInstanceProcessModulesSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsListInstanceProcessThreadsCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  instanceId: string,

  @body
  body: void,
): ArmResponse<ProcessThreadInfoCollection> | ArmNotFoundResponse;

@@override(ProcessInfos.listInstanceProcessThreads,
  webAppsListInstanceProcessThreadsCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsListInstanceProcessThreadsSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  instanceId: string,

  @body
  body: void,
): ArmResponse<ProcessThreadInfoCollection> | ArmNotFoundResponse;

@@override(InstanceProcessSlotOperationGroup.listInstanceProcessThreadsSlot,
  webAppsListInstanceProcessThreadsSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsListProcessModulesSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<ProcessModuleInfoCollection> | ArmNotFoundResponse;

@@override(ProcessModuleSlotOperationGroup.listProcessModulesSlot,
  webAppsListProcessModulesSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsListProcessThreadsSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  processId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  body: void,
): ArmResponse<ProcessThreadInfoCollection> | ArmNotFoundResponse;

@@override(ProcessSlotOperationGroup.listProcessThreadsSlot,
  webAppsListProcessThreadsSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsListTriggeredWebJobHistorySlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  webJobName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<TriggeredJobHistoryCollection> | ArmNotFoundResponse;

@@override(TriggeredJobHistories.listTriggeredWebJobHistorySlot,
  webAppsListTriggeredWebJobHistorySlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsRecoverSiteConfigurationSnapshotSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  snapshotId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  web: "web",

  @body
  body: void,
): NoContentResponse;

@@override(SiteConfigSnapshotSlotResourceOperationGroup.recoverSiteConfigurationSnapshotSlot,
  webAppsRecoverSiteConfigurationSnapshotSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsRunTriggeredWebJobSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  webJobName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  body: void,
): {
  @body body: void;
} | ArmNotFoundResponse;

@@override(TriggeredWebJobs.runTriggeredWebJobSlot,
  webAppsRunTriggeredWebJobSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsStartContinuousWebJobSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  webJobName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  body: void,
): {
  @body body: void;
} | ArmNotFoundResponse;

@@override(ContinuousWebJobOperationGroup.startContinuousWebJobSlot,
  webAppsStartContinuousWebJobSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsStopContinuousWebJobSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  webJobName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  body: void,
): {
  @body body: void;
} | ArmNotFoundResponse;

@@override(ContinuousWebJobOperationGroup.stopContinuousWebJobSlot,
  webAppsStopContinuousWebJobSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsUpdateDomainOwnershipIdentifierSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  domainOwnershipIdentifierName: string,

  @body
  domainOwnershipIdentifier: Identifier,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<Identifier>;

@@override(IdentifierOperationGroup.updateDomainOwnershipIdentifierSlot,
  webAppsUpdateDomainOwnershipIdentifierSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsUpdateHybridConnectionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  namespaceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  relayName: string,

  @body
  connectionEnvelopeconnectionEnvelope: HybridConnection,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<HybridConnection>;

@@override(HybridConnectionSlotOperationGroup.updateHybridConnectionSlot,
  webAppsUpdateHybridConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsUpdatePremierAddOnSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  premierAddOnName: string,

  @body
  premierAddOn: PremierAddOnPatchResource,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<PremierAddOn>;

@@override(PremierAddOnOperationGroup.updatePremierAddOnSlot,
  webAppsUpdatePremierAddOnSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsUpdateRelayServiceConnectionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  entityName: string,

  @body
  connectionEnvelope: RelayServiceConnectionEntity,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<RelayServiceConnectionEntity>;

@@override(RelayServiceConnectionEntityOperationGroup.updateRelayServiceConnectionSlot,
  webAppsUpdateRelayServiceConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsUpdateVnetConnectionGatewaySlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  vnetName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  gatewayName: string,

  @body
  connectionEnvelope: VnetGateway,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<VnetGateway>;

@@override(VnetGatewayOperationGroup.updateVnetConnectionGatewaySlot,
  webAppsUpdateVnetConnectionGatewaySlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsUpdateVnetConnectionSlotCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionId: Azure.ResourceManager.SubscriptionIdParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupName: Azure.ResourceManager.ResourceGroupParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider: Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  vnetName: string,

  @body
  connectionEnvelope: VnetInfoResource,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,
): ArmResponse<VnetInfoResource>;

@@override(VnetInfoResourceOperationGroup.updateVnetConnectionSlot,
  webAppsUpdateVnetConnectionSlotCustomized
);
