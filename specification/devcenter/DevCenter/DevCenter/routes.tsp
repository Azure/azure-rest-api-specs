import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "../shared/models.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace DevCenterService;

interface DevCenter {
  @doc("Lists all projects.")
  listProjects is StandardResourceOperations.ResourceList<Project>;

  @doc("Gets a project.")
  getProject is StandardResourceOperations.ResourceRead<Project>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "no @key for ProjectAbility model"
  //There is no @key for ProjectAbility model
  @doc("Gets the signed-in user's permitted abilities in a project.")
  @get
  @route("/projects/{projectName}/users/{userId}/abilities")
  @added(APIVersions.v2024_05_01_preview)
  getProjectAbilities is Azure.Core.Foundations.Operation<
    {
      @doc("The DevCenter Project upon which to execute operations.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{2,62}$")
      @path
      projectName: string;

      @doc("""
          The AAD object id of the user. If value is 'me', the identity is taken from the
          authentication context.
        """)
      @maxLength(36)
      @minLength(2)
      @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$|^me$")
      @path
      userId: string;
    },
    ProjectAbilities
  >;
}
