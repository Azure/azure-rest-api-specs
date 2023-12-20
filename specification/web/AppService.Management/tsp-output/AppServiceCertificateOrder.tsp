import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("SSL certificate purchase order.")
model AppServiceCertificateOrder
  is TrackedResource<AppServiceCertificateOrderProperties> {
  @doc("Name of the certificate order..")
  @path
  @key("certificateOrderName")
  @segment("certificateOrders")
  name: string;
}

@armResourceOperations
interface AppServiceCertificateOrders {
  @doc("Description for Get a certificate order.")
  get is ArmResourceRead<AppServiceCertificateOrder>;
  @doc("Description for Create or update a certificate purchase order.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppServiceCertificateOrder>;
  @doc("Description for Create or update a certificate purchase order.")
  update is ArmResourcePatchSync<
    AppServiceCertificateOrder,
    AppServiceCertificateOrderProperties
  >;
  @doc("Description for Delete an existing certificate order.")
  delete is ArmResourceDeleteSync<AppServiceCertificateOrder>;
  @doc("Description for Get certificate orders in a resource group.")
  listByResourceGroup is ArmResourceListByParent<AppServiceCertificateOrder>;
  @doc("Description for List all certificate orders in a subscription.")
  list is ArmListBySubscription<AppServiceCertificateOrder>;
  @doc("Description for Reissue an existing certificate order.")
  reissue is ArmResourceActionNoContentSync<
    AppServiceCertificateOrder,
    ReissueCertificateOrderRequest
  >;
  @doc("Description for Renew an existing certificate order.")
  renew is ArmResourceActionNoContentSync<
    AppServiceCertificateOrder,
    RenewCertificateOrderRequest
  >;
  @doc("Description for Resend certificate email.")
  resendEmail is ArmResourceActionNoContentSync<
    AppServiceCertificateOrder,
    void
  >;
  @doc("Resend domain verification ownership email containing steps on how to verify a domain for a given certificate order")
  resendRequestEmails is ArmResourceActionNoContentSync<
    AppServiceCertificateOrder,
    NameIdentifier
  >;
  @doc("This method is used to obtain the site seal information for an issued certificate. A site seal is a graphic that the certificate purchaser can embed on their web site to show their visitors information about their SSL certificate. If a web site visitor clicks on the site seal image, a pop-up page is displayed that contains detailed information about the SSL certificate. The site seal token is used to link the site seal graphic image to the appropriate certificate details pop-up page display when a user clicks on the site seal. The site seal images are expected to be static images and hosted by the reseller, to minimize delays for customer page load times.")
  retrieveSiteSeal is ArmResourceActionSync<
    AppServiceCertificateOrder,
    SiteSealRequest,
    SiteSeal
  >;
  @doc("Description for Verify domain ownership for this certificate order.")
  verifyDomainOwnership is ArmResourceActionNoContentSync<
    AppServiceCertificateOrder,
    void
  >;
  @doc("Description for Retrieve the list of certificate actions.")
  retrieveCertificateActions is ArmResourceActionSync<
    AppServiceCertificateOrder,
    void,
    void,
    {
      ...BaseParameters<AppServiceCertificateOrder>;

      @doc("Name of the certificate order.")
      @path
      name: string;
    }
  >;
  @doc("Description for Retrieve email history.")
  retrieveCertificateEmailHistory is ArmResourceActionSync<
    AppServiceCertificateOrder,
    void,
    void,
    {
      ...BaseParameters<AppServiceCertificateOrder>;

      @doc("Name of the certificate order.")
      @path
      name: string;
    }
  >;
}
