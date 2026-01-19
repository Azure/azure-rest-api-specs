import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;

@doc("Represents an project policy resource.")
@parentResource(DevCenter)
model ProjectPolicy
  is Azure.ResourceManager.ProxyResource<ProjectPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ProjectPolicy,
    KeyName = "projectPolicyName",
    SegmentName = "projectPolicies",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;
}

@armResourceOperations
interface ProjectPolicies {
  @doc("Gets a specific project policy.")
  get is ArmResourceRead<ProjectPolicy>;

  @doc("Creates or updates an project policy.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ProjectPolicy>;

  @doc("Partially updates an project policy.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ProjectPolicy,
    PatchModel = ProjectPolicyUpdate,
    LroHeaders = ArmLroLocationHeader,
    Response = ProjectPolicy | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmLroLocationHeader<FinalResult = ProjectPolicy>
    >
  >;

  @doc("Deletes an project policy.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ProjectPolicy,
    LroHeaders = ArmLroLocationHeader
  >;

  @doc("Lists all project policies in the dev center.")
  listByDevCenter is ArmResourceListByParent<
    ProjectPolicy,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = ProjectPolicyListResult
  >;
}

@@maxLength(ProjectPolicy.name, 63);
@@minLength(ProjectPolicy.name, 3);
@@doc(ProjectPolicy.name, "The name of the project policy.");
@@doc(ProjectPolicy.properties, "Properties of an project policy.");
@@doc(ProjectPolicies.createOrUpdate::parameters.resource,
  "Represents an project policy."
);
@@doc(ProjectPolicies.update::parameters.properties,
  "Updatable project policy properties."
);
