import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * SSL certificate purchase order.
 */
model AppServiceCertificateOrder
  is Azure.ResourceManager.TrackedResource<AppServiceCertificateOrderProperties> {
  ...ResourceNameParameter<
    Resource = AppServiceCertificateOrder,
    KeyName = "certificateOrderName",
    SegmentName = "certificateOrders",
    NamePattern = ""
  >;

  /**
   * Kind of resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface AppServiceCertificateOrders {
  /**
   * Description for Get a certificate order.
   */
  get is ArmResourceRead<
    AppServiceCertificateOrder,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a certificate purchase order.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AppServiceCertificateOrder,
    Response = ArmResponse<AppServiceCertificateOrder> | ArmResourceCreatedResponse<
      AppServiceCertificateOrder,
      LroHeaders = ArmLroLocationHeader<FinalResult = AppServiceCertificateOrder>
    >,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a certificate purchase order.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AppServiceCertificateOrder,
    PatchModel = AppServiceCertificateOrderPatchResource,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Delete an existing certificate order.
   */
  delete is ArmResourceDeleteSync<
    AppServiceCertificateOrder,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get certificate orders in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    AppServiceCertificateOrder,
    Response = ArmResponse<AppServiceCertificateOrderCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for List all certificate orders in a subscription.
   */
  list is ArmListBySubscription<
    AppServiceCertificateOrder,
    Response = ArmResponse<AppServiceCertificateOrderCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Reissue an existing certificate order.
   */
  reissue is ArmResourceActionSync<
    AppServiceCertificateOrder,
    ReissueCertificateOrderRequest,
    NoContentResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Renew an existing certificate order.
   */
  renew is ArmResourceActionSync<
    AppServiceCertificateOrder,
    RenewCertificateOrderRequest,
    NoContentResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Resend certificate email.
   */
  resendEmail is ArmResourceActionSync<
    AppServiceCertificateOrder,
    void,
    NoContentResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Resend domain verification ownership email containing steps on how to verify a domain for a given certificate order
   */
  resendRequestEmails is ArmResourceActionSync<
    AppServiceCertificateOrder,
    NameIdentifier,
    NoContentResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * This method is used to obtain the site seal information for an issued certificate. A site seal is a graphic that the certificate purchaser can embed on their web site to show their visitors information about their SSL certificate. If a web site visitor clicks on the site seal image, a pop-up page is displayed that contains detailed information about the SSL certificate. The site seal token is used to link the site seal graphic image to the appropriate certificate details pop-up page display when a user clicks on the site seal. The site seal images are expected to be static images and hosted by the reseller, to minimize delays for customer page load times.
   */
  retrieveSiteSeal is ArmResourceActionSync<
    AppServiceCertificateOrder,
    SiteSealRequest,
    ArmResponse<SiteSeal>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Verify domain ownership for this certificate order.
   */
  verifyDomainOwnership is ArmResourceActionSync<
    AppServiceCertificateOrder,
    void,
    NoContentResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Retrieve the list of certificate actions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Legacy.renamePathParameter(
    "certificateOrderName",
    "name"
  )
  retrieveCertificateActions is ArmResourceActionSync<
    AppServiceCertificateOrder,
    void,
    ArmResponse<CertificateOrderAction[]>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Retrieve email history.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Legacy.renamePathParameter(
    "certificateOrderName",
    "name"
  )
  @action("retrieveEmailHistory")
  retrieveCertificateEmailHistory is ArmResourceActionSync<
    AppServiceCertificateOrder,
    void,
    ArmResponse<CertificateEmail[]>,
    Error = DefaultErrorResponse
  >;
}

@@doc(AppServiceCertificateOrder.name, "Name of the certificate order..");
@@doc(AppServiceCertificateOrder.properties,
  "AppServiceCertificateOrder resource specific properties"
);
@@doc(AppServiceCertificateOrders.createOrUpdate::parameters.resource,
  "Distinguished name to use for the certificate order."
);
@@doc(AppServiceCertificateOrders.update::parameters.properties,
  "Distinguished name to use for the certificate order."
);
@@doc(AppServiceCertificateOrders.reissue::parameters.body,
  "Parameters for the reissue."
);
@@doc(AppServiceCertificateOrders.renew::parameters.body, "Renew parameters");
@@doc(AppServiceCertificateOrders.resendRequestEmails::parameters.body,
  "Email address"
);
@@doc(AppServiceCertificateOrders.retrieveSiteSeal::parameters.body,
  "Site seal request."
);
@@doc(AppServiceCertificateOrder.properties,
  "AppServiceCertificateOrder resource specific properties"
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
