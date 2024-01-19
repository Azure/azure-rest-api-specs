import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
@doc("Represents an environment type.")
@parentResource(Project)
model ProjectEnvironmentType
  is TrackedResource<ProjectEnvironmentTypeProperties> {
  @doc("The name of the environment type.")
  @path
  @key("environmentTypeName")
  @segment("environmentTypes")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface ProjectEnvironmentTypes {
  @doc("Gets a project environment type.")
  get is ArmResourceRead<ProjectEnvironmentType>;

  @doc("Creates or updates a project environment type.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ProjectEnvironmentType>;

  @doc("Partially updates a project environment type.")
  update is ArmCustomPatchSync<
    ProjectEnvironmentType,
    ProjectEnvironmentTypeUpdate
  >;

  @doc("Deletes a project environment type.")
  delete is ArmResourceDeleteSync<ProjectEnvironmentType>;

  @doc("Lists environment types for a project.")
  list is ArmResourceListByParent<
    ProjectEnvironmentType,
    {
      ...BaseParameters<ProjectEnvironmentType>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}

@@projectedName(ProjectEnvironmentTypes.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(ProjectEnvironmentTypes.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(ProjectEnvironmentTypes.createOrUpdate::parameters.resource,
  "Represents a Project Environment Type."
);
@@projectedName(ProjectEnvironmentTypes.update::parameters.properties,
  "json",
  "body"
);
@@extension(ProjectEnvironmentTypes.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(ProjectEnvironmentTypes.update::parameters.properties,
  "Updatable project environment type properties."
);
