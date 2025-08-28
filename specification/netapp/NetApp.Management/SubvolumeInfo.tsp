import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Volume.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
/**
 * Subvolume Information properties
 */
@parentResource(Volume)
model SubvolumeInfo
  is Azure.ResourceManager.ProxyResource<SubvolumeProperties> {
  ...ResourceNameParameter<
    Resource = SubvolumeInfo,
    KeyName = "subvolumeName",
    SegmentName = "subvolumes",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$"
  >;
}

@armResourceOperations
interface SubvolumeInfos {
  /**
   * Returns the path associated with the subvolumeName provided
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Subvolumes_Get")
  get is ArmResourceRead<SubvolumeInfo>;

  /**
   * Creates a subvolume in the path or clones the subvolume mentioned in the parentPath
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Subvolumes_Create")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    SubvolumeInfo,
    Response = ArmResourceUpdatedResponse<SubvolumeInfo> | ArmResourceCreatedResponse<
      SubvolumeInfo,
      ArmAsyncOperationHeader<FinalResult = SubvolumeInfo> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Patch a subvolume
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("Subvolumes_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    SubvolumeInfo,
    PatchModel = SubvolumePatchRequest,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = SubvolumeInfo> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete subvolume
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Subvolumes_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SubvolumeInfo,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Returns a list of the subvolumes in the volume
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Subvolumes_ListByVolume")
  listByVolume is ArmResourceListByParent<
    SubvolumeInfo,
    Response = ArmResponse<SubvolumesList>
  >;

  /**
   * Get details of the specified subvolume
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("Subvolumes_GetMetadata")
  getMetadata is ArmResourceActionAsync<
    SubvolumeInfo,
    void,
    ArmResponse<SubvolumeModel>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = SubvolumeModel> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@maxLength(SubvolumeInfo.name, 64);
@@minLength(SubvolumeInfo.name, 1);
@@doc(SubvolumeInfo.name, "The name of the subvolume.");
@@doc(SubvolumeInfo.properties, "Subvolume Properties");
@@doc(SubvolumeInfos.create::parameters.resource,
  "Subvolume object supplied in the body of the operation."
);
@@doc(SubvolumeInfos.update::parameters.properties,
  "Subvolume object supplied in the body of the operation."
);
