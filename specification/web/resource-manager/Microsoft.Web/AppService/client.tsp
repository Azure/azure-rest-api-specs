import "./main.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using Http;
using Azure.ClientGenerator.Core;
using Microsoft.Web;
using Azure.ResourceManager;
using Azure.Core;

namespace Customizations;

// python
@@clientName(Microsoft.Web, "WebSiteManagementClient", "python, javascript");
@@clientName(WebApps.swapSlotSlot, "swapSlot", "python,go,javascript");

@@clientName(SupportedTlsVersions.`1.0`, "ONE0", "python");
@@clientName(SupportedTlsVersions.`1.1`, "ONE1", "python");
@@clientName(SupportedTlsVersions.`1.2`, "ONE2", "python");
@@clientName(SupportedTlsVersions.`1.3`, "ONE3", "python");

@@clientName(SupportedTlsVersions.`1.0`, "One0", "go, javascript");
@@clientName(SupportedTlsVersions.`1.1`, "One1", "go, javascript");
@@clientName(SupportedTlsVersions.`1.2`, "One2", "go, javascript");
@@clientName(SupportedTlsVersions.`1.3`, "One3", "go, javascript");

@@clientName(
  TlsCipherSuites.TLS_AES_256_GCM_SHA384,
  "TLS_AES256_GCM_SHA384",
  "python"
);
@@clientName(
  TlsCipherSuites.TLS_AES_128_GCM_SHA256,
  "TLS_AES128_GCM_SHA256",
  "python"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,
  "TLS_ECDHE_ECDSA_WITH_AES256_GCM_SHA384",
  "python"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,
  "TLS_ECDHE_ECDSA_WITH_AES128_CBC_SHA256",
  "python"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,
  "TLS_ECDHE_ECDSA_WITH_AES128_GCM_SHA256",
  "python"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,
  "TLS_ECDHE_RSA_WITH_AES256_GCM_SHA384",
  "python"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,
  "TLS_ECDHE_RSA_WITH_AES128_GCM_SHA256",
  "python"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384,
  "TLS_ECDHE_RSA_WITH_AES256_CBC_SHA384",
  "python"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,
  "TLS_ECDHE_RSA_WITH_AES128_CBC_SHA256",
  "python"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,
  "TLS_ECDHE_RSA_WITH_AES256_CBC_SHA",
  "python"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,
  "TLS_ECDHE_RSA_WITH_AES128_CBC_SHA",
  "python"
);
@@clientName(
  TlsCipherSuites.TLS_RSA_WITH_AES_256_GCM_SHA384,
  "TLS_RSA_WITH_AES256_GCM_SHA384",
  "python"
);
@@clientName(
  TlsCipherSuites.TLS_RSA_WITH_AES_128_GCM_SHA256,
  "TLS_RSA_WITH_AES128_GCM_SHA256",
  "python"
);
@@clientName(
  TlsCipherSuites.TLS_RSA_WITH_AES_256_CBC_SHA256,
  "TLS_RSA_WITH_AES256_CBC_SHA256",
  "python"
);
@@clientName(
  TlsCipherSuites.TLS_RSA_WITH_AES_128_CBC_SHA256,
  "TLS_RSA_WITH_AES128_CBC_SHA256",
  "python"
);
@@clientName(
  TlsCipherSuites.TLS_RSA_WITH_AES_256_CBC_SHA,
  "TLS_RSA_WITH_AES256_CBC_SHA",
  "python"
);
@@clientName(
  TlsCipherSuites.TLS_RSA_WITH_AES_128_CBC_SHA,
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

@@override(
  AnalysisDefinitionOperationGroup.executeSiteAnalysisSlot,
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

@@override(
  DetectorDefinitionResources.executeSiteDetector,
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

@@override(
  DetectorDefinitionResourceOperationGroup.executeSiteDetectorSlot,
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

@@override(
  AnalysisDefinitionOperationGroup.getSiteAnalysisSlot,
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

@@override(
  DetectorResponseOperationGroup.getSiteDetectorResponseSlot,
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

@@override(
  DetectorDefinitionResourceOperationGroup.getSiteDetectorSlot,
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

@@override(
  DiagnosticCategoryOperationGroup.getSiteDiagnosticCategorySlot,
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

@@override(
  AnalysisDefinitionOperationGroup.listSiteAnalysesSlot,
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

@@override(
  DetectorDefinitionResourceOperationGroup.listSiteDetectorsSlot,
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

@@override(
  RecommendationRules.disableRecommendationForHostingEnvironment,
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

@@override(
  PremierAddOnOperationGroup.addPremierAddOnSlot,
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
):
  | ArmResourceUpdatedResponse<RemotePrivateEndpointConnectionARMResource>
  | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = RemotePrivateEndpointConnectionARMResource>> & {
      @bodyRoot
      _: RemotePrivateEndpointConnectionARMResource;
    });

@@override(
  PrivateEndpointConnectionSlotOperationGroup.approveOrRejectPrivateEndpointConnectionSlot,
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

@@override(
  FunctionEnvelopeOperationGroup.createInstanceFunctionSlot,
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
):
  | ArmResponse<unknown>
  | (ArmDeleteAcceptedLroResponse & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    })
  | (ArmDeletedNoContentResponse & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    });

@@override(
  PrivateEndpointConnectionSlotOperationGroup.deletePrivateEndpointConnectionSlot,
  webAppsDeletePrivateEndpointConnectionSlotCustomized,
  "!javascript,!autorest"
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
):
  | ArmResponse<SiteExtensionInfo>
  | ArmResourceCreatedResponse<
      SiteExtensionInfo,
      LroHeaders = ArmLroLocationHeader<FinalResult = SiteExtensionInfo> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  | ArmTooManyRequestsResponse;

@@override(
  SiteExtensionInfoOperationGroup.installSiteExtensionSlot,
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

@@override(
  DeploymentOperationGroup.createDeploymentSlot,
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

@@override(
  IdentifierOperationGroup.createOrUpdateDomainOwnershipIdentifierSlot,
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

@@override(
  FunctionEnvelopeOperationGroup.createOrUpdateFunctionSecretSlot,
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

@@override(
  HostNameBindingOperationGroup.createOrUpdateHostNameBindingSlot,
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
):
  | ArmResponse<KeyInfo>
  | ArmResourceCreatedSyncResponse<KeyInfo>
  | DefaultErrorResponse;

@@override(
  WebApps.createOrUpdateHostSecretSlot,
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

@@override(
  HybridConnectionSlotOperationGroup.createOrUpdateHybridConnectionSlot,
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

@@override(
  PublicCertificateOperationGroup.createOrUpdatePublicCertificateSlot,
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

@@override(
  RelayServiceConnectionEntityOperationGroup.createOrUpdateRelayServiceConnectionSlot,
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

@@override(
  VnetGatewayOperationGroup.createOrUpdateVnetConnectionGatewaySlot,
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

@@override(
  VnetInfoResourceOperationGroup.createOrUpdateVnetConnectionSlot,
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

@@override(
  BackupItemOperationGroup.deleteBackupSlot,
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

@@override(
  ContinuousWebJobOperationGroup.deleteContinuousWebJobSlot,
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

@@override(
  DeploymentOperationGroup.deleteDeploymentSlot,
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

@@override(
  IdentifierOperationGroup.deleteDomainOwnershipIdentifierSlot,
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

@@override(
  FunctionEnvelopeOperationGroup.deleteFunctionSecretSlot,
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

@@override(
  HybridConnectionSlotOperationGroup.deleteHybridConnectionSlot,
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

@@override(
  FunctionEnvelopeOperationGroup.deleteInstanceFunctionSlot,
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

@@override(
  ProcessInfos.deleteInstanceProcess,
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

@@override(
  InstanceProcessSlotOperationGroup.deleteInstanceProcessSlot,
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

@@override(
  PremierAddOnOperationGroup.deletePremierAddOnSlot,
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

@@override(
  ProcessSlotOperationGroup.deleteProcessSlot,
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

@@override(
  RelayServiceConnectionEntityOperationGroup.deleteRelayServiceConnectionSlot,
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

@@override(
  SiteExtensionInfoOperationGroup.deleteSiteExtensionSlot,
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

@@override(
  TriggeredWebJobs.deleteTriggeredWebJobSlot,
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

@@override(
  VnetInfoResourceOperationGroup.deleteVnetConnectionSlot,
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  configreferences: "configreferences",
): ArmResponse<ApiKVReference>;

@@override(
  AppSettingKeyVaultReferenceSlot.getAppSettingKeyVaultReferenceSlot,
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

@@override(
  BackupItemOperationGroup.getBackupStatusSlot,
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  web: "web",
): ArmResponse<SiteConfigResource>;

@@override(
  SiteConfigSnapshotSlotResourceOperationGroup.getConfigurationSnapshotSlot,
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

@@override(
  ContinuousWebJobOperationGroup.getContinuousWebJobSlot,
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

@@override(
  DeploymentOperationGroup.getDeploymentSlot,
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

@@override(
  IdentifierOperationGroup.getDomainOwnershipIdentifierSlot,
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

@@override(
  HybridConnectionSlotOperationGroup.getHybridConnectionSlot,
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

@@override(
  FunctionEnvelopeOperationGroup.getInstanceFunctionSlot,
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

@@override(
  WebSiteInstanceStatusOperationGroup.getInstanceInfoSlot,
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

@@override(
  ProcessInfos.getInstanceProcess,
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
):
  | {
      @header("Content-Type")
      contentType: "*/*";

      @doc("Receipt body in COSE format")
      @bodyRoot
      body: bytes;
    }
  | ArmNotFoundResponse;

@@override(
  ProcessInfos.getInstanceProcessDump,
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
):
  | {
      @header("Content-Type")
      contentType: "*/*";

      @doc("Receipt body in COSE format")
      @bodyRoot
      body: bytes;
    }
  | ArmNotFoundResponse;

@@override(
  InstanceProcessSlotOperationGroup.getInstanceProcessDumpSlot,
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

@@override(
  ProcessModuleInfos.getInstanceProcessModule,
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

@@override(
  InstanceProcessModuleSlotOperationGroup.getInstanceProcessModuleSlot,
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

@@override(
  InstanceProcessSlotOperationGroup.getInstanceProcessSlot,
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
):
  | ArmResponse<NetworkTrace[]>
  | (AcceptedResponse & {
      @identifiers(#[])
      @bodyRoot
      _: NetworkTrace[];
    });

@@override(
  WebApps.getNetworkTraceOperationSlot,
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
):
  | ArmResponse<NetworkTrace[]>
  | (AcceptedResponse & {
      @identifiers(#[])
      @bodyRoot
      _: NetworkTrace[];
    });

@@override(
  WebApps.getNetworkTraceOperationSlotV2,
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

@@override(
  WebApps.getNetworkTracesSlotV2,
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

@@override(
  PremierAddOnOperationGroup.getPremierAddOnSlot,
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

@@override(
  PrivateEndpointConnectionSlotOperationGroup.getPrivateEndpointConnectionSlot,
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
):
  | {
      @header("Content-Type")
      contentType: "*/*";

      @doc("Receipt body in COSE format")
      @bodyRoot
      body: bytes;
    }
  | ArmNotFoundResponse;

@@override(
  ProcessSlotOperationGroup.getProcessDumpSlot,
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

@@override(
  ProcessModuleSlotOperationGroup.getProcessModuleSlot,
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

@@override(
  ProcessSlotOperationGroup.getProcessSlot,
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

@@override(
  RelayServiceConnectionEntityOperationGroup.getRelayServiceConnectionSlot,
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  configreferences: "configreferences",
): ArmResponse<ApiKVReference>;

@@override(
  SiteConnectionStringKeyVaultReferenceSlot.getSiteConnectionStringKeyVaultReferenceSlot,
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

@@override(
  SiteExtensionInfoOperationGroup.getSiteExtensionSlot,
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

@@override(
  TriggeredJobHistories.getTriggeredWebJobHistorySlot,
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

@@override(
  TriggeredWebJobs.getTriggeredWebJobSlot,
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

@@override(
  VnetGatewayOperationGroup.getVnetConnectionGatewaySlot,
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

@@override(
  VnetInfoResourceOperationGroup.getVnetConnectionSlot,
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

@@override(
  BackupItemOperationGroup.listBackupStatusSecretsSlot,
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

@@override(
  DeploymentOperationGroup.listDeploymentLogSlot,
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

@@override(
  FunctionEnvelopeOperationGroup.listFunctionKeysSlot,
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

@@override(
  FunctionEnvelopeOperationGroup.listFunctionSecretsSlot,
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

@@override(
  NetworkFeaturesSlotOperationGroup.listNetworkFeaturesSlot,
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

@@override(
  ProcessModuleInfos.listInstanceProcessModules,
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

@@override(
  InstanceProcessModuleSlotOperationGroup.listInstanceProcessModulesSlot,
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

@@override(
  ProcessInfos.listInstanceProcessThreads,
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

@@override(
  InstanceProcessSlotOperationGroup.listInstanceProcessThreadsSlot,
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

@@override(
  ProcessModuleSlotOperationGroup.listProcessModulesSlot,
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

@@override(
  ProcessSlotOperationGroup.listProcessThreadsSlot,
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

@@override(
  TriggeredJobHistories.listTriggeredWebJobHistorySlot,
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  web: "web",

  @body
  body: void,
): NoContentResponse;

@@override(
  SiteConfigSnapshotSlotResourceOperationGroup.recoverSiteConfigurationSnapshotSlot,
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
):
  | {
      @body body: void;
    }
  | ArmNotFoundResponse;

@@override(
  TriggeredWebJobs.runTriggeredWebJobSlot,
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
):
  | {
      @body body: void;
    }
  | ArmNotFoundResponse;

@@override(
  ContinuousWebJobOperationGroup.startContinuousWebJobSlot,
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
):
  | {
      @body body: void;
    }
  | ArmNotFoundResponse;

@@override(
  ContinuousWebJobOperationGroup.stopContinuousWebJobSlot,
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

@@override(
  IdentifierOperationGroup.updateDomainOwnershipIdentifierSlot,
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

@@override(
  HybridConnectionSlotOperationGroup.updateHybridConnectionSlot,
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

@@override(
  PremierAddOnOperationGroup.updatePremierAddOnSlot,
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

@@override(
  RelayServiceConnectionEntityOperationGroup.updateRelayServiceConnectionSlot,
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

@@override(
  VnetGatewayOperationGroup.updateVnetConnectionGatewaySlot,
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

@@override(
  VnetInfoResourceOperationGroup.updateVnetConnectionSlot,
  webAppsUpdateVnetConnectionSlotCustomized
);

@@clientName(Certificate, "AppCertificate", "go");
@@clientName(CertificateCollection, "AppCertificateCollection", "go");
@@clientName(CertificatePatchResource, "AppCertificatePatchResource", "go");
@@clientName(CertificateProperties, "AppCertificateProperties", "go");
@@clientName(
  CertificatePatchResourceProperties,
  "AppCertificatePatchResourceProperties",
  "go"
);

@@clientName(Microsoft.Web, "WebSiteManagementClient", "java");
@@clientName(listBillingMeters, "list", "java");
@@clientName(
  listSiteIdentifiersAssignedToHostName,
  "listSiteIdentifiersAssignedToHostname",
  "java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Swagger bug. Function App on ACA is LRO."
@@Azure.ClientGenerator.Core.Legacy.markAsLro(
  Sites.updateApplicationSettings,
  "java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Swagger bug. Function App on ACA is LRO."
@@Azure.ClientGenerator.Core.Legacy.markAsLro(
  SiteConfigResources.createOrUpdateConfiguration,
  "java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Swagger bug. Function App on ACA is LRO."
@@Azure.ClientGenerator.Core.Legacy.markAsLro(Sites.update, "java");

@@clientName(
  Microsoft.Web.ErrorResponse,
  "WorkflowErrorResponse",
  "!go,!javascript,!autorest"
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op checkNameAvailabilityCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /**
   * Resource name to verify.
   */
  name: string,

  /**
   * Resource type used for verification.
   */
  type: CheckNameResourceTypes,

  /**
   * Is fully qualified domain name.
   */
  isFqdn?: boolean,

  /**
   * Azure Resource Manager ID of the customer's selected Container Apps Environment on which to host the Function app. This must be of the form /subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.App/managedEnvironments/{managedEnvironmentName}
   */
  environmentId?: string,
): ResourceNameAvailability;

@@override(
  checkNameAvailability,
  checkNameAvailabilityCustomized,
  "javascript"
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op regionalCheckNameAvailabilityCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  ...LocationParameter,

  /**
   * Resource name to verify.
   */
  name: string,

  /**
   * Resource type used for verification.
   */
  type: CheckNameResourceTypes,

  /**
   * Resource group name
   */
  resourceGroupName?: string,

  /**
   * Indicates the endpoint name reuse scope.The default value is TenantReuse.
   * Supported values are TenantReuse, SubscriptionReuse, ResourceGroupReuse, NoReuse
   */
  autoGeneratedDomainNameLabelScope?: string,
): DnlResourceNameAvailability;

@@override(
  regionalCheckNameAvailability,
  regionalCheckNameAvailabilityCustomized,
  "javascript"
);

@@clientName(
  AppServiceEnvironmentResources.changeVnet,
  "listChangeVnet",
  "javascript"
);
@@clientName(AppServiceEnvironmentResources.resume, "listResume", "javascript");
@@clientName(
  AppServiceEnvironmentResources.suspend,
  "listSuspend",
  "javascript"
);
@@clientName(
  AppServiceEnvironmentResources.getInboundNetworkDependenciesEndpoints,
  "listInboundNetworkDependenciesEndpoints",
  "javascript"
);
@@clientName(
  AppServiceEnvironmentResources.getOutboundNetworkDependenciesEndpoints,
  "listOutboundNetworkDependenciesEndpoints",
  "javascript"
);
@@clientName(
  RemotePrivateEndpointConnectionARMResources.getPrivateEndpointConnectionList,
  "listPrivateEndpointConnectionList",
  "javascript"
);

@@clientName(
  ProviderOperationGroup.getAvailableStacks,
  "listAvailableStacks",
  "javascript"
);
@@clientName(
  ProviderOperationGroup.getAvailableStacksOnPrem,
  "listAvailableStacksOnPrem",
  "javascript"
);
@@clientName(
  ProviderOperationGroup.getFunctionAppStacks,
  "listFunctionAppStacks",
  "javascript"
);
@@clientName(
  ProviderOperationGroup.getFunctionAppStacksForLocation,
  "listFunctionAppStacksForLocation",
  "javascript"
);
@@clientName(
  ProviderOperationGroup.getWebAppStacks,
  "listWebAppStacks",
  "javascript"
);
@@clientName(
  ProviderOperationGroup.getWebAppStacksForLocation,
  "listWebAppStacksForLocation",
  "javascript"
);

@@clientName(
  DatabaseConnections.getBuildDatabaseConnections,
  "listBuildDatabaseConnections",
  "javascript"
);
@@clientName(
  StaticSiteBuildARMResources.getBuildDatabaseConnectionsWithDetails,
  "listBuildDatabaseConnectionsWithDetails",
  "javascript"
);
@@clientName(
  DatabaseConnectionOperationGroup.getDatabaseConnections,
  "listDatabaseConnections",
  "javascript"
);
@@clientName(
  StaticSiteARMResources.getDatabaseConnectionsWithDetails,
  "listDatabaseConnectionsWithDetails",
  "javascript"
);
@@clientName(
  StaticSiteLinkedBackendARMResources.getLinkedBackends,
  "listLinkedBackends",
  "javascript"
);
@@clientName(
  StaticSiteLinkedBackendARMResourceOperationGroup.getLinkedBackendsForBuild,
  "listLinkedBackendsForBuild",
  "javascript"
);
@@clientName(
  StaticSites.getPrivateEndpointConnectionList,
  "listPrivateEndpointConnectionList",
  "javascript"
);
@@clientName(
  StaticSiteBuildARMResources.getStaticSiteBuilds,
  "listStaticSiteBuilds",
  "javascript"
);
@@clientName(
  StaticSiteARMResources.getStaticSitesByResourceGroup,
  "listStaticSitesByResourceGroup",
  "javascript"
);
@@clientName(
  StaticSiteUserProvidedFunctionAppARMResources.getUserProvidedFunctionAppsForStaticSiteBuild,
  "listUserProvidedFunctionAppsForStaticSiteBuild",
  "javascript"
);
@@clientName(
  StaticSiteUserProvidedFunctionAppARMResourceOperationGroup.getUserProvidedFunctionAppsForStaticSite,
  "listUserProvidedFunctionAppsForStaticSite",
  "javascript"
);
@@clientName(
  AppSettingKeyVaultReference.getAppSettingsKeyVaultReferences,
  "listAppSettingsKeyVaultReferences",
  "javascript"
);
@@clientName(
  AppSettingKeyVaultReferenceSlot.getAppSettingsKeyVaultReferencesSlot,
  "listAppSettingsKeyVaultReferencesSlot",
  "javascript"
);
@@clientName(
  RemotePrivateEndpointConnectionARMResourceOperationGroup.getPrivateEndpointConnectionList,
  "listPrivateEndpointConnectionList",
  "javascript"
);
@@clientName(
  PrivateEndpointConnectionSlotOperationGroup.getPrivateEndpointConnectionListSlot,
  "listPrivateEndpointConnectionListSlot",
  "javascript"
);
@@clientName(
  SiteConnectionStringKeyVaultReference.getSiteConnectionStringKeyVaultReferences,
  "listSiteConnectionStringKeyVaultReferences",
  "javascript"
);
@@clientName(
  SiteConnectionStringKeyVaultReferenceSlot.getSiteConnectionStringKeyVaultReferencesSlot,
  "listSiteConnectionStringKeyVaultReferencesSlot",
  "javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeletePrivateEndpointConnectionSlotCustomizedForJs(
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
):
  | ArmResponse<unknown>
  | (ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = unknown>> & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    })
  | (ArmDeletedNoContentResponse & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    });

@@override(
  PrivateEndpointConnectionSlotOperationGroup.deletePrivateEndpointConnectionSlot,
  webAppsDeletePrivateEndpointConnectionSlotCustomizedForJs,
  "javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op appServiceEnvironmentsDeletePrivateEndpointConnectionForJs(
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
):
  | ArmResponse<unknown>
  | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = unknown> & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    }>
  | (ArmDeletedNoContentResponse & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    });

@@override(
  RemotePrivateEndpointConnectionARMResources.deletePrivateEndpointConnection,
  appServiceEnvironmentsDeletePrivateEndpointConnectionForJs,
  "javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op staticSitesDeletePrivateEndpointConnectionForJs(
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
):
  | ArmResponse<unknown>
  | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = unknown> & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    }>
  | (ArmDeletedNoContentResponse & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    });

@@override(
  StaticSites.deletePrivateEndpointConnection,
  staticSitesDeletePrivateEndpointConnectionForJs,
  "javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsDeletePrivateEndpointConnectionForJs(
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
):
  | ArmResponse<unknown>
  | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = unknown> & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    }>
  | (ArmDeletedNoContentResponse & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    });

@@override(
  RemotePrivateEndpointConnectionARMResourceOperationGroup.deletePrivateEndpointConnection,
  webAppsDeletePrivateEndpointConnectionForJs,
  "javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsStartNetworkTraceForJs(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  @query("durationInSeconds")
  durationInSeconds?: int32,

  @query("maxFrameLength")
  maxFrameLength?: int32,

  @query("sasUrl")
  sasUrl?: string,

  @body body: void,
):
  | ArmResponse<NetworkTrace[]>
  | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = NetworkTrace[]>> & {
      @bodyRoot
      @identifiers(#[])
      _?: NetworkTrace[];
    });

@@override(
  Sites.startNetworkTrace,
  webAppsStartNetworkTraceForJs,
  "javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsStartNetworkTraceSlotForJs(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @query("durationInSeconds")
  durationInSeconds?: int32,

  @query("maxFrameLength")
  maxFrameLength?: int32,

  @query("sasUrl")
  sasUrl?: string,

  @body body: void,
):
  | ArmResponse<NetworkTrace[]>
  | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = NetworkTrace[]>> & {
      @bodyRoot
      @identifiers(#[])
      _?: NetworkTrace[];
    });

@@override(
  WebApps.startNetworkTraceSlot,
  webAppsStartNetworkTraceSlotForJs,
  "javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsStartWebSiteNetworkTraceOperationForJs(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  @query("durationInSeconds")
  durationInSeconds?: int32,

  @query("maxFrameLength")
  maxFrameLength?: int32,

  @query("sasUrl")
  sasUrl?: string,

  @body body: void,
):
  | ArmResponse<NetworkTrace[]>
  | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = NetworkTrace[]>> & {
      @bodyRoot
      @identifiers(#[])
      _?: NetworkTrace[];
    });

@@override(
  Sites.startWebSiteNetworkTraceOperation,
  webAppsStartWebSiteNetworkTraceOperationForJs,
  "javascript"
);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op webAppsStartWebSiteNetworkTraceOperationSlotForJs(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @path
  slot: string,

  @query("durationInSeconds")
  durationInSeconds?: int32,

  @query("maxFrameLength")
  maxFrameLength?: int32,

  @query("sasUrl")
  sasUrl?: string,

  @body body: void,
):
  | ArmResponse<NetworkTrace[]>
  | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = NetworkTrace[]>> & {
      @bodyRoot
      @identifiers(#[])
      _?: NetworkTrace[];
    });

@@override(
  WebApps.startWebSiteNetworkTraceOperationSlot,
  webAppsStartWebSiteNetworkTraceOperationSlotForJs,
  "javascript"
);

// --- Model renames ---
@@clientName(AddressResponse, "AppServiceEnvironmentAddress", "csharp");
@@clientName(AllowedPrincipals, "AppServiceAadAllowedPrincipals", "csharp");
@@clientName(AnalysisData, "AnalysisDetectorEvidences", "csharp");
@@clientName(AnalysisDefinition, "WebSiteAnalysisDefinition", "csharp");
@@clientName(ApiKVReference, "ApiKeyVaultReference", "csharp");
@@clientName(
  ApiKVReferenceCollection,
  "AppServiceApiKeyVaultReferenceList",
  "csharp"
);
@@clientName(Apple, "AppServiceAppleProvider", "csharp");
@@clientName(AppleRegistration, "AppServiceAppleRegistration", "csharp");
@@clientName(
  ApplicationStackCollection,
  "ApplicationStackListResult",
  "csharp"
);
@@clientName(
  AppServiceEnvironment,
  "AppServiceEnvironmentProperties",
  "csharp"
);
@@clientName(
  AppServiceEnvironmentCollection,
  "AppServiceEnvironmentListResult",
  "csharp"
);
@@clientName(
  AppServiceEnvironmentPatchResource,
  "AppServiceEnvironmentPatchContent",
  "csharp"
);
@@clientName(AppServiceEnvironmentResource, "AppServiceEnvironment", "csharp");
@@clientName(AppServicePlanCollection, "AppServicePlanListResult", "csharp");
@@clientName(AppServicePlanRestrictions, "AppServicePlanRestriction", "csharp");
@@access(ResourceMetricAvailability, Access.public, "csharp");
@@clientName(
  AppServicePlanPatchResource,
  "AppServicePlanPatchContent",
  "csharp"
);
@@clientName(AseRegion, "AppServiceAseRegion", "csharp");
@@clientName(
  AuthenticationType,
  "FunctionAppStorageAccountAuthenticationType",
  "csharp"
);
@@clientName(Microsoft.Web.AuthType, "SiteContainerAuthType", "csharp");
@@clientName(AzureActiveDirectory, "AppServiceAadProvider", "csharp");
@@clientName(AzureActiveDirectoryLogin, "AppServiceAadLoginFlow", "csharp");
@@clientName(
  AzureActiveDirectoryRegistration,
  "AppServiceAadRegistration",
  "csharp"
);
@@clientName(
  AzureActiveDirectoryValidation,
  "AppServiceAadValidation",
  "csharp"
);
@@clientName(
  AzureBlobStorageApplicationLogsConfig,
  "AppServiceBlobStorageApplicationLogsConfig",
  "csharp"
);
@@clientName(
  AzureBlobStorageHttpLogsConfig,
  "AppServiceBlobStorageHttpLogsConfig",
  "csharp"
);
@@clientName(
  AzureResourceErrorInfo,
  "WorkflowExpressionResourceErrorInfo",
  "csharp"
);
@@clientName(AzureResourceType, "AppServiceResourceType", "csharp");
@@clientName(AzureStaticWebApps, "AppServiceStaticWebAppsProvider", "csharp");
@@clientName(
  AzureStaticWebAppsRegistration,
  "AppServiceStaticWebAppsRegistration",
  "csharp"
);
@@clientName(AzureStorageInfoValue, "AppServiceStorageAccessInfo", "csharp");
@@clientName(
  AzureStoragePropertyDictionaryResource,
  "AzureStoragePropertyDictionary",
  "csharp"
);
@@clientName(AzureStorageProtocol, "AppServiceStorageProtocol", "csharp");
@@clientName(AzureStorageState, "AppServiceStorageAccountState", "csharp");
@@clientName(AzureStorageType, "AppServiceStorageType", "csharp");
@@clientName(
  AzureTableStorageApplicationLogsConfig,
  "AppServiceTableStorageApplicationLogsConfig",
  "csharp"
);
@@clientName(BackupItem, "WebAppBackup", "csharp");
@@clientName(BackupItemCollection, "WebAppBackupItemListResult", "csharp");
@@clientName(BackupItemStatus, "WebAppBackupStatus", "csharp");
@@clientName(BackupRequest, "WebAppBackupInfo", "csharp");
@@clientName(BackupSchedule, "WebAppBackupSchedule", "csharp");
@@clientName(BasicAuthName, "StaticSiteBasicAuthName", "csharp");
@@clientName(
  BillingMeterCollection,
  "AppServiceBillingMeterListResult",
  "csharp"
);
@@clientName(BuildStatus, "StaticSiteBuildStatus", "csharp");
@@clientName(Capability, "AppServiceSkuCapability", "csharp");
@@clientName(Certificate, "AppCertificate", "csharp");
@@clientName(CertificateCollection, "AppCertificateListResult", "csharp");
@@clientName(CertificatePatchResource, "AppCertificatePatch", "csharp");
@@clientName(Channels, "RecommendationChannel", "csharp");
@@clientName(ContainerThrottlingData, "ContainerThrottlingInfo", "csharp");
@@clientName(ContentHash, "WebAppContentHash", "csharp");
@@clientName(ContentLink, "WebAppContentLink", "csharp");
@@clientName(
  ContinuousWebJobCollection,
  "ContinuousWebJobListResult",
  "csharp"
);
@@clientName(CookieExpiration, "WebAppCookieExpiration", "csharp");
@@clientName(CsmOperationCollection, "CsmOperationListResult", "csharp");
@@clientName(CsmPublishingProfileOptions, "CsmPublishingProfile", "csharp");
@@clientName(CsmUsageQuotaCollection, "CsmUsageQuotaListResult", "csharp");
@@clientName(DaprConfig, "AppDaprConfig", "csharp");
@@clientName(DaprLogLevel, "AppDaprLogLevel", "csharp");
@@clientName(DatabaseConnection, "StaticSiteDatabaseConnection", "csharp");
@@clientName(
  DatabaseConnectionOverview,
  "StaticSiteDatabaseConnectionOverview",
  "csharp"
);
@@clientName(
  DatabaseConnectionPatchRequest,
  "StaticSiteDatabaseConnectionPatchContent",
  "csharp"
);
@@clientName(DataSource, "DetectorDataSource", "csharp");
@@clientName(DayOfWeek, "WebAppDayOfWeek", "csharp");
@@clientName(DefaultAction, "SiteDefaultAction", "csharp");
@@clientName(DeletedAppRestoreRequest, "DeletedAppRestoreContent", "csharp");
@@clientName(DeletedWebAppCollection, "DeletedWebAppListResult", "csharp");
@@clientName(Deployment, "WebAppDeployment", "csharp");
@@clientName(DeploymentCollection, "WebAppDeploymentListResult", "csharp");
@@clientName(DetectorResponse, "AppServiceDetector", "csharp");
@@clientName(
  DetectorResponseCollection,
  "AppServiceDetectorListResult",
  "csharp"
);
@@clientName(
  DiagnosticAnalysisCollection,
  "WebSiteAnalysisDefinitionListResult",
  "csharp"
);
@@clientName(
  DiagnosticCategoryCollection,
  "DiagnosticCategoryListResult",
  "csharp"
);
@@clientName(DiagnosticData, "DiagnosticDataset", "csharp");
@@clientName(
  DiagnosticDetectorCollection,
  "DiagnosticDetectorListResult",
  "csharp"
);
@@clientName(Dimension, "MetricDimension", "csharp");
@@clientName(
  DnlResourceNameAvailability,
  "DnlResourceNameAvailabilityResult",
  "csharp"
);
@@clientName(EnabledConfig, "WebAppEnabledConfig", "csharp");
@@clientName(EnvironmentVariable, "WebAppEnvironmentVariable", "csharp");
@@clientName(ErrorInfo, "WebAppErrorInfo", "csharp");
@@clientName(ErrorProperties, "WebAppErrorProperties", "csharp");
@@clientName(Microsoft.Web.ErrorResponse, "WebAppErrorResponse", "csharp");
@@clientName(Experiments, "RoutingRuleExperiments", "csharp");
@@clientName(Expression, "WorkflowExpression", "csharp");
@@clientName(ExpressionRoot, "WorkflowExpressionRoot", "csharp");
@@clientName(Facebook, "AppServiceFacebookProvider", "csharp");
@@clientName(FrequencyUnit, "BackupFrequencyUnit", "csharp");
@@clientName(
  FunctionAppStackCollection,
  "FunctionAppStackListResult",
  "csharp"
);
@@clientName(
  FunctionEnvelopeCollection,
  "FunctionEnvelopeListResult",
  "csharp"
);
@@clientName(
  FunctionsAlwaysReadyConfig,
  "FunctionAppAlwaysReadyConfig",
  "csharp"
);
@@clientName(FunctionsDeploymentStorage, "FunctionAppStorage", "csharp");
@@clientName(
  FunctionsDeploymentStorageType,
  "FunctionAppStorageType",
  "csharp"
);
@@clientName(
  FunctionsDeploymentStorageAuthentication,
  "FunctionAppStorageAuthentication",
  "csharp"
);
@@clientName(FunctionsRuntime, "FunctionAppRuntime", "csharp");
@@clientName(
  FunctionsScaleAndConcurrency,
  "FunctionAppScaleAndConcurrency",
  "csharp"
);
@@clientName(GeoRegionCollection, "AppServiceGeoRegionListResult", "csharp");
@@clientName(GitHub, "AppServiceGitHubProvider", "csharp");
@@clientName(Google, "AppServiceGoogleProvider", "csharp");
@@clientName(HandlerMapping, "HttpRequestHandlerMapping", "csharp");
@@clientName(HostKeys, "FunctionAppHostKeys", "csharp");
@@clientName(HostNameBindingCollection, "HostNameBindingListResult", "csharp");
@@clientName(
  HybridConnectionCollection,
  "HybridConnectionListResult",
  "csharp"
);
@@clientName(IdentifierCollection, "AppServiceIdentifierListResult", "csharp");
@@clientName(
  InAvailabilityReasonType,
  "AppServiceNameUnavailableReason",
  "csharp"
);
@@clientName(
  InboundEnvironmentEndpointCollection,
  "InboundEnvironmentEndpointListResult",
  "csharp"
);
@@clientName(InsightStatus, "DetectorInsightStatus", "csharp");
@@clientName(IpAddress, "WebAppIPAddress", "csharp");
@@clientName(IpAddressRange, "WebAppIPAddressRange", "csharp");
@@clientName(IssueType, "DetectorIssueType", "csharp");
@@clientName(JsonSchema, "WebAppJsonSchema", "csharp");
@@clientName(KeyInfo, "WebAppKeyInfo", "csharp");
@@clientName(KeyType, "WebAppKeyType", "csharp");
@@clientName(KeyValuePairStringObject, "DataProviderKeyValuePair", "csharp");
@@clientName(KubeEnvironmentCollection, "KubeEnvironmentListResult", "csharp");
@@clientName(Login, "WebAppLoginInfo", "csharp");
@@clientName(LogLevel, "WebAppLogLevel", "csharp");
@@clientName(MSDeploy, "WebAppMSDeploy", "csharp");
@@clientName(MSDeployLog, "WebAppMSDeployLog", "csharp");
@@clientName(MSDeployLogEntry, "WebAppMSDeployLogEntry", "csharp");
@@clientName(MSDeployLogEntryType, "WebAppMSDeployLogEntryType", "csharp");
@@clientName(NameIdentifier, "AppServiceDomainNameIdentifier", "csharp");
@@clientName(NetworkTrace, "WebAppNetworkTrace", "csharp");
@@clientName(Nonce, "LoginFlowNonceSettings", "csharp");
@@clientName(
  OutboundEnvironmentEndpointCollection,
  "OutboundEnvironmentEndpointListResult",
  "csharp"
);
@@clientName(ParameterType, "WebAppParameterType", "csharp");
@@clientName(PerfMonCounterCollection, "PerfMonCounterListResult", "csharp");
@@clientName(PerfMonResponse, "PerfMonResponseInfo", "csharp");
@@clientName(
  PremierAddOnOfferCollection,
  "PremierAddOnOfferListResult",
  "csharp"
);
@@clientName(
  PrivateEndpointConnectionCollection,
  "RemotePrivateEndpointConnectionListResult",
  "csharp"
);
@@clientName(
  PrivateLinkConnectionApprovalRequestResource,
  "PrivateLinkConnectionApprovalRequestInfo",
  "csharp"
);
@@clientName(
  Microsoft.Web.PrivateLinkResource,
  "AppServicePrivateLinkResourceData",
  "csharp"
);
@@clientName(
  Microsoft.Web.PrivateLinkResourceProperties,
  "AppServicePrivateLinkResourceProperties",
  "csharp"
);
@@clientName(ProcessInfoCollection, "ProcessInfoListResult", "csharp");
@@clientName(
  ProcessModuleInfoCollection,
  "ProcessModuleInfoListResult",
  "csharp"
);
@@clientName(ProcessThreadInfo, "WebAppProcessThreadInfo", "csharp");
@@clientName(
  ProcessThreadInfoProperties,
  "WebAppProcessThreadProperties",
  "csharp"
);
@@clientName(ComputeModeOptions, "ComputeModeOption", "csharp");
@@clientName(WorkerSizeOptions, "WorkerSizeOption", "csharp");
@@clientName(
  ProcessThreadInfoCollection,
  "WebAppProcessThreadInfoListResult",
  "csharp"
);
@@clientName(
  PublicCertificateCollection,
  "PublicCertificateListResult",
  "csharp"
);
@@clientName(
  PublishingCredentialsPoliciesCollection,
  "PublishingCredentialsPoliciesListResult",
  "csharp"
);
@@clientName(PushSettings, "WebAppPushSettings", "csharp");
@@clientName(Recommendation, "AppServiceRecommendation", "csharp");
@@clientName(
  RecommendationCollection,
  "AppServiceRecommendationListResult",
  "csharp"
);
@@clientName(RecurrenceFrequency, "WorkflowRecurrenceFrequency", "csharp");
@@clientName(RecurrenceSchedule, "WorkflowRecurrenceSchedule", "csharp");
@@clientName(
  RegenerateActionParameter,
  "WorkflowRegenerateActionContent",
  "csharp"
);
@@clientName(Rendering, "DiagnosticDataRendering", "csharp");
@@clientName(RenderingType, "DiagnosticDataRenderingType", "csharp");
@@clientName(RepetitionIndex, "WorkflowRunActionRepetitionIndex", "csharp");
@@clientName(Request, "WebAppRequest", "csharp");
@@clientName(RequestHistory, "WebAppRequestHistory", "csharp");
@@clientName(
  RequestHistoryProperties,
  "WebAppRequestHistoryProperties",
  "csharp"
);
@@clientName(ResourceCollection, "AppServicePlanResourceListResult", "csharp");
@@clientName(ResourceConfig, "FunctionAppResourceConfig", "csharp");
@@clientName(
  ResourceHealthMetadataCollection,
  "ResourceHealthMetadataListResult",
  "csharp"
);
@@clientName(
  ResourceMetricDefinitionCollection,
  "ResourceMetricDefinitionListResult",
  "csharp"
);
@@clientName(
  ResourceNameAvailability,
  "AppServiceNameAvailabilityResult",
  "csharp"
);
@@clientName(
  ResourceNameAvailabilityRequest,
  "AppServiceNameAvailabilityRequest",
  "csharp"
);
@@clientName(ResourceReference, "WorkflowResourceReference", "csharp");
@@clientName(Microsoft.Web.Response, "WebAppResponse", "csharp");
@@clientName(ResponseMetaData, "DetectorMetadata", "csharp");
@@clientName(RestoreRequest, "RestoreRequestInfo", "csharp");
@@clientName(RetryHistory, "WebAppRetryHistory", "csharp");
@@clientName(RouteType, "AppServiceVirtualNetworkRouteType", "csharp");
@@clientName(RunActionCorrelation, "WebAppRunActionCorrelation", "csharp");
@@clientName(RunCorrelation, "WebAppRunCorrelation", "csharp");
@@clientName(RuntimeName, "FunctionAppRuntimeName", "csharp");
@@clientName(Site, "WebSite", "csharp");
@@clientName(SiteAvailabilityState, "WebSiteAvailabilityState", "csharp");
@@clientName(SiteConfigResourceCollection, "SiteConfigListResult", "csharp");
@@clientName(
  SiteConfigurationSnapshotInfoCollection,
  "SiteConfigurationSnapshotInfoListResult",
  "csharp"
);
@@clientName(
  SiteExtensionInfoCollection,
  "SiteExtensionInfoListResult",
  "csharp"
);
@@clientName(SitePatchResource, "SitePatchInfo", "csharp");
@@clientName(SkuCapacity, "AppServiceSkuCapacity", "csharp");
@@clientName(SkuDescription, "AppServiceSkuDescription", "csharp");
@@clientName(SkuInfo, "AppServicePoolSkuInfo", "csharp");
@@clientName(SkuInfoCollection, "AppServicePoolSkuInfoListResult", "csharp");
@@clientName(SkuInfos, "AppServiceSkuResult", "csharp");
@@clientName(SlotDifferenceCollection, "SlotDifferenceListResult", "csharp");
@@clientName(Snapshot, "AppSnapshot", "csharp");
@@clientName(SnapshotCollection, "AppSnapshotListResult", "csharp");
@@clientName(Solution, "DiagnosticSolution", "csharp");
@@clientName(SolutionType, "DiagnosticSolutionType", "csharp");
@@clientName(
  SourceControlCollection,
  "AppServiceSourceControlListResult",
  "csharp"
);
@@clientName(SslState, "HostNameBindingSslState", "csharp");
@@clientName(StampCapacityCollection, "StampCapacityListResult", "csharp");
@@clientName(StaticSite, "StaticSiteProperties", "csharp");
@@clientName(StaticSiteARMResource, "StaticSite", "csharp");
@@clientName(
  StaticSiteBasicAuthPropertiesARMResource,
  "StaticSiteBasicAuthProperty",
  "csharp"
);
@@clientName(
  StaticSiteBasicAuthPropertiesARMResourceProperties,
  "StaticSiteBasicAuthPropertyProperties",
  "csharp"
);
@@clientName(HybridConnectionLimits, "HybridConnectionLimit", "csharp");
@@clientName(
  HybridConnectionLimitsProperties,
  "HybridConnectionLimitProperties",
  "csharp"
);
@@clientName(NetworkFeatures, "NetworkFeature", "csharp");
@@clientName(NetworkFeaturesProperties, "NetworkFeatureProperties", "csharp");
@@clientName(SiteConfig, "SiteConfigProperties", "csharp");
@@clientName(SiteConfigResource, "SiteConfig", "csharp");
@@clientName(StaticSiteBuildARMResource, "StaticSiteBuild", "csharp");
@@clientName(StaticSiteBuildCollection, "StaticSiteBuildListResult", "csharp");
@@clientName(StaticSiteCollection, "StaticSiteListResult", "csharp");
@@clientName(
  StaticSiteCustomDomainOverviewARMResource,
  "StaticSiteCustomDomainOverview",
  "csharp"
);
@@clientName(
  StaticSiteCustomDomainOverviewCollection,
  "StaticSiteCustomDomainOverviewListResult",
  "csharp"
);
@@clientName(
  StaticSiteCustomDomainRequestPropertiesARMResource,
  "StaticSiteCustomDomainContent",
  "csharp"
);
@@clientName(
  StaticSiteFunctionOverviewARMResource,
  "StaticSiteFunctionOverview",
  "csharp"
);
@@clientName(
  StaticSiteFunctionOverviewCollection,
  "StaticSiteFunctionOverviewListResult",
  "csharp"
);
@@clientName(StaticSiteLinkedBackend, "StaticSiteLinkedBackendInfo", "csharp");
@@clientName(
  StaticSiteLinkedBackendARMResource,
  "StaticSiteLinkedBackend",
  "csharp"
);
@@clientName(
  StaticSiteResetPropertiesARMResource,
  "StaticSiteResetContent",
  "csharp"
);
@@clientName(StaticSiteTemplateOptions, "StaticSiteTemplate", "csharp");
@@clientName(StaticSiteUserARMResource, "StaticSiteUser", "csharp");
@@clientName(StaticSiteUserCollection, "StaticSiteUserListResult", "csharp");
@@clientName(
  StaticSiteUserInvitationRequestResource,
  "StaticSiteUserInvitationContent",
  "csharp"
);
@@clientName(
  StaticSiteUserInvitationResponseResource,
  "StaticSiteUserInvitationResult",
  "csharp"
);
@@clientName(
  StaticSiteUserProvidedFunctionApp,
  "LegacyStaticSiteUserProvidedFunctionApp",
  "csharp"
); // Rename this model to avoid name collision with StaticSiteUserProvidedFunctionAppARMResource
@@alternateType(
  StaticSiteUserProvidedFunctionApp,
  StaticSiteUserProvidedFunctionAppARMResource,
  "csharp"
); // StaticSiteUserProvidedFunctionAppARMResource and StaticSiteUserProvidedFunctionApp are two models with exactly same properties but different names. Here we manually replace the references so that these two models are combined
@@clientName(
  StaticSiteUserProvidedFunctionAppProperties,
  "LegacyStaticSiteUserProvidedFunctionAppProperties",
  "csharp"
); // Rename this model to avoid name collision with StaticSiteUserProvidedFunctionAppARMResource
@@alternateType(
  StaticSiteUserProvidedFunctionAppProperties,
  StaticSiteUserProvidedFunctionAppARMResourceProperties,
  "csharp"
); // StaticSiteUserProvidedFunctionAppARMResource and StaticSiteUserProvidedFunctionApp are two models with exactly same properties but different names. Here we manually replace the references so that these two models are combined
@@clientName(
  StaticSiteUserProvidedFunctionAppARMResource,
  "StaticSiteUserProvidedFunctionApp",
  "csharp"
);
@@clientName(
  StaticSiteUserProvidedFunctionAppARMResourceProperties,
  "StaticSiteUserProvidedFunctionAppProperties",
  "csharp"
);
@@clientName(
  StaticSiteUserProvidedFunctionAppsCollection,
  "StaticSiteUserProvidedFunctionAppsListResult",
  "csharp"
);
@@clientName(
  StaticSiteZipDeployment,
  "StaticSiteZipDeploymentProperties",
  "csharp"
);
@@clientName(
  StaticSiteZipDeploymentARMResource,
  "StaticSiteZipDeployment",
  "csharp"
);
@@clientName(Status, "AppServiceStatusInfo", "csharp");
@@clientName(StatusOptions, "AppServicePlanStatus", "csharp");
@@clientName(StorageMigrationResponse, "StorageMigrationResult", "csharp");
@@clientName(
  StorageMigrationResponseProperties,
  "StorageMigrationProperties",
  "csharp"
);
@@clientName(StorageMigrationOptions, "StorageMigrationContent", "csharp");
@@clientName(
  StorageMigrationOptionsProperties,
  "StorageMigrationContentProperties",
  "csharp"
);
@@clientName(StorageType, "ArtifactStorageType", "csharp");
@@clientName(StringDictionary, "AppServiceConfigurationDictionary", "csharp");
@@clientName(StringList, "StaticSiteStringList", "csharp");
@@clientName(SupportedTlsVersions, "AppServiceSupportedTlsVersion", "csharp");
@@clientName(SupportTopic, "DetectorSupportTopic", "csharp");
@@clientName(TlsCipherSuites, "AppServiceTlsCipherSuite", "csharp");
@@clientName(
  TriggeredJobHistoryCollection,
  "TriggeredJobHistoryListResult",
  "csharp"
);
@@clientName(TriggeredWebJobCollection, "TriggeredWebJobListResult", "csharp");
@@clientName(TriggerTypes, "FunctionTriggerType", "csharp");
@@clientName(Twitter, "AppServiceTwitterProvider", "csharp");
@@clientName(
  UpgradeAvailability,
  "AppServiceEnvironmentUpgradeAvailability",
  "csharp"
);
@@clientName(
  UpgradePreference,
  "AppServiceEnvironmentUpgradePreference",
  "csharp"
);
@@clientName(UsageCollection, "AppServiceUsageListResult", "csharp");
@@clientName(User, "PublishingUser", "csharp");
@@clientName(ValidateRequest, "AppServiceValidateContent", "csharp");
@@clientName(ValidateResponse, "AppServiceValidateResult", "csharp");
@@clientName(VnetGateway, "AppServiceVirtualNetworkGateway", "csharp");
@@clientName(VnetInfo, "AppServiceVirtualNetworkProperties", "csharp");
@@clientName(VnetInfoResource, "AppServiceVirtualNetwork", "csharp");
@@clientName(
  VnetParameters,
  "AppServiceVirtualNetworkValidationContent",
  "csharp"
);
@@clientName(VnetRoute, "AppServiceVirtualNetworkRoute", "csharp");
@@clientName(
  VnetValidationFailureDetails,
  "VirtualNetworkValidationFailureDetails",
  "csharp"
);
@@clientName(
  VnetValidationTestFailure,
  "VirtualNetworkValidationTestFailure",
  "csharp"
);
@@clientName(VolumeMount, "SiteContainerVolumeMount", "csharp");
@@clientName(WebAppCollection, "WebAppListResult", "csharp");
@@clientName(
  WebAppInstanceStatusCollection,
  "WebAppInstanceStatusListResult",
  "csharp"
);
@@clientName(WebAppStackCollection, "WebAppStackListResult", "csharp");
@@clientName(WebJobCollection, "WebJobCListResult", "csharp");
@@clientName(WorkerPoolCollection, "AppServiceWorkerPoolListResult", "csharp");
@@clientName(WorkerPoolResource, "AppServiceWorkerPool", "csharp");
@@clientName(Workflow, "WorkflowData", "csharp");
@@clientName(WorkflowOutputParameter, "WorkflowOutputContent", "csharp");
@@clientName(WorkflowParameter, "WorkflowContent", "csharp");
@@clientName(
  WorkflowTriggerListCallbackUrlQueries,
  "WorkflowTriggerListCallbackUriQueries",
  "csharp"
);
@@clientName(ApiKVReference, "ApiKeyVaultReference", "csharp");
@@clientName(
  ApiKVReferenceProperties,
  "ApiKeyVaultReferenceProperties",
  "csharp"
);

// --- Property renames on Properties companion models (flattened ARM resources) ---
@@clientName(
  AddressResponseProperties.vipMappings,
  "VirtualIPMappings",
  "csharp"
);
@@clientName(ApiKVReferenceProperties.identityType, "Identity", "csharp");
@@clientName(ApplicationStackResource.name, "StackName", "csharp");
@@clientName(AppServiceEnvironment.suspended, "IsSuspended", "csharp");
@@clientName(AppServiceEnvironment.zoneRedundant, "IsZoneRedundant", "csharp");
@@clientName(
  AppServicePlanProperties.asyncScalingEnabled,
  "IsAsyncScalingEnabled",
  "csharp"
);
@@clientName(
  AppServicePlanProperties.elasticScaleEnabled,
  "IsElasticScaleEnabled",
  "csharp"
);
@@clientName(
  AppServicePlanProperties.freeOfferExpirationTime,
  "FreeOfferExpireOn",
  "csharp"
);
@@clientName(AppServicePlanProperties.hyperV, "IsHyperV", "csharp");
@@clientName(
  AppServicePlanProperties.perSiteScaling,
  "IsPerSiteScaling",
  "csharp"
);
@@clientName(AppServicePlanProperties.reserved, "IsReserved", "csharp");
@@clientName(
  AppServicePlanProperties.spotExpirationTime,
  "SpotExpireOn",
  "csharp"
);
@@clientName(
  AppServicePlanProperties.zoneRedundant,
  "IsZoneRedundant",
  "csharp"
);
@@clientName(
  AppServicePlanPatchResourceProperties.elasticScaleEnabled,
  "IsElasticScaleEnabled",
  "csharp"
);
@@clientName(
  AppServicePlanPatchResourceProperties.hyperV,
  "IsHyperV",
  "csharp"
);
@@clientName(
  AppServicePlanPatchResourceProperties.perSiteScaling,
  "IsPerSiteScaling",
  "csharp"
);
@@clientName(
  AppServicePlanPatchResourceProperties.reserved,
  "IsReserved",
  "csharp"
);
@@clientName(
  AppServicePlanPatchResourceProperties.zoneRedundant,
  "IsZoneRedundant",
  "csharp"
);
@@clientName(
  AseRegionProperties.dedicatedHost,
  "IsDedicatedHostEnabled",
  "csharp"
);
@@clientName(AseRegionProperties.standard, "IsStandard", "csharp");
@@clientName(
  AseRegionProperties.zoneRedundant,
  "IsZoneRedundantEnabled",
  "csharp"
);
@@clientName(
  AseV3NetworkingConfigurationProperties.ftpEnabled,
  "IsFtpEnabled",
  "csharp"
);
@@clientName(
  AseV3NetworkingConfigurationProperties.remoteDebugEnabled,
  "IsRemoteDebugEnabled",
  "csharp"
);
@@clientName(
  AzureActiveDirectoryRegistration.clientSecretCertificateThumbprint,
  "ClientSecretCertificateThumbprintString",
  "csharp"
);
@@clientName(
  AzureTableStorageApplicationLogsConfig.sasUrl,
  "SasUriString",
  "csharp"
);
@@clientName(BackupItemProperties.created, "CreatedOn", "csharp");
@@clientName(BackupItemProperties.finishedTimeStamp, "FinishedOn", "csharp");
@@clientName(
  BackupItemProperties.lastRestoreTimeStamp,
  "LastRestoreOn",
  "csharp"
);
@@clientName(BackupItemProperties.name, "BackupName", "csharp");
@@clientName(BackupItemProperties.scheduled, "IsScheduled", "csharp");
@@clientName(BackupRequestProperties.enabled, "IsEnabled", "csharp");
@@clientName(CertificateProperties.expirationDate, "ExpireOn", "csharp");
@@clientName(CertificateProperties.thumbprint, "ThumbprintString", "csharp");
@@clientName(CertificateProperties.valid, "IsValid", "csharp");
@@clientName(
  CertificatePatchResourceProperties.thumbprint,
  "ThumbprintString",
  "csharp"
);
@@clientName(CertificatePatchResourceProperties.valid, "IsValid", "csharp");
@@clientName(ContinuousWebJobProperties.using_sdk, "IsUsingSdk", "csharp");
@@clientName(
  DatabaseConnectionProperties.resourceId,
  "DatabaseConnectionResourceId",
  "csharp"
);
@@clientName(
  DatabaseConnectionPatchRequestProperties.resourceId,
  "DatabaseConnectionResourceId",
  "csharp"
);
@@clientName(DeploymentProperties.active, "IsActive", "csharp");
@@clientName(
  HostNameBindingProperties.thumbprint,
  "ThumbprintString",
  "csharp"
);
@@clientName(HybridConnectionProperties.relayArmUri, "relayArmId", "csharp");
@@clientName(
  KubeEnvironmentProperties.internalLoadBalancerEnabled,
  "IsInternalLoadBalancerEnabled",
  "csharp"
);
@@clientName(
  KubeEnvironmentPatchResourceProperties.internalLoadBalancerEnabled,
  "IsInternalLoadBalancerEnabled",
  "csharp"
);
@@clientName(
  MigrateMySqlStatusProperties.localMySqlEnabled,
  "IsLocalMySqlEnabled",
  "csharp"
);
@@clientName(MSDeployProperties.appOffline, "IsAppOffline", "csharp");
@@clientName(MSDeployStatusProperties.complete, "IsComplete", "csharp");
@@clientName(
  PremierAddOnOfferProperties.promoCodeRequired,
  "IsPromoCodeRequired",
  "csharp"
);
@@clientName(PrivateAccessProperties.enabled, "IsEnabled", "csharp");
@@clientName(ProcessInfoProperties.threads, "ProcessThreads", "csharp");
@@clientName(
  PublicCertificateProperties.thumbprint,
  "ThumbprintString",
  "csharp"
);
@@clientName(
  RemotePrivateEndpointConnectionARMResourceProperties.ipAddresses,
  "IPAddresses",
  "csharp"
);
@@clientName(
  ResourceHealthMetadataProperties.signalAvailability,
  "IsSignalAvailable",
  "csharp"
);
@@clientName(
  SiteProperties.clientAffinityEnabled,
  "IsClientAffinityEnabled",
  "csharp"
);
@@clientName(
  SiteProperties.clientAffinityPartitioningEnabled,
  "IsClientAffinityPartitioningEnabled",
  "csharp"
);
@@clientName(
  SiteProperties.clientAffinityProxyEnabled,
  "IsClientAffinityProxyEnabled",
  "csharp"
);
@@clientName(SiteProperties.clientCertEnabled, "IsClientCertEnabled", "csharp");
@@clientName(SiteProperties.enabled, "IsEnabled", "csharp");
@@clientName(
  SiteProperties.endToEndEncryptionEnabled,
  "IsEndToEndEncryptionEnabled",
  "csharp"
);
@@clientName(SiteProperties.hostNamesDisabled, "IsHostNameDisabled", "csharp");
@@clientName(SiteProperties.httpsOnly, "IsHttpsOnly", "csharp");
@@clientName(SiteProperties.hyperV, "IsHyperV", "csharp");
@@clientName(SiteProperties.reserved, "IsReserved", "csharp");
@@clientName(
  SiteProperties.scmSiteAlsoStopped,
  "IsScmSiteAlsoStopped",
  "csharp"
);
@@clientName(SiteProperties.serverFarmId, "AppServicePlanId", "csharp");
@@clientName(SiteProperties.sshEnabled, "IsSshEnabled", "csharp");
@@clientName(
  SiteProperties.storageAccountRequired,
  "IsStorageAccountRequired",
  "csharp"
);
@@clientName(SiteProperties.suspendedTill, "SuspendOn", "csharp");
@@clientName(
  SiteAuthSettingsProperties.clientSecretCertificateThumbprint,
  "ClientSecretCertificateThumbprintString",
  "csharp"
);
@@clientName(SiteAuthSettingsProperties.enabled, "IsEnabled", "csharp");
@@clientName(
  SiteAuthSettingsProperties.tokenStoreEnabled,
  "IsTokenStoreEnabled",
  "csharp"
);
@@clientName(
  SiteConfig.acrUseManagedIdentityCreds,
  "UseManagedIdentityCreds",
  "csharp"
);
@@clientName(SiteConfig.alwaysOn, "IsAlwaysOn", "csharp");
@@clientName(SiteConfig.autoHealEnabled, "IsAutoHealEnabled", "csharp");
@@clientName(
  SiteConfig.detailedErrorLoggingEnabled,
  "IsDetailedErrorLoggingEnabled",
  "csharp"
);
@@clientName(
  SiteConfig.functionsRuntimeScaleMonitoringEnabled,
  "IsFunctionsRuntimeScaleMonitoringEnabled",
  "csharp"
);
@@clientName(SiteConfig.http20Enabled, "IsHttp20Enabled", "csharp");
@@clientName(SiteConfig.httpLoggingEnabled, "IsHttpLoggingEnabled", "csharp");
@@clientName(SiteConfig.localMySqlEnabled, "IsLocalMySqlEnabled", "csharp");
@@clientName(
  SiteConfig.remoteDebuggingEnabled,
  "IsRemoteDebuggingEnabled",
  "csharp"
);
@@clientName(
  SiteConfig.requestTracingEnabled,
  "IsRequestTracingEnabled",
  "csharp"
);
@@clientName(
  SiteConfig.scmIpSecurityRestrictionsUseMain,
  "AllowIPSecurityRestrictionsForScmToUseMain",
  "csharp"
);
@@clientName(SiteConfig.vnetRouteAllEnabled, "IsVnetRouteAllEnabled", "csharp");
@@clientName(SiteConfig.webSocketsEnabled, "IsWebSocketsEnabled", "csharp");
@@clientName(
  SiteConfigurationSnapshotInfoProperties.time,
  "SnapshotTakenTime",
  "csharp"
);
@@clientName(
  SiteLogsConfigProperties.detailedErrorMessages,
  "IsDetailedErrorMessages",
  "csharp"
);
@@clientName(
  SiteLogsConfigProperties.failedRequestsTracing,
  "IsFailedRequestsTracing",
  "csharp"
);
@@clientName(
  SitePatchResourceProperties.clientAffinityEnabled,
  "IsClientAffinityEnabled",
  "csharp"
);
@@clientName(
  SitePatchResourceProperties.clientAffinityProxyEnabled,
  "IsClientAffinityProxyEnabled",
  "csharp"
);
@@clientName(
  SitePatchResourceProperties.clientCertEnabled,
  "IsClientCertEnabled",
  "csharp"
);
@@clientName(SitePatchResourceProperties.enabled, "IsEnabled", "csharp");
@@clientName(
  SitePatchResourceProperties.hostNamesDisabled,
  "IsHostNameDisabled",
  "csharp"
);
@@clientName(SitePatchResourceProperties.httpsOnly, "IsHttpsOnly", "csharp");
@@clientName(SitePatchResourceProperties.hyperV, "IsHyperV", "csharp");
@@clientName(
  SitePatchResourceProperties.lastModifiedTimeUtc,
  "LastModifiedOn",
  "csharp"
);
@@clientName(SitePatchResourceProperties.reserved, "IsReserved", "csharp");
@@clientName(
  SitePatchResourceProperties.scmSiteAlsoStopped,
  "IsScmSiteAlsoStopped",
  "csharp"
);
@@clientName(
  SitePatchResourceProperties.storageAccountRequired,
  "IsStorageAccountRequired",
  "csharp"
);
@@clientName(SitePatchResourceProperties.suspendedTill, "SuspendOn", "csharp");
@@clientName(
  SiteSourceControlProperties.deploymentRollbackEnabled,
  "IsDeploymentRollbackEnabled",
  "csharp"
);
@@clientName(
  StaticSiteBuildARMResourceProperties.createdTimeUtc,
  "CreatedOn",
  "csharp"
);
@@clientName(
  SwiftVirtualNetworkProperties.swiftSupported,
  "IsSwiftSupported",
  "csharp"
);
@@clientName(
  TriggeredWebJobProperties.storageAccountRequired,
  "IsStorageAccountRequired",
  "csharp"
);
@@clientName(TriggeredWebJobProperties.using_sdk, "IsUsingSdk", "csharp");
@@clientName(
  WebAppRuntimeSettings.remoteDebuggingSupported,
  "IsRemoteDebuggingSupported",
  "csharp"
);
@@clientName(WebJobProperties.using_sdk, "IsUsingSdk", "csharp");
@@clientName(
  WebSiteInstanceStatusProperties.healthCheckUrl,
  "healthCheckUrlString",
  "csharp"
);
@@clientName(WorkflowTriggerHistoryProperties.fired, "IsFired", "csharp");

// --- Property renames on non-resource sub-models (no `.properties.` segment) ---
@@clientName(Apple.enabled, "IsEnabled", "csharp");
@@clientName(AuthPlatform.enabled, "IsEnabled", "csharp");
@@clientName(AzureActiveDirectory.enabled, "IsEnabled", "csharp");
@@clientName(
  AzureActiveDirectoryLogin.disableWWWAuthenticate,
  "IsWwwAuthenticateDisabled",
  "csharp"
);
@@clientName(AzureBlobStorageHttpLogsConfig.enabled, "IsEnabled", "csharp");
@@clientName(AzureStaticWebApps.enabled, "IsEnabled", "csharp");
@@clientName(
  BackupSchedule.keepAtLeastOneBackup,
  "ShouldKeepAtLeastOneBackup",
  "csharp"
);
@@clientName(BackupSchedule.lastExecutionTime, "LastExecutedOn", "csharp");
@@clientName(CloningInfo.overwrite, "CanOverwrite", "csharp");
@@clientName(
  CorsSettings.supportCredentials,
  "IsCredentialsSupported",
  "csharp"
);
@@clientName(
  CsmPublishingProfileOptions.includeDisasterRecoveryEndpoints,
  "IsIncludeDisasterRecoveryEndpoints",
  "csharp"
);
@@clientName(CustomOpenIdConnectProvider.enabled, "IsEnabled", "csharp");
@@clientName(DaprConfig.enableApiLogging, "IsApiLoggingEnabled", "csharp");
@@clientName(DaprConfig.enabled, "IsEnabled", "csharp");
@@clientName(
  Dimension.toBeExportedForShoebox,
  "IsToBeExportedForShoebox",
  "csharp"
);
@@clientName(Microsoft.Web.ErrorResponse.error, "ErrorInfo", "csharp");
@@clientName(Facebook.enabled, "IsEnabled", "csharp");
@@clientName(FileSystemHttpLogsConfig.enabled, "IsEnabled", "csharp");
@@clientName(
  FunctionAppRuntimeSettings.remoteDebuggingSupported,
  "IsRemoteDebuggingSupported",
  "csharp"
);
@@clientName(
  FunctionsAlwaysReadyConfig.instanceCount,
  "AlwaysReadyInstanceCount",
  "csharp"
);
@@clientName(FunctionsDeploymentStorage.type, "StorageType", "csharp");
@@clientName(
  FunctionsScaleAndConcurrency.instanceMemoryMB,
  "FunctionAppInstanceMemoryMB",
  "csharp"
);
@@clientName(
  FunctionsScaleAndConcurrency.maximumInstanceCount,
  "FunctionAppMaximumInstanceCount",
  "csharp"
);
@@clientName(
  FunctionsScaleAndConcurrencyTriggersHttp.perInstanceConcurrency,
  "ConcurrentHttpPerInstanceConcurrency",
  "csharp"
);
@@clientName(GitHub.enabled, "IsEnabled", "csharp");
@@clientName(
  GlobalValidation.requireAuthentication,
  "IsAuthenticationRequired",
  "csharp"
);
@@clientName(Google.enabled, "IsEnabled", "csharp");
@@clientName(HostNameSslState.thumbprint, "ThumbprintString", "csharp");
@@clientName(HttpSettings.requireHttps, "IsHttpsRequired", "csharp");
@@clientName(IpSecurityRestriction.ipAddress, "IPAddressOrCidr", "csharp");
@@clientName(LegacyMicrosoftAccount.enabled, "IsEnabled", "csharp");
@@clientName(
  MetricSpecification.enableRegionalMdmAccount,
  "IsRegionalMdmAccountEnabled",
  "csharp"
);
@@clientName(
  MetricSpecification.supportsInstanceLevelAggregation,
  "IsInstanceLevelAggregationSupported",
  "csharp"
);
@@clientName(
  OpenAuthenticationAccessPolicies.policies,
  "OpenAuthenticationPolicyList",
  "csharp"
);
@@clientName(OutboundVnetRouting.allTraffic, "IsAllTrafficEnabled", "csharp");
@@clientName(
  OutboundVnetRouting.applicationTraffic,
  "IsApplicationTrafficEnabled",
  "csharp"
);
@@clientName(
  OutboundVnetRouting.contentShareTraffic,
  "IsContentShareTrafficEnabled",
  "csharp"
);
@@clientName(
  OutboundVnetRouting.imagePullTraffic,
  "IsImagePullTrafficEnabled",
  "csharp"
);
@@clientName(
  OutboundVnetRouting.backupRestoreTraffic,
  "IsBackupRestoreTrafficEnabled",
  "csharp"
);
@@clientName(
  ResourceNameAvailability.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(RestoreRequestProperties.overwrite, "CanOverwrite", "csharp");
@@clientName(
  SnapshotRestoreRequestProperties.overwrite,
  "CanOverwrite",
  "csharp"
);
@@clientName(
  StackMajorVersion.applicationInsights,
  "IsApplicationInsights",
  "csharp"
);
@@clientName(TokenStore.enabled, "IsEnabled", "csharp");
@@clientName(Twitter.enabled, "IsEnabled", "csharp");
@@clientName(VirtualApplication.preloadEnabled, "IsPreloadEnabled", "csharp");
@@clientName(VirtualIPMapping.inUse, "IsInUse", "csharp");
@@clientName(VnetInfo.certThumbprint, "CertThumbprintString", "csharp");
@@clientName(VnetInfo.resyncRequired, "IsResyncRequired", "csharp");
@@clientName(
  VnetValidationFailureDetailsProperties.failed,
  "IsFailed",
  "csharp"
);
@@clientName(VolumeMount.readOnly, "IsReadOnly", "csharp");
@@clientName(
  WorkflowTriggerListCallbackUrlQueries.se,
  "SasTimestamp",
  "csharp"
);
@@clientName(
  WorkflowTriggerListCallbackUrlQueries.sig,
  "SasSignature",
  "csharp"
);
@@clientName(
  WorkflowTriggerListCallbackUrlQueries.sp,
  "SasPermission",
  "csharp"
);
@@clientName(WorkflowTriggerListCallbackUrlQueries.sv, "SasVersion", "csharp");
@@clientName(ApiDefinitionInfo.url, "ApiDefinitionUriStringValue", "csharp");
@@clientName(
  FunctionsDeploymentStorage.value,
  "AzureStorageUriStringValue",
  "csharp"
);

// --- Enum value renames ---
@@clientName(
  TlsCipherSuites.TLS_AES_128_GCM_SHA256,
  "TlsAes128GcmSha256",
  "csharp"
);
@@clientName(
  TlsCipherSuites.TLS_AES_256_GCM_SHA384,
  "TlsAes256GcmSha384",
  "csharp"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,
  "TlsECDiffieHellmanECDsaWithAes128CbcSha256",
  "csharp"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,
  "TlsECDiffieHellmanECDsaWithAes128GcmSha256",
  "csharp"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,
  "TlsECDiffieHellmanECDsaWithAes256GcmSha384",
  "csharp"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,
  "TlsECDiffieHellmanRsaWithAes128CbcSha",
  "csharp"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,
  "TlsECDiffieHellmanRsaWithAes128CbcSha256",
  "csharp"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,
  "TlsECDiffieHellmanRsaWithAes128GcmSha256",
  "csharp"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,
  "TlsECDiffieHellmanRsaWithAes256CbcSha",
  "csharp"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384,
  "TlsECDiffieHellmanRsaWithAes256CbcSha384",
  "csharp"
);
@@clientName(
  TlsCipherSuites.TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,
  "TlsECDiffieHellmanRsaWithAes256GcmSha384",
  "csharp"
);
@@clientName(
  TlsCipherSuites.TLS_RSA_WITH_AES_128_CBC_SHA,
  "TlsRsaWithAes128CbcSha",
  "csharp"
);
@@clientName(
  TlsCipherSuites.TLS_RSA_WITH_AES_128_CBC_SHA256,
  "TlsRsaWithAes128CbcSha256",
  "csharp"
);
@@clientName(
  TlsCipherSuites.TLS_RSA_WITH_AES_128_GCM_SHA256,
  "TlsRsaWithAes128GcmSha256",
  "csharp"
);
@@clientName(
  TlsCipherSuites.TLS_RSA_WITH_AES_256_CBC_SHA,
  "TlsRsaWithAes256CbcSha",
  "csharp"
);
@@clientName(
  TlsCipherSuites.TLS_RSA_WITH_AES_256_CBC_SHA256,
  "TlsRsaWithAes256CbcSha256",
  "csharp"
);
@@clientName(
  TlsCipherSuites.TLS_RSA_WITH_AES_256_GCM_SHA384,
  "TlsRsaWithAes256GcmSha384",
  "csharp"
);
@@clientName(ValidateResourceTypes, "ValidateResourceType", "csharp");
@@clientName(ApiDefinitionInfo, "AppServiceApiDefinitionInfo", "csharp");
@@clientName(ArmPlan, "AppServiceArmPlan", "csharp");
@@clientName(BillingMeter, "AppServiceBillingMeter", "csharp");
@@clientName(
  BlobStorageTokenStore,
  "AppServiceBlobStorageTokenStore",
  "csharp"
);
@@clientName(CorsSettings, "AppServiceCorsSettings", "csharp");
@@clientName(
  DatabaseBackupSetting,
  "AppServiceDatabaseBackupSetting",
  "csharp"
);
@@clientName(DatabaseType, "AppServiceDatabaseType", "csharp");
@@clientName(DeploymentLocations, "AppServiceDeploymentLocations", "csharp");
@@clientName(EndpointDependency, "AppServiceEndpointDependency", "csharp");
@@clientName(EndpointDetail, "AppServiceEndpointDetail", "csharp");
@@clientName(ForwardProxy, "AppServiceForwardProxy", "csharp");
@@clientName(FtpsState, "AppServiceFtpsState", "csharp");
@@clientName(GeoRegion, "AppServiceGeoRegion", "csharp");
@@clientName(HostNameType, "AppServiceHostNameType", "csharp");
@@clientName(HostType, "AppServiceHostType", "csharp");
@@clientName(HttpLogsConfig, "AppServiceHttpLogsConfig", "csharp");
@@clientName(HttpSettings, "AppServiceHttpSettings", "csharp");
@@clientName(HttpSettingsRoutes, "AppServiceHttpSettingsRoutes", "csharp");
@@clientName(Identifier, "AppServiceIdentifier", "csharp");
@@clientName(IdentityProviders, "AppServiceIdentityProviders", "csharp");
@@clientName(IpFilterTag, "AppServiceIPFilterTag", "csharp");
@@clientName(IPMode, "AppServiceIPMode", "csharp");
@@clientName(
  IpSecurityRestriction,
  "AppServiceIPSecurityRestriction",
  "csharp"
);
@@clientName(NameValuePair, "AppServiceNameValuePair", "csharp");
@@clientName(Operation, "AppServiceOperation", "csharp");
@@clientName(OperationStatus, "AppServiceOperationStatus", "csharp");
@@clientName(SourceControl, "AppServiceSourceControl", "csharp");
@@clientName(TokenStore, "AppServiceTokenStore", "csharp");
@@clientName(UsageState, "AppServiceUsageState", "csharp");
@@clientName(
  VirtualNetworkProfile,
  "AppServiceVirtualNetworkProfile",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Function names can be duplicated across different operation groups, so we suppress this warning for now."
@@clientName(AnalysisDefinitions.executeSiteAnalysis, "Execute", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Function names can be duplicated across different operation groups, so we suppress this warning for now."
@@clientName(
  DetectorDefinitionResources.executeSiteDetector,
  "Execute",
  "csharp"
);
@@clientName(Recommendations.disableRecommendationForSite, "Disable", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Function names can be duplicated across different operation groups, so we suppress this warning for now."
@@clientName(
  StaticSiteARMResources.createOrUpdateStaticSiteAppSettings,
  "CreateOrUpdateAppSettings",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Function names can be duplicated across different operation groups, so we suppress this warning for now."
@@clientName(
  StaticSiteARMResources.createOrUpdateStaticSiteFunctionAppSettings,
  "CreateOrUpdateFunctionAppSettings",
  "csharp"
);
@@clientName(
  StaticSiteARMResources.deleteStaticSiteUser,
  "DeleteUser",
  "csharp"
);
@@clientName(StaticSiteARMResources.detachStaticSite, "Detach", "csharp");
@@clientName(
  StaticSiteARMResources.listStaticSiteAppSettings,
  "GetAppSettings",
  "csharp"
);
@@clientName(
  StaticSiteARMResources.listStaticSiteConfiguredRoles,
  "GetConfiguredRoles",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Function names can be duplicated across different operation groups, so we suppress this warning for now."
@@clientName(
  StaticSiteARMResources.listStaticSiteFunctionAppSettings,
  "GetFunctionAppSettings",
  "csharp"
);
@@clientName(StaticSiteARMResources.listStaticSiteUsers, "GetUsers", "csharp");
@@clientName(
  StaticSiteARMResources.resetStaticSiteApiKey,
  "ResetApiKey",
  "csharp"
);
@@clientName(
  StaticSiteARMResources.updateStaticSiteUser,
  "UpdateUser",
  "csharp"
);
@@clientName(
  checkNameAvailability,
  "CheckAppServiceNameAvailability",
  "csharp"
);
@@clientName(
  AppServicePlans.listHybridConnections,
  "GetHybridConnectionRelays",
  "csharp"
);
@@clientName(
  HybridConnections.listWebAppsByHybridConnection,
  "GetAllWebAppsByHybridConnection",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Function names can be duplicated across different operation groups, so we suppress this warning for now."
@@clientName(
  StaticSiteBuildARMResources.createOrUpdateStaticSiteBuildAppSettings,
  "CreateOrUpdateAppSettings",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Function names can be duplicated across different operation groups, so we suppress this warning for now."
@@clientName(
  StaticSiteBuildARMResources.createOrUpdateStaticSiteBuildFunctionAppSettings,
  "CreateOrUpdateFunctionAppSettings",
  "csharp"
);
@@clientName(
  StaticSiteBuildARMResources.listStaticSiteBuildFunctions,
  "GetFunctions",
  "csharp"
);
@@clientName(
  StaticSiteBuildARMResources.createZipDeploymentForStaticSiteBuild,
  "CreateZipDeployment",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Function names can be duplicated across different operation groups, so we suppress this warning for now."
@@clientName(
  StaticSiteBuildARMResources.listStaticSiteBuildFunctionAppSettings,
  "GetFunctionAppSettings",
  "csharp"
);
@@clientName(
  RecommendationsOperationGroup.resetAllFilters,
  "ResetAllRecommendationFilters",
  "csharp"
);
@@clientName(
  StaticSitesOperationGroup.previewWorkflow,
  "PreviewStaticSiteWorkflow",
  "csharp"
);
@@clientName(
  ProviderOperationGroup.getWebAppStacksForLocation,
  "GetWebAppStacksByLocation",
  "csharp"
);
@@clientName(
  getSubscriptionDeploymentLocations,
  "GetAppServiceDeploymentLocations",
  "csharp"
);
@@clientName(
  RecommendationsOperationGroup.disableRecommendationForSubscription,
  "DisableAppServiceRecommendation",
  "csharp"
);
@@clientName(WebApps.listSnapshotsSlot, "GetSlotSnapshots", "csharp");
@@clientName(
  WebApps.listSnapshotsFromDRSecondarySlot,
  "GetSlotSnapshotsFromDRSecondary",
  "csharp"
);
@@clientName(
  AppServiceEnvironmentResources.listWebApps,
  "GetAllWebAppData",
  "csharp"
);
@@clientName(
  ResourceHealthMetadataNonResourceOperationGroup.listByResourceGroup,
  "GetAllResourceHealthMetadataData",
  "csharp"
);
@@clientName(
  listSiteIdentifiersAssignedToHostName,
  "GetAllSiteIdentifierData",
  "csharp"
);
@@clientName(
  SiteConfigResourceOperationGroup.listConfigurations,
  "GetAllConfigurationData",
  "csharp"
);
@@clientName(Sites.listHybridConnections, "GetHybridConnections", "csharp");
@@clientName(Sites.listPremierAddOns, "GetAllPremierAddOnData", "csharp");
@@clientName(
  Sites.listRelayServiceConnections,
  "GetAllRelayServiceConnectionData",
  "csharp"
);
@@clientName(Sites.listSiteBackups, "GetAllSiteBackupData", "csharp");
@@clientName(
  SiteConfigSnapshotSlotResourceOperationGroup.listConfigurationsSlot,
  "GetAllConfigurationSlotData",
  "csharp"
);
@@clientName(
  WebApps.listHybridConnectionsSlot,
  "GetHybridConnectionsSlot",
  "csharp"
);
@@clientName(
  WebApps.listPremierAddOnsSlot,
  "GetAllPremierAddOnSlotData",
  "csharp"
);
@@clientName(
  WebApps.listRelayServiceConnectionsSlot,
  "GetAllRelayServiceConnectionSlotData",
  "csharp"
);
@@clientName(WebApps.listSiteBackupsSlot, "GetAllSiteBackupSlotData", "csharp");
@@clientName(
  ProcessInfos.listInstanceProcessThreads,
  "GetSiteInstanceProcessThreads",
  "csharp"
);
@@clientName(
  ProcessInfoOperationGroup.listProcessThreads,
  "GetSiteProcessThreads",
  "csharp"
);
@@clientName(
  ProcessSlotOperationGroup.listProcessThreadsSlot,
  "GetSiteSlotProcessThreads",
  "csharp"
);
@@clientName(
  InstanceProcessSlotOperationGroup.listInstanceProcessThreadsSlot,
  "GetSiteSlotInstanceProcessThreads",
  "csharp"
);
@@clientName(
  regionalCheckNameAvailability,
  "CheckDnlResourceNameAvailability",
  "csharp"
);

// ARM resource identifiers (arm-id)
@@alternateType(VirtualNetworkProfile.id, armResourceIdentifier, "csharp");
@@alternateType(HostingEnvironmentProfile.id, armResourceIdentifier, "csharp");
@@alternateType(KubeEnvironmentProfile.id, armResourceIdentifier, "csharp");
@@alternateType(VnetInfo.vnetResourceId, armResourceIdentifier, "csharp");
@@alternateType(CloningInfo.sourceWebAppId, armResourceIdentifier, "csharp");
@@alternateType(
  CloningInfo.trafficManagerProfileId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  RecommendationProperties.resourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(SupportTopic.pesId, armResourceIdentifier, "csharp");
@@alternateType(
  DeletedAppRestoreRequestProperties.deletedSiteId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(SnapshotRecoverySource.id, armResourceIdentifier, "csharp");
@@alternateType(
  StaticSiteUserProvidedFunctionAppARMResourceProperties.functionAppResourceId,
  armResourceIdentifier,
  "csharp"
);

// ARM resource types (resource-type)
@@alternateType(VirtualNetworkProfile.type, armResourceType, "csharp");
@@alternateType(HostingEnvironmentProfile.type, armResourceType, "csharp");
@@alternateType(KubeEnvironmentProfile.type, armResourceType, "csharp");
@@alternateType(SkuInfo.resourceType, armResourceType, "csharp");
@@alternateType(SkuInfos.resourceType, armResourceType, "csharp");
@@alternateType(ResourceReference.type, armResourceType, "csharp");

// UUIDs (uuid)
@@alternateType(BillingMeterProperties.meterId, uuid, "csharp");

// IP addresses (ip-address)
@@alternateType(
  AddressResponseProperties.serviceIpAddress,
  ipV4Address,
  "csharp"
);
@@alternateType(
  AddressResponseProperties.internalIpAddress,
  ipV4Address,
  "csharp"
);
@@alternateType(
  AddressResponseProperties.outboundIpAddresses,
  ipV4Address[],
  "csharp"
);

// Durations (format: duration)
@@alternateType(LogSpecification.blobDuration, duration, "csharp");
@@alternateType(MetricAvailability.blobDuration, duration, "csharp");
@@alternateType(TriggeredJobRun.duration, duration, "csharp");

// Reparent ProxyOnlyResource-derived models to Azure.ResourceManager.CommonTypes.ProxyResource for csharp
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  AppServiceEnvironmentPatchResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  PushSettings,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ResourceMetricDefinition,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Microsoft.Web.Usage,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  AppServicePlanPatchResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  HybridConnectionKey,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  CertificatePatchResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  DiagnosticAnalysis,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  DiagnosticDetectorResponse,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Snapshot,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  KubeEnvironmentPatchResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ApplicationStackResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  FunctionAppStack,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  WebAppStack,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Recommendation,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  BillingMeter,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  CustomHostnameSites,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  GeoRegion,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  AseRegion,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  PremierAddOnOffer,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  VnetParameters,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  VnetValidationFailureDetails,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  VnetValidationTestFailure,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  StaticSitesWorkflowPreviewRequest,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  StaticSitesWorkflowPreview,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  RemotePrivateEndpointConnection,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  StaticSiteUserProvidedFunctionApp,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  StaticSitePatchResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  StaticSiteUserARMResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  StringDictionary,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  StaticSiteFunctionOverviewARMResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  StaticSiteZipDeploymentARMResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  StaticSiteUserInvitationRequestResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  StaticSiteUserInvitationResponseResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  StaticSiteCustomDomainRequestPropertiesARMResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  StringList,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  StaticSiteResetPropertiesARMResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  SitePatchResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  CustomHostnameAnalysisResult,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  BackupRequest,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  RestoreRequest,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  SiteAuthSettings,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  AzureStoragePropertyDictionaryResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ConnectionStringDictionary,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  SiteConfigurationSnapshotInfo,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  MSDeploy,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  MSDeployLog,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ProcessThreadInfo,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  MigrateMySqlRequest,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  NetworkSecurityPerimeterConfiguration,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  SitePhpErrorLogFlag,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  PremierAddOnPatchResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  DeletedAppRestoreRequest,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  SnapshotRestoreRequest,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  SlotDifference,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  PrivateLinkConnectionApprovalRequestResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  StorageMigrationOptions,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  StorageMigrationResponse,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
@@scope(RelayServiceConnectionEntityProperties.resourceType, "!csharp");
@@scope(BillingMeterProperties.resourceType, "!csharp");

@@clientName(ApplicationStack.name, "StackName", "csharp");
@@clientName(DeletedSiteProperties.kind, "DeletedSiteKind", "csharp");
@@clientName(StackPreferredOs, "StackPreferredOS", "csharp");

/**
 * The method that should be used to authenticate the user.
 */
union ClientCredentialMethod {
  string,

  /** ClientSecretPost. */
  ClientSecretPost: "ClientSecretPost",
}
@@alternateType(
  OpenIdConnectClientCredential.method,
  ClientCredentialMethod,
  "csharp"
);
/**
 * The source of the configuration reference.
 */
union ConfigReferenceSource {
  string,

  /** KeyVault. */
  KeyVault: "KeyVault",
}
@@alternateType(
  ApiKVReferenceProperties.source,
  ConfigReferenceSource,
  "csharp"
);

// Disambiguate ResourceHealthMetadata Read vs List on the same legacy operation
// group; without these renames the generator emits two CreateGetBySite[Slot]Request
// methods with identical signatures.
@@clientName(
  ResourceHealthMetadataOperationGroup.listBySite,
  "ListResourceHealthMetadata",
  "csharp"
);
@@clientName(
  BySiteSlotOperationGroup.listBySiteSlot,
  "ListResourceHealthMetadata",
  "csharp"
);
