import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./LocalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace PaloAltoNetworks.Cloudngfw;
@doc("LocalRulestack Certificate Object")
@parentResource(LocalRulestackResource)
model CertificateObjectLocalRulestackResource
  is ProxyResource<CertificateObject> {
  @doc("certificate name")
  @path
  @key("name")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface CertificateObjectLocalRulestackResources {
  @doc("Get a CertificateObjectLocalRulestackResource")
  get is ArmResourceRead<CertificateObjectLocalRulestackResource>;
  @doc("Create a CertificateObjectLocalRulestackResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CertificateObjectLocalRulestackResource>;
  @doc("Delete a CertificateObjectLocalRulestackResource")
  delete is ArmResourceDeleteAsync<CertificateObjectLocalRulestackResource>;
  @doc("List CertificateObjectLocalRulestackResource resources by LocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<CertificateObjectLocalRulestackResource>;
}
