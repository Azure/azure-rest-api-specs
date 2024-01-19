import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;
@doc("Defines binding between a resource and role")
@parentResource(ManagedCluster)
model TrustedAccessRoleBinding
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
interface TrustedAccessRoleBindings {
  @doc("Get a trusted access role binding.")
  get is ArmResourceRead<TrustedAccessRoleBinding>;

  @doc("Create or update a trusted access role binding")
  createOrUpdate is ArmResourceCreateOrReplaceSync<TrustedAccessRoleBinding>;

  @doc("Delete a trusted access role binding.")
  delete is ArmResourceDeleteSync<TrustedAccessRoleBinding>;

  @doc("List trusted access role bindings.")
  list is ArmResourceListByParent<TrustedAccessRoleBinding>;
}

@@projectedName(TrustedAccessRoleBindings.createOrUpdate::parameters.resource,
  "json",
  "trustedAccessRoleBinding"
);
@@extension(TrustedAccessRoleBindings.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "trustedAccessRoleBinding"
);
@@doc(TrustedAccessRoleBindings.createOrUpdate::parameters.resource,
  "A trusted access role binding"
);
