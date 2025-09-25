import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;

@doc("Represents a project resource.")
model Project is Azure.ResourceManager.TrackedResource<ProjectProperties> {
  ...ResourceNameParameter<
    Resource = Project,
    KeyName = "projectName",
    SegmentName = "projects",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This is a valid property."
  @doc("Managed identity properties.")
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

@armResourceOperations
interface Projects {
  @doc("Gets a specific project.")
  get is ArmResourceRead<Project>;

  @doc("Creates or updates a project.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Project>;

  @doc("Partially updates a project.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Project,
    PatchModel = ProjectUpdate,
    LroHeaders = ArmLroLocationHeader,
    Response = Project | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmLroLocationHeader<FinalResult = Project>
    >
  >;

  @doc("Deletes a project resource.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Project,
    LroHeaders = ArmLroLocationHeader
  >;

  @doc("Lists all projects in the resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Project,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = ProjectListResult
  >;

  @doc("Lists all projects in the subscription.")
  listBySubscription is ArmListBySubscription<
    Project,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = ProjectListResult
  >;

  @doc("Gets applicable inherited settings for this project.")
  getInheritedSettings is ArmResourceActionSync<
    Project,
    void,
    ArmResponse<InheritedSettingsForProject>
  >;

  @doc("Lists SKUs available to the project.")
  @list
  @action("listSkus")
  listByProject is ArmResourceActionSync<
    Project,
    void,
    ArmResponse<SkuListResult>
  >;
}

@@maxLength(Project.name, 63);
@@minLength(Project.name, 3);
@@doc(Project.name, "The name of the project.");
@@doc(Project.properties, "Properties of a project.");
@@doc(Projects.createOrUpdate::parameters.resource, "Represents a project.");
@@doc(Projects.update::parameters.properties, "Updatable project properties.");
