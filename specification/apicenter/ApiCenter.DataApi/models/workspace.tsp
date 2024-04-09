import "@typespec/rest";

namespace ApiCenter.DataApi;

using TypeSpec.Rest;

@doc("Workspace resource model.")
@resource("workspaces")
model Workspace {
  @doc("Workspace identifier.")
  @maxLength(50)
  @key("workspaceName")
  @visibility
  name: string;

  @doc("Workspace title, e.g. 'My workspace'.")
  @maxLength(50)
  title: string;

  @doc("Workspace description.")
  @maxLength(1000)
  description?: string;
}
