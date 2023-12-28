import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Public certificate object")
@parentResource(Site)
model PublicCertificate is ProxyResource<PublicCertificateProperties> {
  @doc("Public certificate name.")
  @key("publicCertificateName")
  @segment("publicCertificates")
  name: string;
}

@armResourceOperations
interface WebApps {
  @doc("Description for Get the named public certificate for an app (or deployment slot, if specified).")
  getPublicCertificate is ArmResourceRead<PublicCertificate>;
  @doc("Description for Creates a hostname binding for an app.")
  createOrUpdatePublicCertificate is ArmResourceCreateOrReplaceSync<PublicCertificate>;
  @doc("Description for Deletes a hostname binding for an app.")
  deletePublicCertificate is ArmResourceDeleteSync<PublicCertificate>;
  @doc("Description for Get public certificates for an app or a deployment slot.")
  listPublicCertificates is ArmResourceListByParent<PublicCertificate>;
}
