import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
/**
 * Global parameters resource type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Factory)
@includeInapplicableMetadataInPayload(false)
model GlobalParameterResource extends SubResource {
  /**
   * The global parameter name.
   */
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @path
  @key("globalParameterName")
  @segment("globalParameters")
  @visibility("read")
  name: string;

  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties?: Record<unknown>;
}

@armResourceOperations
interface GlobalParameterResources {
  /**
   * Gets a Global parameter
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalParameters_Get")
  get is ArmResourceRead<GlobalParameterResource>;

  /**
   * Creates or updates a Global parameter
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalParameters_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<GlobalParameterResource>;

  /**
   * Deletes a Global parameter
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalParameters_Delete")
  delete is ArmResourceDeleteSync<GlobalParameterResource>;

  /**
   * Lists Global parameters
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalParameters_ListByFactory")
  listByFactory is ArmResourceListByParent<GlobalParameterResource>;
}

@@projectedName(GlobalParameterResources.createOrUpdate::parameters.resource,
  "json",
  "default"
);
@@extension(GlobalParameterResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "default"
);
@@doc(GlobalParameterResources.createOrUpdate::parameters.resource,
  "Global parameter resource definition."
);
