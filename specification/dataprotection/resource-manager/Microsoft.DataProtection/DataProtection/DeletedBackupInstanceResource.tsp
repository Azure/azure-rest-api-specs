import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "./BackupVaultResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;
/**
 * Deleted Backup Instance
 */
@parentResource(BackupVaultResource)
model DeletedBackupInstanceResource
  is Azure.ResourceManager.ProxyResource<DeletedBackupInstance> {
  ...ResourceNameParameter<
    Resource = DeletedBackupInstanceResource,
    KeyName = "backupInstanceName",
    SegmentName = "deletedBackupInstances",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DeletedBackupInstanceResources {
  /**
   * Gets a deleted backup instance with name in a backup vault
   */
  get is ArmResourceRead<
    Resource = DeletedBackupInstanceResource,
    Error = CloudError
  >;

  /**
   * Gets deleted backup instances belonging to a backup vault
   */
  @list
  list is ArmResourceListByParent<
    DeletedBackupInstanceResource,
    Response = ArmResponse<DeletedBackupInstanceResourceList>,
    Error = CloudError
  >;

  undelete is ArmResourceActionAsync<
    DeletedBackupInstanceResource,
    void,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>,
    Error = CloudError
  >;
}

@@doc(DeletedBackupInstanceResource.name,
  "The name of the deleted backup instance"
);
@@doc(DeletedBackupInstanceResource.properties,
  "DeletedBackupInstanceResource properties"
);
