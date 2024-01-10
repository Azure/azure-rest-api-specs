import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AppPlatform;
@doc("Certificate resource payload.")
@parentResource(ServiceResource)
model CertificateResource is ProxyResource<CertificateProperties> {
  @doc("The name of the certificate resource.")
  @key("certificateName")
  @segment("certificates")
  name: string;
}

@armResourceOperations
@projectedName("client", "Certificates")
interface CertificateResources_Certificates {
  @doc("Get the certificate resource.")
  get is ArmResourceRead<CertificateResource>;

  @doc("Create or update certificate resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CertificateResource>;

  @doc("Delete the certificate resource.")
  delete is ArmResourceDeleteAsync<CertificateResource>;

  @doc("List all the certificates of one user.")
  list is ArmResourceListByParent<CertificateResource>;
}
