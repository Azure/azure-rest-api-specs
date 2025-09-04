import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
/**
 * Volume group resource for create
 */
@parentResource(NetAppAccount)
model VolumeGroupDetails
  is Azure.ResourceManager.ProxyResource<VolumeGroupProperties> {
  ...ResourceNameParameter<
    Resource = VolumeGroupDetails,
    KeyName = "volumeGroupName",
    SegmentName = "volumeGroups",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$"
  >;

  /**
   * Resource location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

@armResourceOperations
interface VolumeGroups {
  /**
   * Get details of the specified volume group
   */
  get is ArmResourceRead<VolumeGroupDetails>;

  /**
   * Create a volume group along with specified volumes
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceAsync<
    VolumeGroupDetails,
    Response = ArmResourceCreatedResponse<
      VolumeGroupDetails,
      ArmLroLocationHeader<FinalResult = VolumeGroupDetails> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Delete the specified volume group only if there are no volumes under volume group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    VolumeGroupDetails,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;
}

@@maxLength(VolumeGroupDetails.name, 64);
@@minLength(VolumeGroupDetails.name, 1);
@@doc(VolumeGroupDetails.name, "The name of the volumeGroup");
@@doc(VolumeGroupDetails.properties, "Volume group properties");
@@doc(VolumeGroups.create::parameters.resource,
  "Volume Group object supplied in the body of the operation."
);
