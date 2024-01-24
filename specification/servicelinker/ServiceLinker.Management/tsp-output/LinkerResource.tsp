import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceLinker;
/**
 * Linker of source and target resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(LinkerProperties)
@includeInapplicableMetadataInPayload(false)
model LinkerResource extends ExtensionResourceBase {
  /**
   * The name Linker resource.
   */
  @path
  @key("linkerName")
  @segment("linkers")
  name: string;

  /**
   * The properties of the linker.
   */
  @extension("x-ms-client-flatten", true)
  properties: LinkerProperties;
}

@armResourceOperations
interface LinkerResources {
  /**
   * Returns Linker resource for a given name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Linker_Get")
  get is ArmResourceRead<LinkerResource>;

  /**
   * Create or update linker resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Linker_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LinkerResource,
    BaseParameters<LinkerResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Operation to update an existing link.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Linker_Update")
  update is ArmCustomPatchAsync<
    LinkerResource,
    LinkerPatch,
    BaseParameters<LinkerResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete a link.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Linker_Delete")
  delete is ArmResourceDeleteAsync<
    LinkerResource,
    BaseParameters<LinkerResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Returns list of Linkers which connects to the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Linker_List")
  list is ArmResourceListByParent<LinkerResource>;

  /**
   * Validate a link.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Linker_Validate")
  validate is ArmResourceActionAsync<
    LinkerResource,
    void,
    ValidateOperationResult,
    BaseParameters<LinkerResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * list source configurations for a linker.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Linker_ListConfigurations")
  listConfigurations is ArmResourceActionSync<
    LinkerResource,
    void,
    SourceConfigurationResult
  >;
}

@@projectedName(LinkerResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(LinkerResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(LinkerResources.createOrUpdate::parameters.resource, "Linker details.");
@@projectedName(LinkerResources.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(LinkerResources.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(LinkerResources.update::parameters.properties, "Linker details.");
