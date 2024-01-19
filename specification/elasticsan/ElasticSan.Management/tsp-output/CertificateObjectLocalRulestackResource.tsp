import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LocalRulestackResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a CertificateObjectLocalRulestackResource")
  @operationId("CertificateObjectLocalRulestack_Get")
  get is ArmResourceRead<CertificateObjectLocalRulestackResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a CertificateObjectLocalRulestackResource")
  @operationId("CertificateObjectLocalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    CertificateObjectLocalRulestackResource,
    BaseParameters<CertificateObjectLocalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a CertificateObjectLocalRulestackResource")
  @operationId("CertificateObjectLocalRulestack_Delete")
  delete is ArmResourceDeleteAsync<
    CertificateObjectLocalRulestackResource,
    BaseParameters<CertificateObjectLocalRulestackResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List CertificateObjectLocalRulestackResource resources by LocalRulestacks")
  @operationId("CertificateObjectLocalRulestack_ListByLocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<CertificateObjectLocalRulestackResource>;
}
