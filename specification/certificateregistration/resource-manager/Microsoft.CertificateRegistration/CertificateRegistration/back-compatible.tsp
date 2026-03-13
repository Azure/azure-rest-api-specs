import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.CertificateRegistration;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AppServiceCertificateOrderPatchResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AppServiceCertificatePatchResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ReissueCertificateOrderRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RenewCertificateOrderRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SiteSeal.html);
@@clientName(AppServiceCertificateOrders.createOrUpdate::parameters.resource,
  "certificateDistinguishedName"
);
@@clientName(AppServiceCertificateOrders.update::parameters.properties,
  "certificateDistinguishedName"
);
@@clientName(AppServiceCertificateOrders.reissue::parameters.body,
  "reissueCertificateOrderRequest"
);
@@clientName(AppServiceCertificateOrders.renew::parameters.body,
  "renewCertificateOrderRequest"
);
@@clientName(AppServiceCertificateOrders.resendRequestEmails::parameters.body,
  "nameIdentifier"
);
@@clientName(AppServiceCertificateOrders.retrieveSiteSeal::parameters.body,
  "siteSealRequest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AppServiceCertificateOrder.properties);

@@clientLocation(AppServiceCertificateResources.getCertificate,
  AppServiceCertificateOrders,
  "!csharp"
);
@@clientLocation(AppServiceCertificateResources.createOrUpdateCertificate,
  AppServiceCertificateOrders,
  "!csharp"
);
@@clientName(AppServiceCertificateResources.createOrUpdateCertificate::parameters.resource,
  "keyVaultCertificate"
);
@@clientLocation(AppServiceCertificateResources.updateCertificate,
  AppServiceCertificateOrders,
  "!csharp"
);
@@clientName(AppServiceCertificateResources.updateCertificate::parameters.properties,
  "keyVaultCertificate"
);
@@clientLocation(AppServiceCertificateResources.deleteCertificate,
  AppServiceCertificateOrders,
  "!csharp"
);
@@clientLocation(AppServiceCertificateResources.listCertificates,
  AppServiceCertificateOrders,
  "!csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AppServiceCertificateResource.properties);
@@clientLocation(CertificateOrdersDiagnostics.getAppServiceCertificateOrderDetectorResponse,
  CertificateOrdersDiagnostics,
  "!csharp"
);
@@clientLocation(CertificateOrdersDiagnostics.listAppServiceCertificateOrderDetectorResponse,
  CertificateOrdersDiagnostics,
  "!csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DetectorResponse.properties);
@@clientLocation(AppServiceCertificateOrdersOperationGroup.validatePurchaseInformation,
  AppServiceCertificateOrders,
  "!csharp"
);
@@clientLocation(Operations.list, "CertificateRegistrationProvider", "!csharp");
@@clientName(Operations.list, "ListOperations");
@@clientName(AppServiceCertificateOrdersOperationGroup.validatePurchaseInformation::parameters.body,
  "appServiceCertificateOrder"
);
