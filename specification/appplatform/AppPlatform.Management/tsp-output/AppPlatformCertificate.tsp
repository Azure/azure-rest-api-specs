import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Certificate resource payload.")
@parentResource(AppPlatformService)
model AppPlatformCertificate is ProxyResource<CertificateProperties> {
  @doc("The name of the certificate resource.")
  @path
  @key("certificateName")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface AppPlatformCertificates {
  @doc("Get the certificate resource.")
  get is ArmResourceRead<AppPlatformCertificate>;
  @doc("Create or update certificate resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppPlatformCertificate>;
  @doc("Delete the certificate resource.")
  delete is ArmResourceDeleteAsync<AppPlatformCertificate>;
  @doc("List all the certificates of one user.")
  list is ArmResourceListByParent<AppPlatformCertificate>;
}
