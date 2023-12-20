import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerAppConnectedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppContainers;
@doc("Certificate used for Custom Domain bindings of Container Apps in a Managed Environment")
@parentResource(ContainerAppConnectedEnvironment)
model ContainerAppConnectedEnvironmentCertificate
  is TrackedResource<CertificateProperties> {
  @doc("Name of the Certificate.")
  @path
  @key("certificateName")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface ContainerAppConnectedEnvironmentCertificates {
  @doc("Get the specified Certificate.")
  get is ArmResourceRead<ContainerAppConnectedEnvironmentCertificate>;
  @doc("Create or Update a Certificate.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ContainerAppConnectedEnvironmentCertificate>;
  @doc("Patches a certificate. Currently only patching of tags is supported")
  update is ArmTagsPatchSync<ContainerAppConnectedEnvironmentCertificate>;
  @doc("Deletes the specified Certificate.")
  delete is ArmResourceDeleteSync<ContainerAppConnectedEnvironmentCertificate>;
  @doc("Get the Certificates in a given connected environment.")
  list is ArmResourceListByParent<ContainerAppConnectedEnvironmentCertificate>;
}
