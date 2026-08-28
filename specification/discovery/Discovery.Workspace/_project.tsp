import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

using Microsoft.Discovery.Common;

@versioned(Microsoft.Discovery.Workspace.Versions)
namespace Microsoft.Discovery.Workspace;

@doc("A project.")
@resource("projects")
model Project {
  @doc("The project name.")
  @visibility(Lifecycle.Read)
  @key("projectName")
  @maxLength(24)
  @pattern(resourceNamePattern)
  name: string;
}

@route("/projects")
interface Projects {}
