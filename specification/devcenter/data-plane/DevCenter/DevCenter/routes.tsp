import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "../shared/models.tsp";
import "../shared/parameters.tsp";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace DevCenterService;

interface DevCenter {
  @doc("Lists all projects.")
  listProjects is StandardResourceOperations.ResourceList<Project>;

  @doc("Gets a project.")
  getProject is StandardResourceOperations.ResourceRead<Project>;

  @summary("Gets a list of Dev Box creations that are pending approval.")
  @doc("Gets a list of Dev Box creations that are pending approval.")
  @added(APIVersions.v2025_04_01_preview)
  listApprovals is StandardResourceOperations.ResourceList<
    Approval,
    ListQueryParametersTrait<StandardListQueryParameters & SelectQueryParameter>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "no @key for ProjectAbility model"
  //There is no @key for ProjectAbility model
  @doc("Gets the signed-in user's permitted abilities in a project.")
  @get
  @route("/projects/{projectName}/users/{userId}/abilities")
  @added(APIVersions.v2024_05_01_preview)
  getProjectAbilities is Azure.Core.Foundations.Operation<
    {
      ...ProjectNameParameter;
      ...UserIdParameter;
    },
    ProjectAbilities
  >;
}
