import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@service({
  title: "Identity API",
})
@versioned(Communication.Identity.Versions)
namespace Communication.Identity;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2023-08-30-preview`,
}

// Operations ////////////////////

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface Roles {
  @doc("Get a role.")
  getRole is Operations.ResourceRead<Role>;

  @doc("Create or update a role.")
  createOrUpdateRole is Operations.ResourceCreateOrUpdate<Role>;

  @doc("Delete a role.")
  deleteRole is Operations.ResourceDelete<Role>;

  @doc("List roles.")
  listRoles is Operations.ResourceList<Role>;
  
  @doc("Create a role.")
  createRole is Operations.ResourceCreateWithServiceProvidedName<Role>;
}