import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * Represents a definition for a Developer Machine.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DevCenter)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(DevBoxDefinitionProperties)
model DevBoxDefinition extends TrackedResourceBase {
  /**
   * The name of the Dev Box definition.
   */
  @path
  @key("devBoxDefinitionName")
  @segment("devboxdefinitions")
  @visibility("read")
  name: string;

  /**
   * Dev Box definition properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: DevBoxDefinitionProperties;
}

@armResourceOperations
interface DevBoxDefinitions {
  /**
   * Gets a Dev Box definition
   */
  get is ArmResourceRead<DevBoxDefinition>;

  /**
   * Creates or updates a Dev Box definition.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DevBoxDefinition,
    BaseParameters<DevBoxDefinition>,
    ArmAsyncOperationHeader
  >;

  /**
   * Partially updates a Dev Box definition.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    DevBoxDefinition,
    DevBoxDefinitionUpdate,
    BaseParameters<DevBoxDefinition>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a Dev Box definition
   */
  delete is ArmResourceDeleteAsync<
    DevBoxDefinition,
    BaseParameters<DevBoxDefinition>,
    ArmAsyncOperationHeader
  >;

  /**
   * List Dev Box definitions for a devcenter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DevBoxDefinitions_ListByDevCenter")
  listByDevCenter is ArmResourceListByParent<
    DevBoxDefinition,
    {
      ...BaseParameters<DevBoxDefinition>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

@@projectedName(DevBoxDefinitions.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(DevBoxDefinitions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(DevBoxDefinitions.createOrUpdate::parameters.resource,
  "Represents a Dev Box definition."
);
@@projectedName(DevBoxDefinitions.update::parameters.properties,
  "json",
  "body"
);
@@extension(DevBoxDefinitions.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(DevBoxDefinitions.update::parameters.properties,
  "Represents a Dev Box definition."
);
