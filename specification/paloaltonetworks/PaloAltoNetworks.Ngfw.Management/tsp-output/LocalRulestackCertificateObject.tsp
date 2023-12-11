import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./LocalRulestack.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PaloAltoNetworks.Ngfw;
@doc("LocalRulestack Certificate Object")
@parentResource(LocalRulestack)
model LocalRulestackCertificateObject is ProxyResource<CertificateObject> {
  @doc("certificate name")
  @path
  @key("name")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface LocalRulestackCertificateObjects {
  @doc("Get a CertificateObjectLocalRulestackResource")
  get is ArmResourceRead<LocalRulestackCertificateObject>;
  @doc("Create a CertificateObjectLocalRulestackResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LocalRulestackCertificateObject>;
  @doc("Delete a CertificateObjectLocalRulestackResource")
  delete is ArmResourceDeleteAsync<LocalRulestackCertificateObject>;
  @doc("List CertificateObjectLocalRulestackResource resources by LocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<LocalRulestackCertificateObject>;
}
