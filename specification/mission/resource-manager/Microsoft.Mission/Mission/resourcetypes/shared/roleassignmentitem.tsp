import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Versioning;
@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Role assignment item that indicates which principals should be assigned this role definition")
model RoleAssignmentItem {
  @renamedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, "id")
  @doc("Role definition identifier")
  roleDefinitionId: string;

  @doc("List of principal IDs to which to assign this role definition")
  principals?: Principal[];
}
