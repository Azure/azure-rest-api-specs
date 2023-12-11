import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SignalR.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SignalR;
@doc("A custom certificate.")
@parentResource(SignalR)
model SignalRCustomCertificate is ProxyResource<CustomCertificateProperties> {
  @doc("Custom certificate name")
  @path
  @key("certificateName")
  @segment("customCertificates")
  name: string;
}

@armResourceOperations
interface SignalRCustomCertificates {
  @doc("Get a custom certificate.")
  get is ArmResourceRead<SignalRCustomCertificate>;
  @doc("Create or update a custom certificate.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SignalRCustomCertificate>;
  @doc("Delete a custom certificate.")
  delete is ArmResourceDeleteSync<SignalRCustomCertificate>;
  @doc("List all custom certificates.")
  list is ArmResourceListByParent<SignalRCustomCertificate>;
}
