import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("SSL certificate for an app.")
model Certificate is TrackedResource<CertificateProperties> {
  @doc("Name of the certificate.")
  @path
  @key("name")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface Certificates {
  @doc("Description for Get a certificate.")
  get is ArmResourceRead<Certificate>;
  @doc("Description for Create or update a certificate.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Certificate>;
  @doc("Description for Create or update a certificate.")
  update is ArmResourcePatchSync<Certificate, CertificateProperties>;
  @doc("Description for Delete a certificate.")
  delete is ArmResourceDeleteSync<Certificate>;
  @doc("Description for Get all certificates in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Certificate>;
  @doc("Description for Get all certificates for a subscription.")
  list is ArmListBySubscription<Certificate>;
}
