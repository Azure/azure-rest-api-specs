import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProtectionContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Protection container mapping object.
 */
@parentResource(ProtectionContainer)
model ProtectionContainerMapping
  is Azure.ResourceManager.ProxyResource<ProtectionContainerMappingProperties> {
  ...ResourceNameParameter<
    Resource = ProtectionContainerMapping,
    KeyName = "mappingName",
    SegmentName = "replicationProtectionContainerMappings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ProtectionContainerMappings {
  /**
   * Gets the details of a protection container mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationProtectionContainerMappings_Get")
  get is ArmResourceRead<ProtectionContainerMapping>;

  /**
   * The operation to create a protection container mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ReplicationProtectionContainerMappings_Create")
  create is ArmResourceCreateOrReplaceAsync<
    ProtectionContainerMapping,
    Response = ArmResourceUpdatedResponse<ProtectionContainerMapping> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update protection container mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("ReplicationProtectionContainerMappings_Update")
  update is ArmCustomPatchAsync<
    ProtectionContainerMapping,
    PatchModel = UpdateProtectionContainerMappingInput
  >;

  /**
   * The operation to purge(force delete) a protection container mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationProtectionContainerMappings_Purge")
  purge is ArmResourceDeleteWithoutOkAsync<ProtectionContainerMapping>;

  /**
   * Lists the protection container mappings for a protection container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationProtectionContainerMappings_ListByReplicationProtectionContainers")
  listByReplicationProtectionContainers is ArmResourceListByParent<
    ProtectionContainerMapping,
    Response = ArmResponse<ProtectionContainerMappingCollection>
  >;

  /**
   * The operation to delete or remove a protection container mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("remove")
  @operationId("ReplicationProtectionContainerMappings_Delete")
  delete is ArmResourceActionAsync<
    ProtectionContainerMapping,
    RemoveProtectionContainerMappingInput,
    NoContentResponse
  >;
}

@@doc(ProtectionContainerMapping.name, "Protection Container mapping name.");
@@doc(ProtectionContainerMapping.properties, "The custom data.");
@@doc(ProtectionContainerMappings.create::parameters.resource,
  "Mapping creation input."
);
@@doc(ProtectionContainerMappings.update::parameters.properties,
  "Mapping update input."
);
@@doc(ProtectionContainerMappings.delete::parameters.body, "Removal input.");
