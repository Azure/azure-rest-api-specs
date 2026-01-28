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

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

@armResourceOperations
interface ProtectionContainerMappings {
  /**
   * Gets the details of a protection container mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets a protection container mapping.")
  get is ArmResourceRead<ProtectionContainerMapping, Error = never>;

  /**
   * The operation to create a protection container mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create protection container mapping.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    ProtectionContainerMapping,
    Request = CreateProtectionContainerMappingInput,
    Response = ArmResourceUpdatedResponse<ProtectionContainerMapping> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ProtectionContainerMapping> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = never
  >;

  /**
   * The operation to update protection container mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @summary("Update protection container mapping.")
  update is ArmCustomPatchAsync<
    ProtectionContainerMapping,
    PatchModel = UpdateProtectionContainerMappingInput,
    Error = never
  >;

  /**
   * The operation to purge(force delete) a protection container mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Purge protection container mapping.")
  purge is ArmResourceDeleteWithoutOkAsync<
    ProtectionContainerMapping,
    Error = never
  >;

  /**
   * Lists the protection container mappings for a protection container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the list of protection container mappings for a protection container.")
  listByReplicationProtectionContainers is ArmResourceListByParent<
    ProtectionContainerMapping,
    Response = ArmResponse<ProtectionContainerMappingCollection>,
    Error = never
  >;

  /**
   * The operation to delete or remove a protection container mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("remove")
  @summary("Remove protection container mapping.")
  delete is ArmResourceActionAsyncBase<
    ProtectionContainerMapping,
    RemoveProtectionContainerMappingInput,
    NoContentResponse | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ProtectionContainerMapping>,
    Error = never
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
