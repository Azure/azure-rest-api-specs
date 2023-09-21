import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../shared/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenter;

@doc("Results of the project list operation.")
model ProjectListResult is Azure.Core.Page<Project>;

@doc("Project details.")
@resource("projects")
model Project {
  @key("projectName")
  @visibility("read")
  @doc("Name of the project")
  name: string;

  @doc("Description of the project.")
  description?: string;

  @doc("""
When specified, indicates the maximum number of Dev Boxes a single user can
create across all pools in the project.
""")
  maxDevBoxesPerUser?: int32;
}
