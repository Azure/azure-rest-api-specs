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
@doc("LocalRulestack prefixList")
@parentResource(LocalRulestackResource)
model PrefixListResource is ProxyResource<PrefixObject> {
  @doc("Local Rule priority")
  @path
  @key("name")
  @segment("prefixlists")
  name: string;
}

@armResourceOperations
interface PrefixListResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a PrefixListResource")
  @operationId("PrefixListLocalRulestack_Get")
  get is ArmResourceRead<PrefixListResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a PrefixListResource")
  @operationId("PrefixListLocalRulestack_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    PrefixListResource,
    BaseParameters<PrefixListResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a PrefixListResource")
  @operationId("PrefixListLocalRulestack_Delete")
  delete is ArmResourceDeleteAsync<
    PrefixListResource,
    BaseParameters<PrefixListResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List PrefixListResource resources by LocalRulestacks")
  @operationId("PrefixListLocalRulestack_ListByLocalRulestacks")
  listByLocalRulestacks is ArmResourceListByParent<PrefixListResource>;
}
