import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NginxDeployment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Nginx;

@parentResource(NginxDeployment)
model NginxCertificate is TrackedResource<NginxCertificateProperties> {
  @doc("The name of certificate")
  @path
  @key("certificateName")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface NginxCertificates {
  @doc("Get a certificate of given Nginx deployment")
  get is ArmResourceRead<NginxCertificate>;
  @doc("Create or update the Nginx certificates for given Nginx deployment")
  create is ArmResourceCreateOrUpdateAsync<NginxCertificate>;
  @doc("Deletes a certificate from the nginx deployment")
  delete is ArmResourceDeleteAsync<NginxCertificate>;
  @doc("List all certificates of given Nginx deployment")
  list is ArmResourceListByParent<NginxCertificate>;
}
