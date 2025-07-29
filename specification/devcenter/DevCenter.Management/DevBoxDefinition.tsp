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
/**
 * Represents a definition for a Developer Machine.
 */
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

        /** The name of the devcenter. */
        @path
        @segment("devcenters")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{2,25}$")
        @minLength(3)
        @maxLength(26)
        devCenterName: string,
      },
      {
        /** The name of the Dev Box definition. */
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
  /**
   * Gets a Dev Box definition
   */
  get is DevBoxDefinitionOps.Read<DevBoxDefinition>;

  /**
   * Creates or updates a Dev Box definition.
   */
  createOrUpdate is DevBoxDefinitionOps.CreateOrUpdateAsync<DevBoxDefinition>;

  /**
   * Partially updates a Dev Box definition.
   */
  @patch(#{ implicitOptionality: false })
  update is DevBoxDefinitionOps.CustomPatchAsync<
    DevBoxDefinition,
    PatchModel = DevBoxDefinitionUpdate,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Response = DevBoxDefinition | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmAsyncOperationHeader<FinalResult = DevBoxDefinition>
    >
  >;

  /**
   * Deletes a Dev Box definition
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  delete is DevBoxDefinitionOps.DeleteWithoutOkAsync<
    DevBoxDefinition,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List Dev Box definitions for a devcenter.
   */
  listByDevCenter is DevBoxDefinitionOps.List<
    DevBoxDefinition,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
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

        /** The name of the project. */
        @path
        @segment("projects")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        projectName: string,
      },
      {
        /** The name of the Dev Box definition. */
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
  /**
   * Gets a Dev Box definition configured for a project
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DevBoxDefinitions_GetByProject")
  getByProject is DevBoxDefinitionOperationGroupOps.Read<DevBoxDefinition>;

  /**
   * List Dev Box definitions configured for a project.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DevBoxDefinitions_ListByProject")
  listByProject is DevBoxDefinitionOperationGroupOps.List<
    DevBoxDefinition,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
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
