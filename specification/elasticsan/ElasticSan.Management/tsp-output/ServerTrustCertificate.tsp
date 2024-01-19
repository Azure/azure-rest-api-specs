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
@doc("Server trust certificate imported from box to enable connection between box and Sql Managed Instance.")
@parentResource(ManagedInstance)
model ServerTrustCertificate
  is ProxyResource<ServerTrustCertificateProperties> {
  @doc("Name of of the certificate to get.")
  @path
  @key("certificateName")
  @segment("serverTrustCertificates")
  name: string;
}

@armResourceOperations
interface ServerTrustCertificates {
  @doc("Gets a server trust certificate that was uploaded from box to Sql Managed Instance.")
  get is ArmResourceRead<ServerTrustCertificate>;

  @doc("Uploads a server trust certificate from box to Sql Managed Instance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServerTrustCertificate>;

  @doc("Deletes a server trust certificate that was uploaded from box to Sql Managed Instance.")
  delete is ArmResourceDeleteAsync<ServerTrustCertificate>;

  @doc("Gets a list of server trust certificates that were uploaded from box to the given Sql Managed Instance.")
  listByInstance is ArmResourceListByParent<ServerTrustCertificate>;
}

@@projectedName(ServerTrustCertificates.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerTrustCertificates.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerTrustCertificates.createOrUpdate::parameters.resource,
  "The server trust certificate info."
);
