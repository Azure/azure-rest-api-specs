import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@added(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("Role assignment item that indicates which principals should be assigned this role definition")
model RoleAssignmentItem {
  @doc("Role definition identifier")
  id: string;

  @doc("List of principal IDs to which to assign this role definition")
  principals?: Principal[];
}
