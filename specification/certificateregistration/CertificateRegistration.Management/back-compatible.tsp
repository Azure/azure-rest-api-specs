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
  AppServiceCertificateOrders
);
@@clientLocation(AppServiceCertificateResources.createOrUpdateCertificate,
  AppServiceCertificateOrders
);
@@clientName(AppServiceCertificateResources.createOrUpdateCertificate::parameters.resource,
  "keyVaultCertificate"
);
@@clientLocation(AppServiceCertificateResources.updateCertificate,
  AppServiceCertificateOrders
);
@@clientName(AppServiceCertificateResources.updateCertificate::parameters.properties,
  "keyVaultCertificate"
);
@@clientLocation(AppServiceCertificateResources.deleteCertificate,
  AppServiceCertificateOrders
);
@@clientLocation(AppServiceCertificateResources.listCertificates,
  AppServiceCertificateOrders
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AppServiceCertificateResource.properties);

@@clientLocation(CertificateOrdersDiagnostics.getAppServiceCertificateOrderDetectorResponse,
  CertificateOrdersDiagnostics
);
@@clientLocation(CertificateOrdersDiagnostics.listAppServiceCertificateOrderDetectorResponse,
  CertificateOrdersDiagnostics
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DetectorResponse.properties);

@@clientLocation(AppServiceCertificateOrdersOperationGroup.validatePurchaseInformation,
  AppServiceCertificateOrders
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
@@doc(AppServiceCertificateOrderCollection.value, "Collection of resources.");
@@doc(AppServiceCertificateOrderCollection.nextLink,
  "Link to next page of resources."
);
@@doc(Operations.list,
  "Description for Implements Csm operations Api to exposes the list of available Csm Apis under the resource provider"
);
@@summary(Operations.list, "Implements Csm operations Api to exposes the list of available Csm Apis under the resource provider");
