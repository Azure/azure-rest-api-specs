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
model AppServiceCertificate is TrackedResource<AppServiceCertificate> {
  @doc("Name of the certificate.")
  @path
  @key("name")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface AppServiceCertificates {
  @doc("Description for Get the certificate associated with a certificate order.")
  getCertificate is ArmResourceRead<AppServiceCertificate>;
  @doc("Description for Creates or updates a certificate and associates with key vault secret.")
  createOrUpdateCertificate is ArmResourceCreateOrUpdateAsync<AppServiceCertificate>;
  @doc("Description for Creates or updates a certificate and associates with key vault secret.")
  updateCertificate is ArmResourcePatchSync<
    AppServiceCertificate,
    AppServiceCertificate
  >;
  @doc("Description for Delete the certificate associated with a certificate order.")
  deleteCertificate is ArmResourceDeleteSync<AppServiceCertificate>;
  @doc("Description for List all certificates associated with a certificate order.")
  listCertificates is ArmResourceListByParent<AppServiceCertificate>;
}
