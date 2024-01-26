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
 * Represents an environment type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DevCenter)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(EnvironmentTypeProperties)
model EnvironmentType extends ProxyResourceBase {
  /**
   * The name of the environment type.
   */
  @path
  @key("environmentTypeName")
  @segment("environmentTypes")
  @visibility("read")
  name: string;

  /**
   * Properties of an environment type.
   */
  @extension("x-ms-client-flatten", true)
  properties?: EnvironmentTypeProperties;
}

@armResourceOperations
interface EnvironmentTypes {
  /**
   * Gets an environment type.
   */
  get is ArmResourceRead<EnvironmentType>;

  /**
   * Creates or updates an environment type.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<EnvironmentType>;

  /**
   * Partially updates an environment type.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<EnvironmentType, EnvironmentTypeUpdate>;

  /**
   * Deletes an environment type.
   */
  delete is ArmResourceDeleteSync<EnvironmentType>;

  /**
   * Lists environment types for the devcenter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("EnvironmentTypes_ListByDevCenter")
  listByDevCenter is ArmResourceListByParent<
    EnvironmentType,
    {
      ...BaseParameters<EnvironmentType>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

@@projectedName(EnvironmentTypes.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(EnvironmentTypes.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(EnvironmentTypes.createOrUpdate::parameters.resource,
  "Represents an Environment Type."
);
@@projectedName(EnvironmentTypes.update::parameters.properties, "json", "body");
@@extension(EnvironmentTypes.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(EnvironmentTypes.update::parameters.properties,
  "Updatable environment type properties."
);
