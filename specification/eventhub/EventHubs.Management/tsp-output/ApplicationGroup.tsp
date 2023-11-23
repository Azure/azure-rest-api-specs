import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./EHNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.EventHub;
@doc("The Application Group object")
@parentResource(EHNamespace)
model ApplicationGroup is ProxyResource<ApplicationGroupProperties> {
  @doc("The Application Group name ")
  @maxLength(256)
  @minLength(1)
  @path
  @key("applicationGroupName")
  @segment("applicationGroups")
  name: string;
}

@armResourceOperations
interface ApplicationGroups {
  @doc("Gets an ApplicationGroup for a Namespace.")
  get is ArmResourceRead<ApplicationGroup>;
  @doc("Creates or updates an ApplicationGroup for a Namespace.")
  createOrUpdateApplicationGroup is ArmResourceCreateOrReplaceSync<ApplicationGroup>;
  @doc("Deletes an ApplicationGroup for a Namespace.")
  delete is ArmResourceDeleteSync<ApplicationGroup>;
  @doc("Gets a list of application groups for a Namespace.")
  listByNamespace is ArmResourceListByParent<ApplicationGroup>;
}
