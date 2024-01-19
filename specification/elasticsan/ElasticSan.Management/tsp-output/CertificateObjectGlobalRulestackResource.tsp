import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GlobalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
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
interface CertificateObjectGlobalRulestackResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a CertificateObjectGlobalRulestackResource")
  @operationId("CertificateObjectGlobalRulestack_Get")
  get is ArmResourceRead<CertificateObjectGlobalRulestackResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a CertificateObjectGlobalRulestackResource")
  @operationId("CertificateObjectGlobalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    CertificateObjectGlobalRulestackResource,
    BaseParameters<CertificateObjectGlobalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a CertificateObjectGlobalRulestackResource")
  @operationId("CertificateObjectGlobalRulestack_Delete")
  delete is ArmResourceDeleteAsync<
    CertificateObjectGlobalRulestackResource,
    BaseParameters<CertificateObjectGlobalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List CertificateObjectGlobalRulestackResource resources by Tenant")
  @operationId("CertificateObjectGlobalRulestack_List")
  list is ArmResourceListByParent<CertificateObjectGlobalRulestackResource>;
}
