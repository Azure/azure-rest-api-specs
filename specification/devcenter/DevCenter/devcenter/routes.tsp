import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenter;

interface DevCenterOperations {
  @doc("Lists all projects.")
  @route("/projects")
  @get
  ListProjects is DevCenterBaseResponse<
    {
      @doc("An OData filter clause to apply to the operation.")
      @query
      filter: string;

      @doc("The maximum number of resources to return from the operation. Example: 'top=10'.")
      @query
      top: int32;
    },
    ProjectListResult
  >;

  @doc("Gets a project.")
  @route("/projects/{projectName}")
  @get
  GetProject is DevCenterBaseResponse<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @path
      projectName: string;
    },
    Project
  >;
}
