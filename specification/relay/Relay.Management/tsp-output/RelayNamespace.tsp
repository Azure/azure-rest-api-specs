import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Relay;
@doc("Description of a namespace resource.")
model RelayNamespace is TrackedResource<RelayNamespaceProperties> {
  @doc("The namespace name")
  @maxLength(50)
  @minLength(6)
  @path
  @key("namespaceName")
  @segment("namespaces")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Namespaces {
  @doc("Returns the description for the specified namespace.")
  get is ArmResourceRead<RelayNamespace>;
  @doc("Create Azure Relay namespace.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<RelayNamespace>;
  @doc("Creates or updates a namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.")
  update is ArmResourcePatchSync<RelayNamespace, RelayNamespaceProperties>;
  @doc("Deletes an existing namespace. This operation also removes all associated resources under the namespace.")
  delete is ArmResourceDeleteAsync<RelayNamespace>;
  @doc("Lists all the available namespaces within the ResourceGroup.")
  listByResourceGroup is ArmResourceListByParent<RelayNamespace>;
  @doc("Lists all the available namespaces within the subscription regardless of the resourceGroups.")
  list is ArmListBySubscription<RelayNamespace>;
}
