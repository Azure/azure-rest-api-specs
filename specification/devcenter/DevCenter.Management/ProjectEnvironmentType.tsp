import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;

@doc("Represents an environment type.")
@parentResource(Project)
model ProjectEnvironmentType
  is Azure.ResourceManager.TrackedResource<ProjectEnvironmentTypeProperties> {
  ...ResourceNameParameter<
    Resource = ProjectEnvironmentType,
    KeyName = "environmentTypeName",
    SegmentName = "environmentTypes",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This is a valid property."
  @doc("Managed identity properties.")
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

@armResourceOperations
interface ProjectEnvironmentTypes {
  @doc("Gets a project environment type.")
  get is ArmResourceRead<ProjectEnvironmentType>;

  @doc("Creates or updates a project environment type.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ProjectEnvironmentType>;

  @doc("Partially updates a project environment type.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ProjectEnvironmentType,
    PatchModel = ProjectEnvironmentTypeUpdate
  >;

  @doc("Deletes a project environment type.")
  delete is ArmResourceDeleteSync<ProjectEnvironmentType>;

  @doc("Lists environment types for a project.")
  list is ArmResourceListByParent<
    ProjectEnvironmentType,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = ProjectEnvironmentTypeListResult
  >;
}

@@maxLength(ProjectEnvironmentType.name, 63);
@@minLength(ProjectEnvironmentType.name, 3);
@@doc(ProjectEnvironmentType.name, "The name of the environment type.");
@@doc(ProjectEnvironmentType.properties, "Properties of an environment type.");
@@doc(ProjectEnvironmentTypes.createOrUpdate::parameters.resource,
  "Represents a Project Environment Type."
);
@@doc(ProjectEnvironmentTypes.update::parameters.properties,
  "Updatable project environment type properties."
);
