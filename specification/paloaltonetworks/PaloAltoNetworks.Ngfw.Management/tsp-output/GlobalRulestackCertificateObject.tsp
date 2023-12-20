import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./GlobalRulestack.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.PaloAltoNetworks.Ngfw;
@doc("GlobalRulestack Certificate Object")
@parentResource(GlobalRulestack)
model GlobalRulestackCertificateObject is ProxyResource<CertificateObject> {
  @doc("certificate name")
  @path
  @key("name")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface GlobalRulestackCertificateObjects {
  @doc("Get a CertificateObjectGlobalRulestackResource")
  get is ArmResourceRead<GlobalRulestackCertificateObject>;
  @doc("Create a CertificateObjectGlobalRulestackResource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GlobalRulestackCertificateObject>;
  @doc("Delete a CertificateObjectGlobalRulestackResource")
  delete is ArmResourceDeleteAsync<GlobalRulestackCertificateObject>;
  @doc("List CertificateObjectGlobalRulestackResource resources by Tenant")
  list is ArmResourceListByParent<GlobalRulestackCertificateObject>;
}
