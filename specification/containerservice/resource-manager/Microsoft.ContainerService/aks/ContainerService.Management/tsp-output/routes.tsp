import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerService;

interface TrustedAccessRolesOperations {
  @summary("List supported trusted access roles.")
  @doc("List supported trusted access roles.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ContainerService/locations/{location}/trustedAccessRoles")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of Azure region.")
      @minLength(1)
      @path
      location: string;
    },
    TrustedAccessRoleListResult
  >;
}
