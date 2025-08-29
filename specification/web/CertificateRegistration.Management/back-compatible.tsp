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

@@clientLocation(CertificateOrdersDiagnostics.getAppServiceCertificateOrderDetectorResponse,
  "CertificateOrdersDiagnostics"
);
@@clientLocation(CertificateOrdersDiagnostics.listAppServiceCertificateOrderDetectorResponse,
  "CertificateOrdersDiagnostics"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DetectorResponse.properties);

@@clientLocation(AppServiceCertificateOrdersOperationGroup.validatePurchaseInformation,
  "AppServiceCertificateOrders"
);
@@clientLocation(Operations.list, "CertificateRegistrationProvider");
@@clientName(Operations.list, "ListOperations");
@@clientName(AppServiceCertificateOrdersOperationGroup.validatePurchaseInformation::parameters.body,
  "appServiceCertificateOrder"
);
@@summary(AppServiceCertificateOrders.list,
  "List all certificate orders in a subscription."
);
@@summary(AppServiceCertificateOrders.listByResourceGroup,
  "Get certificate orders in a resource group."
);
@@summary(AppServiceCertificateOrders.get, "Get a certificate order.");
@@summary(AppServiceCertificateOrders.createOrUpdate,
  "Create or update a certificate purchase order."
);
@@summary(AppServiceCertificateOrders.delete,
  "Delete an existing certificate order."
);
@@summary(AppServiceCertificateOrders.update,
  "Create or update a certificate purchase order."
);
@@summary(AppServiceCertificateResources.deleteCertificate,
  "Delete the certificate associated with a certificate order."
);
@@summary(AppServiceCertificateOrders.reissue,
  "Reissue an existing certificate order."
);
@@summary(AppServiceCertificateOrders.renew,
  "Renew an existing certificate order."
);
@@summary(AppServiceCertificateOrders.resendEmail, "Resend certificate email.");
@@summary(AppServiceCertificateOrders.resendRequestEmails,
  "Resend domain verification email to customer for this certificate order"
);
@@summary(AppServiceCertificateOrders.retrieveCertificateActions,
  "Retrieve the list of certificate actions."
);
@@summary(AppServiceCertificateOrders.retrieveCertificateEmailHistory,
  "Retrieve email history."
);
@@summary(AppServiceCertificateOrders.retrieveSiteSeal,
  "This method is used to obtain the site seal information for an issued certificate. "
);
@@summary(AppServiceCertificateOrders.verifyDomainOwnership,
  "Verify domain ownership for this certificate order."
);
@@summary(AppServiceCertificateResources.listCertificates,
  "List all certificates associated with a certificate order."
);
@@summary(AppServiceCertificateResources.getCertificate,
  "Get the certificate associated with a certificate order."
);
@@summary(AppServiceCertificateResources.createOrUpdateCertificate,
  "Creates or updates a certificate and associates with key vault secret."
);
@@summary(AppServiceCertificateResources.updateCertificate,
  "Creates or updates a certificate and associates with key vault secret."
);
@@summary(CertificateOrdersDiagnostics.listAppServiceCertificateOrderDetectorResponse,
  "Microsoft.CertificateRegistration to get the list of detectors for this RP."
);
@@summary(CertificateOrdersDiagnostics.getAppServiceCertificateOrderDetectorResponse,
  "Microsoft.CertificateRegistration call to get a detector response from App Lens."
);
@@doc(AppServiceCertificateOrder.properties, "App Service error response.");

@@errorsDoc(AppServiceCertificateOrders.list, "App Service error response.");
@@errorsDoc(AppServiceCertificateOrders.verifyDomainOwnership,
  "App Service error response."
);
@@errorsDoc(AppServiceCertificateOrders.listByResourceGroup,
  "App Service error response."
);
@@errorsDoc(AppServiceCertificateOrders.get, "App Service error response.");
@@errorsDoc(AppServiceCertificateOrders.update, "App Service error response.");
@@errorsDoc(AppServiceCertificateOrders.delete, "App Service error response.");
@@errorsDoc(AppServiceCertificateOrders.retrieveCertificateActions,
  "App Service error response."
);
@@errorsDoc(AppServiceCertificateOrders.retrieveCertificateEmailHistory,
  "App Service error response."
);
@@errorsDoc(AppServiceCertificateResources.listCertificates,
  "App Service error response."
);
@@errorsDoc(AppServiceCertificateResources.getCertificate,
  "App Service error response."
);
@@errorsDoc(AppServiceCertificateResources.createOrUpdateCertificate,
  "App Service error response."
);
@@errorsDoc(AppServiceCertificateResources.updateCertificate,
  "App Service error response."
);
@@errorsDoc(AppServiceCertificateResources.deleteCertificate,
  "App Service error response."
);
@@errorsDoc(CertificateOrdersDiagnostics.listAppServiceCertificateOrderDetectorResponse,
  "App Service error response."
);
@@errorsDoc(CertificateOrdersDiagnostics.getAppServiceCertificateOrderDetectorResponse,
  "App Service error response."
);
@@errorsDoc(AppServiceCertificateOrders.reissue, "App Service error response.");
@@errorsDoc(AppServiceCertificateOrders.renew, "App Service error response.");
@@errorsDoc(AppServiceCertificateOrders.resendEmail,
  "App Service error response."
);
@@errorsDoc(AppServiceCertificateOrders.resendRequestEmails,
  "App Service error response."
);
@@errorsDoc(AppServiceCertificateOrders.retrieveSiteSeal,
  "App Service error response."
);
@@errorsDoc(AppServiceCertificateOrders.verifyDomainOwnership,
  "App Service error response."
);
@@errorsDoc(AppServiceCertificateOrders.createOrUpdate,
  "App Service error response."
);
