import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Playwright;

@doc("Managed identity properties for accessing Azure resources.")
@added(Versions.v2026_11_01_preview)
model ManagedIdentity {
  @doc("The managed identity type. Defaults to SystemAssigned.")
  type?: IdentityType = IdentityType.SystemAssigned;

  @doc("The Azure Resource Manager resource ID of the user-assigned managed identity. Required when type is UserAssigned. Omit when type is SystemAssigned.")
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

@doc("The type of managed identity used to access Azure resources.")
@added(Versions.v2026_11_01_preview)
union IdentityType {
  string,

  @doc("System-assigned managed identity.")
  SystemAssigned: "SystemAssigned",

  @doc("User-assigned managed identity.")
  UserAssigned: "UserAssigned",
}
