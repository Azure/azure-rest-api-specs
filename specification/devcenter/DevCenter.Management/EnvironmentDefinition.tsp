import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Catalog.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * Represents an environment definition catalog item.
 */
@parentResource(Catalog)
model EnvironmentDefinition
  is Azure.ResourceManager.ProxyResource<EnvironmentDefinitionProperties> {
  ...ResourceNameParameter<
    Resource = EnvironmentDefinition,
    KeyName = "environmentDefinitionName",
    SegmentName = "environmentDefinitions",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;
}

@armResourceOperations
interface EnvironmentDefinitionOps
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

        /** The name of the Catalog. */
        @path
        @segment("catalogs")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        catalogName: string,
      },
      {
        /** The name of the Environment Definition. */
        @path
        @segment("environmentDefinitions")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        environmentDefinitionName: string,
      }
    > {}

@armResourceOperations
interface EnvironmentDefinitions {
  /**
   * Gets an environment definition from the catalog.
   */
  getByProjectCatalog is EnvironmentDefinitionOps.Read<EnvironmentDefinition>;

  /**
   * Lists the environment definitions in this project catalog.
   */
  listByProjectCatalog is EnvironmentDefinitionOps.List<
    EnvironmentDefinition,
    Response = EnvironmentDefinitionListResult
  >;

  /**
   * Gets Environment Definition error details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ProjectCatalogEnvironmentDefinitions_GetErrorDetails")
  getErrorDetails is EnvironmentDefinitionOps.ActionSync<
    EnvironmentDefinition,
    void,
    ArmResponse<CatalogResourceValidationErrorDetails>
  >;
}
@armResourceOperations
interface EnvironmentDefinitionOperationGroupOps
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

        /** The name of the Catalog. */
        @path
        @segment("catalogs")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        catalogName: string,
      },
      {
        /** The name of the Environment Definition. */
        @path
        @segment("environmentDefinitions")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        environmentDefinitionName: string,
      }
    > {}

@armResourceOperations
interface EnvironmentDefinitionOperationGroup {
  /**
   * Gets an environment definition from the catalog.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("EnvironmentDefinitions_Get")
  get is EnvironmentDefinitionOperationGroupOps.Read<EnvironmentDefinition>;

  /**
   * List environment definitions in the catalog.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("EnvironmentDefinitions_ListByCatalog")
  listByCatalog is EnvironmentDefinitionOperationGroupOps.List<
    EnvironmentDefinition,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    },
    Response = EnvironmentDefinitionListResult
  >;

  /**
   * Gets Environment Definition error details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("EnvironmentDefinitions_GetErrorDetails")
  getErrorDetails is EnvironmentDefinitionOperationGroupOps.ActionSync<
    EnvironmentDefinition,
    void,
    ArmResponse<CatalogResourceValidationErrorDetails>
  >;
}

@@maxLength(EnvironmentDefinition.name, 63);
@@minLength(EnvironmentDefinition.name, 3);
@@doc(EnvironmentDefinition.name, "The name of the Environment Definition.");
@@doc(EnvironmentDefinition.properties, "Environment definition properties.");
