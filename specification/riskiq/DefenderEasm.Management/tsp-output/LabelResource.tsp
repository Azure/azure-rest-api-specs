import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkspaceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Easm;
/**
 * Label details
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(WorkspaceResource)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(LabelResourceProperties)
model LabelResource extends ProxyResourceBase {
  /**
   * The name of the Label.
   */
  @path
  @key("labelName")
  @segment("labels")
  @visibility("read")
  name: string;

  /**
   * Label properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: LabelResourceProperties;
}

@armResourceOperations
interface LabelResources {
  /**
   * Returns a label in the given workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Labels_GetByWorkspace")
  getByWorkspace is ArmResourceRead<LabelResource>;

  /**
   * Create or update a Label.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Labels_CreateAndUpdate")
  createAndUpdate is ArmResourceCreateOrReplaceAsync<
    LabelResource,
    BaseParameters<LabelResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a Label.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Labels_Update")
  update is ArmCustomPatchSync<LabelResource, LabelPatchResource>;

  /**
   * Delete a Label.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Labels_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    LabelResource,
    BaseParameters<LabelResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Returns a list of labels in the given workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Labels_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<LabelResource>;
}

@@projectedName(LabelResources.createAndUpdate::parameters.resource,
  "json",
  "LabelResource"
);
@@extension(LabelResources.createAndUpdate::parameters.resource,
  "x-ms-client-name",
  "LabelResource"
);
@@doc(LabelResources.createAndUpdate::parameters.resource, "Label details.");
@@projectedName(LabelResources.update::parameters.properties,
  "json",
  "LabelPatchResource"
);
@@extension(LabelResources.update::parameters.properties,
  "x-ms-client-name",
  "LabelPatchResource"
);
@@doc(LabelResources.update::parameters.properties, "Label patch details.");
