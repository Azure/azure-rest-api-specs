import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Volume.tsp";

using Rest;
using Azure.ResourceManager;
using Http;

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

/**
 * List of Subvolumes
 */
model SubvolumesList is Azure.Core.Page<SubvolumeInfo>;

/**
 * This represents path associated with the subvolume
 */
model SubvolumeProperties {
  /**
   * Path to the subvolume
   */
  path?: string;

  /**
   * Truncate subvolume to the provided size in bytes
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  size?: int64 | null;

  /**
   * parent path to the subvolume
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  parentPath?: string | null;

  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Subvolume Patch Request properties
 */
model SubvolumePatchRequest {
  /**
   * Subvolume Properties
   */
  properties?: SubvolumePatchParams;
}

/**
 * Parameters with which a subvolume can be updated
 */
model SubvolumePatchParams {
  /**
   * Truncate subvolume to the provided size in bytes
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  size?: int64 | null;

  /**
   * path to the subvolume
   */
  path?: string;
}

/**
 * Result of the post subvolume and action is to get metadata of the subvolume.
 */
model SubvolumeModel {
  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * It represents the minimal properties of the subvolume.
   */
  properties?: SubvolumeModelProperties;
}

/**
 * Properties which represents actual subvolume model which is stored as a file in the system.
 */
model SubvolumeModelProperties {
  /**
   * Path to the subvolume
   */
  path?: string;

  /**
   * Path to the parent subvolume
   */
  parentPath?: string;

  /**
   * Size of subvolume
   */
  size?: int64;

  /**
   * Bytes used
   */
  bytesUsed?: int64;

  /**
   * Permissions of the subvolume
   */
  permissions?: string;

  /**
   * Creation time and date
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTimeStamp?: utcDateTime;

  /**
   * Most recent access time and date
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  accessedTimeStamp?: utcDateTime;

  /**
   * Most recent modification time and date
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedTimeStamp?: utcDateTime;

  /**
   * Most recent change time and date
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTimeStamp?: utcDateTime;

  /**
   * Azure lifecycle management
   */
  provisioningState?: string;
}

@armResourceOperations
interface SubvolumeInfos {
  /**
   * Returns the path associated with the subvolumeName provided
   */
  get is ArmResourceRead<SubvolumeInfo>;

  /**
   * Creates a subvolume in the path or clones the subvolume mentioned in the parentPath
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    SubvolumeInfo,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Returns a list of the subvolumes in the volume
   */
  listByVolume is ArmResourceListByParent<
    SubvolumeInfo,
    Response = ArmResponse<SubvolumesList>
  >;

  /**
   * Get details of the specified subvolume
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
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
