import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SignalRResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SignalR;
@doc("A custom certificate.")
@parentResource(SignalRResource)
model CustomCertificate is ProxyResource<CustomCertificateProperties> {
  @doc("Custom certificate name")
  @path
  @key("certificateName")
  @segment("customCertificates")
  name: string;
}

@armResourceOperations
interface SignalRCustomCertificates {
  @doc("Get a custom certificate.")
  get is ArmResourceRead<CustomCertificate>;
  @doc("Create or update a custom certificate.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CustomCertificate>;
  @doc("Delete a custom certificate.")
  delete is ArmResourceDeleteSync<CustomCertificate>;
  @doc("List all custom certificates.")
  list is ArmResourceListByParent<CustomCertificate>;
}
