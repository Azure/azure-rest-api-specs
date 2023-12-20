import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerServiceManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerService;
@doc("Defines binding between a resource and role")
@parentResource(ContainerServiceManagedCluster)
model ContainerServiceTrustedAccessRoleBinding
  is ProxyResource<TrustedAccessRoleBindingProperties> {
  @doc("The name of trusted access role binding.")
  @maxLength(24)
  @minLength(1)
  @pattern("^([A-Za-z0-9-])+$")
  @path
  @key("trustedAccessRoleBindingName")
  @segment("trustedAccessRoleBindings")
  name: string;
}

@armResourceOperations
interface ContainerServiceTrustedAccessRoleBindings {
  @doc("Get a trusted access role binding.")
  get is ArmResourceRead<ContainerServiceTrustedAccessRoleBinding>;
  @doc("Create or update a trusted access role binding")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ContainerServiceTrustedAccessRoleBinding>;
  @doc("Delete a trusted access role binding.")
  delete is ArmResourceDeleteSync<ContainerServiceTrustedAccessRoleBinding>;
  @doc("List trusted access role bindings.")
  list is ArmResourceListByParent<ContainerServiceTrustedAccessRoleBinding>;
}
