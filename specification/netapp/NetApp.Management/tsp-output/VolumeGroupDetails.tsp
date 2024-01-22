import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
/**
 * Volume group resource for create
 */
@parentResource(NetAppAccount)
model VolumeGroupDetails is ProxyResource<VolumeGroupProperties> {
  /**
   * The name of the volumeGroup
   */
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$")
  @path
  @key("volumeGroupName")
  @segment("volumeGroups")
  name: string;
}

@armResourceOperations
@projectedName("client", "VolumeGroupDetails")
interface VolumeGroupDetailsOperationGroup {
  /**
   * Get details of the specified volume group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VolumeGroups_Get")
  get is ArmResourceRead<VolumeGroupDetails>;

  /**
   * Create a volume group along with specified volumes
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VolumeGroups_Create")
  create is ArmResourceCreateOrReplaceAsync<VolumeGroupDetails>;

  /**
   * Delete the specified volume group only if there are no volumes under volume group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VolumeGroups_Delete")
  delete is ArmResourceDeleteAsync<VolumeGroupDetails>;
}

@@projectedName(VolumeGroupDetailsOperationGroup.create::parameters.resource,
  "json",
  "body"
);
@@extension(VolumeGroupDetailsOperationGroup.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(VolumeGroupDetailsOperationGroup.create::parameters.resource,
  "Volume Group object supplied in the body of the operation."
);
