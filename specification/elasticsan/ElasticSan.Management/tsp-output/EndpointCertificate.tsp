import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("Certificate used on an endpoint on the Managed Instance.")
@parentResource(ManagedInstance)
model EndpointCertificate is ProxyResource<EndpointCertificateProperties> {
  @doc("Type of the endpoint whose certificate the customer is looking for.")
  @path
  @key("endpointType")
  @segment("endpointCertificates")
  name: string;
}

@armResourceOperations
interface EndpointCertificates {
  @doc("Gets a certificate used on the endpoint with the given id.")
  get is ArmResourceRead<EndpointCertificate>;

  @doc("List certificates used on endpoints on the target instance.")
  listByInstance is ArmResourceListByParent<EndpointCertificate>;
}
