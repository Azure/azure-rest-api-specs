import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;

interface DevCenterOperations {
  @doc("Lists all projects.")
  @route("/projects")
  @get
  listProjects is StandardResourceOperations.ResourceList<Project>;

  @doc("Gets a project.")
  @route("/projects/{projectName}")
  @get
  getProject is StandardResourceOperations.ResourceRead<Project>;
}