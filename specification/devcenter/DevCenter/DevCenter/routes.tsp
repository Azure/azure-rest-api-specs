import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "../shared/models.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;

interface DevCenter {
  @doc("Lists all projects.")
  listProjects is StandardResourceOperations.ResourceList<Project>;

  @doc("Gets a project.")
  getProject is StandardResourceOperations.ResourceRead<Project>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern since DevBox has a different path"
  @doc("Lists Dev Boxes that the caller has access to in the DevCenter.")
  @route("/devboxes")
  @get
  listAllDevBoxes is Azure.Core.Foundations.Operation<{}, DevBoxListResult>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern since DevBox has a different path"
  @doc("Lists Dev Boxes in the Dev Center for a particular user.")
  @route("/users/{userId}/devboxes")
  @get
  listAllDevBoxesByUser is Azure.Core.Foundations.Operation<
    {
      @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
      @path
      userId: string;
    },
    DevBoxListResult
  >;
}
