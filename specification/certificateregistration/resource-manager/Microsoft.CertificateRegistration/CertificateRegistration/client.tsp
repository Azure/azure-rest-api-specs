import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.CertificateRegistration;

@@clientName(Microsoft.CertificateRegistration,
  "CertificateRegistrationManagementClient",
  "javascript"
);

@@clientName(Microsoft.CertificateRegistration,
  "CertificateRegistrationMgmtClient",
  "python"
);

@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AppServiceCertificate,
  "AppServiceCertificateProperties",
  "csharp"
);
@@alternateType(AppServiceCertificate.keyVaultId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AppServiceCertificateResource, "AppServiceCertificate", "csharp");
@@clientName(DetectorResponse, "AppServiceDetector", "csharp");
@@clientName(RenewCertificateOrderRequest,
  "RenewCertificateOrderContent",
  "csharp"
);
@@clientName(SiteSealRequest, "SiteSealContent", "csharp");
@@clientName(SiteSealRequest.lightTheme, "IsLightTheme", "csharp");
@@clientName(DiagnosticData, "DiagnosticDataset", "csharp");
@@clientName(ReissueCertificateOrderRequest,
  "ReissueCertificateOrderContent",
  "csharp"
);
@@clientName(DetectorResponseCollection,
  "AppServiceDetectorListResult",
  "csharp"
);
@@clientName(AppServiceCertificateOrderCollection,
  "AppServiceCertificateOrderListResult",
  "csharp"
);
@@clientName(AppServiceCertificatePatchResource,
  "AppServiceCertificatePatch",
  "csharp"
);
@@clientName(AppServiceCertificateCollection,
  "AppServiceCertificateListResult",
  "csharp"
);
@@clientName(AppServiceCertificateOrderProperties.autoRenew,
  "IsAutoRenew",
  "csharp"
);
@@clientName(AppServiceCertificateOrderProperties.expirationTime,
  "ExpireOn",
  "csharp"
);
@@clientName(AppServiceCertificateOrderProperties.lastCertificateIssuanceTime,
  "LastCertificateIssuedOn",
  "csharp"
);
@@clientName(AppServiceCertificateOrderProperties.nextAutoRenewalTimeStamp,
  "NextAutoRenewOn",
  "csharp"
);
@@clientName(AppServiceCertificateOrderPatchResourceProperties.nextAutoRenewalTimeStamp,
  "NextAutoRenewOn",
  "csharp"
);
@@clientName(AppServiceCertificateOrderPatchResourceProperties.autoRenew,
  "IsAutoRenew",
  "csharp"
);
@@clientName(AppServiceCertificateOrderPatchResourceProperties.lastCertificateIssuanceTime,
  "LastCertificateIssuedOn",
  "csharp"
);
@@clientName(ProvisioningState,
  "CertificateRegistrationProvisioningState",
  "csharp"
);
@@clientName(KeyVaultSecretStatus, "AppServiceVaultSecretStatus", "csharp");
@@clientName(CertificateDetails, "AppServiceCertificateDetails", "csharp");
@@clientName(CertificateEmail, "AppServiceCertificateEmail", "csharp");
@@clientName(CertificateEmail.timeStamp, "SentOn", "csharp");
@@clientName(DataTableResponseColumn, "DiagnosticDataTableColumn", "csharp");
@@clientName(DataTableResponseObject, "DiagnosticDataTableObject", "csharp");
@@clientName(DetectorInfo, "AppServiceDetectorInfo", "csharp");
@@clientName(DetectorType, "AppServiceDetectorType", "csharp");
@@clientName(InsightStatus, "DetectorInsightStatus", "csharp");
@@clientName(KeyValuePairStringObject, "DataProviderKeyValuePair", "csharp");
@@clientName(NameIdentifier, "AppServiceDomainNameIdentifier", "csharp");
@@clientName(Rendering, "DiagnosticDataRendering", "csharp");
@@clientName(RenderingType, "DiagnosticDataRenderingType", "csharp");
@@clientName(ResourceNotRenewableReason,
  "AppServiceCertificateNotRenewableReason",
  "csharp"
);
@@clientName(Status, "DetectorStatusInfo", "csharp");
@@clientName(SupportTopic, "DetectorSupportTopic", "csharp");
@@alternateType(SupportTopic.pesId, armResourceIdentifier, "csharp");
@@clientName(GetAppServiceCertificateOrderDetectorParameters.startTime,
  "StartOn",
  "csharp"
);
@@clientName(GetAppServiceCertificateOrderDetectorParameters.endTime,
  "EndOn",
  "csharp"
);
@@clientName(CertificateOrderStatus.Pendingissuance,
  "PendingIssuance",
  "csharp"
);
@@clientName(CertificateOrderStatus.Pendingrevocation,
  "PendingRevocation",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(AppServiceCertificateOrderPatchResource,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(AppServiceCertificatePatchResource,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ReissueCertificateOrderRequest,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(RenewCertificateOrderRequest,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
