import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ConnectedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.App;
@doc("Certificate used for Custom Domain bindings of Container Apps in a Managed Environment")
@parentResource(ConnectedEnvironment)
model Certificate is TrackedResource<CertificateProperties> {
  @doc("Name of the Certificate.")
  @key("certificateName")
  @segment("certificates")
  name: string;
}

@armResourceOperations
@projectedName("client", "ConnectedEnvironmentsCertificates")
interface Certificates_ConnectedEnvironmentsCertificates {
  @doc("Get the specified Certificate.")
  get is ArmResourceRead<Certificate>;

  @doc("Create or Update a Certificate.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Certificate>;

  @doc("Patches a certificate. Currently only patching of tags is supported")
  update is ArmCustomPatchSync<Certificate, CertificatePatch>;

  @doc("Deletes the specified Certificate.")
  delete is ArmResourceDeleteSync<Certificate>;

  @doc("Get the Certificates in a given connected environment.")
  list is ArmResourceListByParent<Certificate>;
}
