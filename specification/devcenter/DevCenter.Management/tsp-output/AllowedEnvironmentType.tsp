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
/**
 * Represents an allowed environment type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Project)
@Azure.ResourceManager.Private.armResourceInternal(
  AllowedEnvironmentTypeProperties
)
@includeInapplicableMetadataInPayload(false)
model AllowedEnvironmentType extends ProxyResourceBase {
  /**
   * The name of the environment type.
   */
  @path
  @key("environmentTypeName")
  @segment("allowedEnvironmentTypes")
  name: string;

  /**
   * Properties of an allowed environment type.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AllowedEnvironmentTypeProperties;
}

@armResourceOperations
interface AllowedEnvironmentTypes {
  /**
   * Gets an allowed environment type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ProjectAllowedEnvironmentTypes_Get")
  get is ArmResourceRead<AllowedEnvironmentType>;

  /**
   * Lists allowed environment types for a project.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ProjectAllowedEnvironmentTypes_List")
  list is ArmResourceListByParent<
    AllowedEnvironmentType,
    {
      ...BaseParameters<AllowedEnvironmentType>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}
