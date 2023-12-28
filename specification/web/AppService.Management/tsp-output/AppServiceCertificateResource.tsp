import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceCertificateOrder.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Key Vault container ARM resource for a certificate that is purchased through Azure.")
@parentResource(AppServiceCertificateOrder)
model AppServiceCertificateResource is TrackedResource<AppServiceCertificate> {
  @doc("Name of the certificate.")
  @key("name")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface AppServiceCertificateOrders {
  @doc("Description for Get the certificate associated with a certificate order.")
  getCertificate is ArmResourceRead<AppServiceCertificateResource>;
  @doc("Description for Creates or updates a certificate and associates with key vault secret.")
  createOrUpdateCertificate is ArmResourceCreateOrUpdateAsync<AppServiceCertificateResource>;
  @doc("Description for Creates or updates a certificate and associates with key vault secret.")
  updateCertificate is ArmCustomPatchSync<
    AppServiceCertificateResource,
    AppServiceCertificatePatchResource
  >;
  @doc("Description for Delete the certificate associated with a certificate order.")
  deleteCertificate is ArmResourceDeleteSync<AppServiceCertificateResource>;
  @doc("Description for List all certificates associated with a certificate order.")
  listCertificates is ArmResourceListByParent<AppServiceCertificateResource>;
}
