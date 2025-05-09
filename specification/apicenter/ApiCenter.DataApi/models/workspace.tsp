import "@typespec/rest";

namespace ApiCenter.DataApi;

using TypeSpec.Rest;

@doc("Workspace resource model.")
@resource("workspaces")
model Workspace {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "FIXME: misused @visibility to get around this warning"
  @doc("Workspace identifier.")
  @maxLength(50)
  @key("workspaceName")
  name: string;

  @doc("Workspace title, e.g. 'My workspace'.")
  @maxLength(50)
  title: string;

  @doc("Workspace description.")
  @maxLength(1000)
  description?: string;
}
