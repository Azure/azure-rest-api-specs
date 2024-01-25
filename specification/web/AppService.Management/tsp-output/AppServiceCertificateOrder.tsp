import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * SSL certificate purchase order.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
model AppServiceCertificateOrder extends Resource {
  /**
   * Name of the certificate order..
   */
  @path
  @key("certificateOrderName")
  @segment("certificateOrders")
  @visibility("read")
  name: string;

  /**
   * AppServiceCertificateOrder resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: AppServiceCertificateOrderProperties;
}

@armResourceOperations
interface AppServiceCertificateOrders {
  /**
   * Description for Get a certificate order.
   */
  get is ArmResourceRead<AppServiceCertificateOrder>;

  /**
   * Description for Create or update a certificate purchase order.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AppServiceCertificateOrder>;

  /**
   * Description for Create or update a certificate purchase order.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    AppServiceCertificateOrder,
    AppServiceCertificateOrderPatchResource
  >;

  /**
   * Description for Delete an existing certificate order.
   */
  delete is ArmResourceDeleteSync<AppServiceCertificateOrder>;

  /**
   * Description for Get certificate orders in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceCertificateOrders_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AppServiceCertificateOrder>;

  /**
   * Description for List all certificate orders in a subscription.
   */
  list is ArmListBySubscription<AppServiceCertificateOrder>;

  /**
   * Description for Reissue an existing certificate order.
   */
  reissue is ArmResourceActionNoContentSync<
    AppServiceCertificateOrder,
    ReissueCertificateOrderRequest
  >;

  /**
   * Description for Renew an existing certificate order.
   */
  renew is ArmResourceActionNoContentSync<
    AppServiceCertificateOrder,
    RenewCertificateOrderRequest
  >;

  /**
   * Description for Resend certificate email.
   */
  resendEmail is ArmResourceActionNoContentSync<
    AppServiceCertificateOrder,
    void
  >;

  /**
   * Resend domain verification ownership email containing steps on how to verify a domain for a given certificate order
   */
  resendRequestEmails is ArmResourceActionNoContentSync<
    AppServiceCertificateOrder,
    NameIdentifier
  >;

  /**
   * This method is used to obtain the site seal information for an issued certificate. A site seal is a graphic that the certificate purchaser can embed on their web site to show their visitors information about their SSL certificate. If a web site visitor clicks on the site seal image, a pop-up page is displayed that contains detailed information about the SSL certificate. The site seal token is used to link the site seal graphic image to the appropriate certificate details pop-up page display when a user clicks on the site seal. The site seal images are expected to be static images and hosted by the reseller, to minimize delays for customer page load times.
   */
  retrieveSiteSeal is ArmResourceActionSync<
    AppServiceCertificateOrder,
    SiteSealRequest,
    SiteSeal
  >;

  /**
   * Description for Verify domain ownership for this certificate order.
   */
  verifyDomainOwnership is ArmResourceActionNoContentSync<
    AppServiceCertificateOrder,
    void
  >;

  /**
   * Description for Retrieve the list of certificate actions.
   */
  retrieveCertificateActions is ArmResourceActionSync<
    AppServiceCertificateOrder,
    void,
    void,
    {
      ...BaseParameters<AppServiceCertificateOrder>;

      /**
       * Name of the certificate order.
       */
      @path
      name: string;
    }
  >;

  /**
   * Description for Retrieve email history.
   */
  retrieveCertificateEmailHistory is ArmResourceActionSync<
    AppServiceCertificateOrder,
    void,
    void,
    {
      ...BaseParameters<AppServiceCertificateOrder>;

      /**
       * Name of the certificate order.
       */
      @path
      name: string;
    }
  >;
}

@@projectedName(AppServiceCertificateOrders.createOrUpdate::parameters.resource,
  "json",
  "certificateDistinguishedName"
);
@@extension(AppServiceCertificateOrders.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "certificateDistinguishedName"
);
@@doc(AppServiceCertificateOrders.createOrUpdate::parameters.resource,
  "Distinguished name to use for the certificate order."
);
@@projectedName(AppServiceCertificateOrders.update::parameters.properties,
  "json",
  "certificateDistinguishedName"
);
@@extension(AppServiceCertificateOrders.update::parameters.properties,
  "x-ms-client-name",
  "certificateDistinguishedName"
);
@@doc(AppServiceCertificateOrders.update::parameters.properties,
  "Distinguished name to use for the certificate order."
);
@@projectedName(AppServiceCertificateOrders.reissue::parameters.body,
  "json",
  "reissueCertificateOrderRequest"
);
@@extension(AppServiceCertificateOrders.reissue::parameters.body,
  "x-ms-client-name",
  "reissueCertificateOrderRequest"
);
@@doc(AppServiceCertificateOrders.reissue::parameters.body,
  "Parameters for the reissue."
);
@@projectedName(AppServiceCertificateOrders.renew::parameters.body,
  "json",
  "renewCertificateOrderRequest"
);
@@extension(AppServiceCertificateOrders.renew::parameters.body,
  "x-ms-client-name",
  "renewCertificateOrderRequest"
);
@@doc(AppServiceCertificateOrders.renew::parameters.body, "Renew parameters");
@@projectedName(AppServiceCertificateOrders.resendRequestEmails::parameters.body,
  "json",
  "nameIdentifier"
);
@@extension(AppServiceCertificateOrders.resendRequestEmails::parameters.body,
  "x-ms-client-name",
  "nameIdentifier"
);
@@doc(AppServiceCertificateOrders.resendRequestEmails::parameters.body,
  "Email address"
);
@@projectedName(AppServiceCertificateOrders.retrieveSiteSeal::parameters.body,
  "json",
  "siteSealRequest"
);
@@extension(AppServiceCertificateOrders.retrieveSiteSeal::parameters.body,
  "x-ms-client-name",
  "siteSealRequest"
);
@@doc(AppServiceCertificateOrders.retrieveSiteSeal::parameters.body,
  "Site seal request."
);
