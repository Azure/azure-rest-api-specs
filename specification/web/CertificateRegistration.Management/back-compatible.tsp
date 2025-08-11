import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.CertificateRegistration;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AppServiceCertificateOrderPatchResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AppServiceCertificatePatchResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ReissueCertificateOrderRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RenewCertificateOrderRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AppServiceCertificateOrder.properties);

@@clientLocation(AppServiceCertificateResources.getCertificate,
  "AppServiceCertificateOrders"
);
@@clientLocation(AppServiceCertificateResources.createOrUpdateCertificate,
  "AppServiceCertificateOrders"
);
@@clientName(AppServiceCertificateResources.createOrUpdateCertificate::parameters.resource,
  "keyVaultCertificate"
);
@@clientLocation(AppServiceCertificateResources.updateCertificate,
  "AppServiceCertificateOrders"
);
@@clientName(AppServiceCertificateResources.updateCertificate::parameters.properties,
  "keyVaultCertificate"
);
@@clientLocation(AppServiceCertificateResources.deleteCertificate,
  "AppServiceCertificateOrders"
);
@@clientLocation(AppServiceCertificateResources.listCertificates,
  "AppServiceCertificateOrders"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AppServiceCertificateResource.properties);

@@clientLocation(DetectorResponses.getAppServiceCertificateOrderDetectorResponse,
  "CertificateOrdersDiagnostics"
);
@@clientLocation(DetectorResponses.listAppServiceCertificateOrderDetectorResponse,
  "CertificateOrdersDiagnostics"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DetectorResponse.properties);

@@clientLocation(AppServiceCertificateOrdersOperationGroup.validatePurchaseInformation,
  "AppServiceCertificateOrders"
);
