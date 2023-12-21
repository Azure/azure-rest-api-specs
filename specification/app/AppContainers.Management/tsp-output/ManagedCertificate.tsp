import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppContainers;
@doc("Managed certificates used for Custom Domain bindings of Container Apps in a Managed Environment")
model ManagedCertificate is TrackedResource<ManagedCertificateProperties> {
  @doc("Name of the Managed Certificate.")
  @path
  @key("managedCertificateName")
  @segment("managedCertificates")
  name: string;
}

@armResourceOperations
interface ManagedCertificates {
  @doc("Get the specified Managed Certificate.")
  get is ArmResourceRead<ManagedCertificate>;
  @doc("Create or Update a Managed Certificate.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedCertificate>;
  @doc("Patches a managed certificate. Oly patching of tags is supported")
  update is ArmTagsPatchSync<ManagedCertificate>;
  @doc("Deletes the specified Managed Certificate.")
  delete is ArmResourceDeleteSync<ManagedCertificate>;
  @doc("Get the Managed Certificates in a given managed environment.")
  list is ArmResourceListByParent<ManagedCertificate>;
}
