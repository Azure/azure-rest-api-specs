import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Public certificate object")
@parentResource(WebSite)
model SitePublicCertificate is ProxyResource<PublicCertificateProperties> {
  @doc("Public certificate name.")
  @path
  @key("publicCertificateName")
  @segment("publicCertificates")
  name: string;
}

@armResourceOperations
interface SitePublicCertificates {
  @doc("Description for Get the named public certificate for an app (or deployment slot, if specified).")
  getPublicCertificate is ArmResourceRead<SitePublicCertificate>;
  @doc("Description for Creates a hostname binding for an app.")
  createOrUpdatePublicCertificate is ArmResourceCreateOrReplaceSync<SitePublicCertificate>;
  @doc("Description for Deletes a hostname binding for an app.")
  deletePublicCertificate is ArmResourceDeleteSync<SitePublicCertificate>;
  @doc("Description for Get public certificates for an app or a deployment slot.")
  listPublicCertificates is ArmResourceListByParent<SitePublicCertificate>;
}
