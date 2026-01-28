import "./main.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using Http;
using Azure.ClientGenerator.Core;
using Microsoft.Web;
using Azure.ResourceManager;

// python
@@clientName(Microsoft.Web, "WebSiteManagementClient", "python, javascript");
@@clientName(WebApps.swapSlotSlot, "swapSlot", "python,go");

@@clientName(SupportedTlsVersions.`1.0`, "ONE0", "python");
@@clientName(SupportedTlsVersions.`1.1`, "ONE1", "python");
@@clientName(SupportedTlsVersions.`1.2`, "ONE2", "python");
@@clientName(SupportedTlsVersions.`1.3`, "ONE3", "python");

@@clientName(SupportedTlsVersions.`1.0`, "One0", "go, javascript");
@@clientName(SupportedTlsVersions.`1.1`, "One1", "go, javascript");
@@clientName(SupportedTlsVersions.`1.2`, "One2", "go, javascript");
@@clientName(SupportedTlsVersions.`1.3`, "One3", "go, javascript");

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  premierAddOnName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  premierAddOn: PremierAddOn,
): ArmResourceUpdatedResponse<PremierAddOn>;

@@override(PremierAddOnOperationGroup.addPremierAddOnSlot,
  webAppsAddPremierAddOnSlotCustomized
);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsApproveOrRejectPrivateEndpointConnectionSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  privateEndpointConnectionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  privateEndpointWrapper: RemotePrivateEndpointConnectionARMResource,
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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query
  subscriptionName: string,

  ...ResourceGroupParameter,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  backupId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  request: RestoreRequest,
): {
  @body body: void;
};

@@override(BackupItemOperationGroup.restoreSlot, webAppsRestoreSlotCustomized);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateDeploymentSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  domainOwnershipIdentifierName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  domainOwnershipIdentifier: Identifier,
): ArmResourceUpdatedResponse<Identifier>;

@@override(IdentifierOperationGroup.createOrUpdateDomainOwnershipIdentifierSlot,
  webAppsCreateOrUpdateDomainOwnershipIdentifierSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateOrUpdateFunctionSecretSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  hostName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  hostNameBinding: HostNameBinding,
): ArmResourceUpdatedResponse<HostNameBinding>;

@@override(HostNameBindingOperationGroup.createOrUpdateHostNameBindingSlot,
  webAppsCreateOrUpdateHostNameBindingSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateOrUpdateHostSecretSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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

  @body
  connectionEnvelope: HybridConnection,
): ArmResourceUpdatedResponse<HybridConnection>;

@@override(HybridConnectionSlotOperationGroup.createOrUpdateHybridConnectionSlot,
  webAppsCreateOrUpdateHybridConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateOrUpdatePublicCertificateSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  publicCertificateName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  publicCertificate: PublicCertificate,
): ArmResourceUpdatedResponse<PublicCertificate>;

@@override(PublicCertificateOperationGroup.createOrUpdatePublicCertificateSlot,
  webAppsCreateOrUpdatePublicCertificateSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateOrUpdateRelayServiceConnectionSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  entityName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  connectionEnvelope: RelayServiceConnectionEntity,
): ArmResourceUpdatedResponse<RelayServiceConnectionEntity>;

@@override(RelayServiceConnectionEntityOperationGroup.createOrUpdateRelayServiceConnectionSlot,
  webAppsCreateOrUpdateRelayServiceConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateOrUpdateVnetConnectionGatewaySlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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

  @body
  connectionEnvelope: VnetGateway,
): ArmResourceUpdatedResponse<VnetGateway>;

@@override(VnetGatewayOperationGroup.createOrUpdateVnetConnectionGatewaySlot,
  webAppsCreateOrUpdateVnetConnectionGatewaySlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsCreateOrUpdateVnetConnectionSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  vnetName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  connectionEnvelope: VnetInfoResource,
): ArmResourceUpdatedResponse<VnetInfoResource>;

@@override(VnetInfoResourceOperationGroup.createOrUpdateVnetConnectionSlot,
  webAppsCreateOrUpdateVnetConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteBackupSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteContinuousWebJobSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteDeploymentSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteDomainOwnershipIdentifierSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,

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
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteHybridConnectionSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeletePremierAddOnSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteRelayServiceConnectionSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteTriggeredWebJobSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeleteVnetConnectionSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  backupId: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  request: BackupRequest,
): ArmResponse<BackupItem>;

@@override(BackupItemOperationGroup.listBackupStatusSecretsSlot,
  webAppsListBackupStatusSecretsSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsListDeploymentLogSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  domainOwnershipIdentifierName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  domainOwnershipIdentifier: Identifier,
): ArmResponse<Identifier>;

@@override(IdentifierOperationGroup.updateDomainOwnershipIdentifierSlot,
  webAppsUpdateDomainOwnershipIdentifierSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsUpdateHybridConnectionSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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

  @body
  connectionEnvelope: HybridConnection,
): ArmResponse<HybridConnection>;

@@override(HybridConnectionSlotOperationGroup.updateHybridConnectionSlot,
  webAppsUpdateHybridConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsUpdatePremierAddOnSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  premierAddOnName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  premierAddOn: PremierAddOnPatchResource,
): ArmResponse<PremierAddOn>;

@@override(PremierAddOnOperationGroup.updatePremierAddOnSlot,
  webAppsUpdatePremierAddOnSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsUpdateRelayServiceConnectionSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  entityName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  connectionEnvelope: RelayServiceConnectionEntity,
): ArmResponse<RelayServiceConnectionEntity>;

@@override(RelayServiceConnectionEntityOperationGroup.updateRelayServiceConnectionSlot,
  webAppsUpdateRelayServiceConnectionSlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsUpdateVnetConnectionGatewaySlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

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

  @body
  connectionEnvelope: VnetGateway,
): ArmResponse<VnetGateway>;

@@override(VnetGatewayOperationGroup.updateVnetConnectionGatewaySlot,
  webAppsUpdateVnetConnectionGatewaySlotCustomized
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsUpdateVnetConnectionSlotCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  vnetName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @body
  connectionEnvelope: VnetInfoResource,
): ArmResponse<VnetInfoResource>;

@@override(VnetInfoResourceOperationGroup.updateVnetConnectionSlot,
  webAppsUpdateVnetConnectionSlotCustomized
);

@@clientName(Certificate, "AppCertificate", "go");
@@clientName(CertificateCollection, "AppCertificateCollection", "go");
@@clientName(CertificatePatchResource, "AppCertificatePatchResource", "go");
@@clientName(CertificateProperties, "AppCertificateProperties", "go");
@@clientName(CertificatePatchResourceProperties,
  "AppCertificatePatchResourceProperties",
  "go"
);
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op checkNameAvailabilityCustomized(
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  @doc("Resource name to verify.")
  name: string,

  @doc("Resource type used for verification.")
  type: CheckNameResourceTypes,

  @doc("Is fully qualified domain name.")
  isFqdn?: boolean,

  @doc("Azure Resource Manager ID of the customer's selected Container Apps Environment on which to host the Function app. This must be of the form /subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.App/managedEnvironments/{managedEnvironmentName}.")
  environmentId?: string,
): ResourceNameAvailability;

@@override(checkNameAvailability,
  checkNameAvailabilityCustomized,
  "javascript"
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op regionalCheckNameAvailabilityCustomized(
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  @doc("Resource name to verify.")
  name: string,

  @doc("The location/region where the resource name availability is checked.")
  location: string,

  @doc("Resource type used for verification.")
  type: CheckNameResourceTypes,

  @doc("Resource group name.")
  resourceGroupName?: string,

  @doc("Indicates the endpoint name reuse scope.The default value is TenantReuse.")
  autoGeneratedDomainNameLabelScope?: string,
): DnlResourceNameAvailability;

@@override(regionalCheckNameAvailability,
  regionalCheckNameAvailabilityCustomized,
  "javascript"
);
