import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./GlobalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PaloAltoNetworks.Ngfw;
@doc("GlobalRulestack Certificate Object")
@parentResource(GlobalRulestackResource)
model CertificateObjectGlobalRulestackResource
  is ProxyResource<CertificateObject> {
  @doc("certificate name")
  @path
  @key("name")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface CertificateObjectGlobalRulestack {
  @doc("Get a CertificateObjectGlobalRulestackResource")
  get is ArmResourceRead<CertificateObjectGlobalRulestackResource>;
  @doc("Create a CertificateObjectGlobalRulestackResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CertificateObjectGlobalRulestackResource>;
  @doc("Delete a CertificateObjectGlobalRulestackResource")
  delete is ArmResourceDeleteAsync<CertificateObjectGlobalRulestackResource>;
  @doc("List CertificateObjectGlobalRulestackResource resources by Tenant")
  list is ArmResourceListByParent<CertificateObjectGlobalRulestackResource>;
}
