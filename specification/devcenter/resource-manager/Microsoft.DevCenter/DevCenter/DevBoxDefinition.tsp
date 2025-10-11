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

@doc("Represents a definition for a Developer Machine.")
@parentResource(DevCenter)
model DevBoxDefinition
  is Azure.ResourceManager.TrackedResource<DevBoxDefinitionProperties> {
  ...ResourceNameParameter<
    Resource = DevBoxDefinition,
    KeyName = "devBoxDefinitionName",
    SegmentName = "devboxdefinitions",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;
}

@armResourceOperations
interface DevBoxDefinitionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        @doc("The name of the devcenter.")
        @path
        @segment("devcenters")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{2,25}$")
        @minLength(3)
        @maxLength(26)
        devCenterName: string,
      },
      {
        @doc("The name of the Dev Box definition.")
        @path
        @segment("devboxdefinitions")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        devBoxDefinitionName: string,
      }
    > {}

@armResourceOperations
interface DevBoxDefinitions {
  @doc("Gets a Dev Box definition.")
  get is DevBoxDefinitionOps.Read<DevBoxDefinition>;

  @doc("Creates or updates a Dev Box definition.")
  createOrUpdate is DevBoxDefinitionOps.CreateOrUpdateAsync<DevBoxDefinition>;

  @doc("Partially updates a Dev Box definition.")
  @patch(#{ implicitOptionality: false })
  update is DevBoxDefinitionOps.CustomPatchAsync<
    DevBoxDefinition,
    PatchModel = DevBoxDefinitionUpdate,
    LroHeaders = ArmLroLocationHeader,
    Response = DevBoxDefinition | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmLroLocationHeader<FinalResult = DevBoxDefinition>
    >
  >;

  @doc("Deletes a Dev Box definition.")
  delete is DevBoxDefinitionOps.DeleteWithoutOkAsync<
    DevBoxDefinition,
    LroHeaders = ArmLroLocationHeader
  >;

  @doc("List Dev Box definitions for a devcenter.")
  listByDevCenter is DevBoxDefinitionOps.List<
    DevBoxDefinition,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = DevBoxDefinitionListResult
  >;
}
@armResourceOperations
interface DevBoxDefinitionOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        @doc("The name of the project.")
        @path
        @segment("projects")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        projectName: string,
      },
      {
        @doc("The name of the Dev Box definition.")
        @path
        @segment("devboxdefinitions")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        devBoxDefinitionName: string,
      }
    > {}

@armResourceOperations
interface DevBoxDefinitionOperationGroup {
  @doc("Gets a Dev Box definition configured for a project.")
  getByProject is DevBoxDefinitionOperationGroupOps.Read<DevBoxDefinition>;

  @doc("List Dev Box definitions configured for a project.")
  listByProject is DevBoxDefinitionOperationGroupOps.List<
    DevBoxDefinition,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = DevBoxDefinitionListResult
  >;
}

@@maxLength(DevBoxDefinition.name, 63);
@@minLength(DevBoxDefinition.name, 3);
@@doc(DevBoxDefinition.name, "The name of the Dev Box definition.");
@@doc(DevBoxDefinition.properties, "Dev Box definition properties");
@@doc(DevBoxDefinitions.createOrUpdate::parameters.resource,
  "Represents a Dev Box definition."
);
@@doc(DevBoxDefinitions.update::parameters.properties,
  "Represents a Dev Box definition."
);
