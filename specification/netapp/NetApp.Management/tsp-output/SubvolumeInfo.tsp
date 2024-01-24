import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Volume.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
/**
 * Subvolume Information properties
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Volume)
@Azure.ResourceManager.Private.armResourceInternal(SubvolumeProperties)
@includeInapplicableMetadataInPayload(false)
model SubvolumeInfo extends ProxyResourceBase {
  /**
   * The name of the subvolume.
   */
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$")
  @path
  @key("subvolumeName")
  @segment("subvolumes")
  name: string;

  /**
   * Subvolume Properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: SubvolumeProperties;
}

@armResourceOperations
interface SubvolumeInfos {
  /**
   * Returns the path associated with the subvolumeName provided
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Subvolumes_Get")
  get is ArmResourceRead<SubvolumeInfo>;

  /**
   * Creates a subvolume in the path or clones the subvolume mentioned in the parentPath
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Subvolumes_Create")
  create is ArmResourceCreateOrReplaceAsync<
    SubvolumeInfo,
    BaseParameters<SubvolumeInfo>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch a subvolume
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Subvolumes_Update")
  update is ArmCustomPatchAsync<
    SubvolumeInfo,
    SubvolumePatchRequest,
    BaseParameters<SubvolumeInfo>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete subvolume
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Subvolumes_Delete")
  delete is ArmResourceDeleteAsync<
    SubvolumeInfo,
    BaseParameters<SubvolumeInfo>,
    ArmAsyncOperationHeader
  >;

  /**
   * Returns a list of the subvolumes in the volume
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Subvolumes_ListByVolume")
  listByVolume is ArmResourceListByParent<SubvolumeInfo>;

  /**
   * Get details of the specified subvolume
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Subvolumes_GetMetadata")
  getMetadata is ArmResourceActionAsync<
    SubvolumeInfo,
    void,
    SubvolumeModel,
    BaseParameters<SubvolumeInfo>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(SubvolumeInfos.create::parameters.resource, "json", "body");
@@extension(SubvolumeInfos.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(SubvolumeInfos.create::parameters.resource,
  "Subvolume object supplied in the body of the operation."
);
@@projectedName(SubvolumeInfos.update::parameters.properties, "json", "body");
@@extension(SubvolumeInfos.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(SubvolumeInfos.update::parameters.properties,
  "Subvolume object supplied in the body of the operation."
);
