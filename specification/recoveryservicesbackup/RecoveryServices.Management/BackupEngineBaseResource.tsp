import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * The base backup engine class. All workload specific backup engines derive from this class.
 */
@parentResource(VaultResource)
model BackupEngineBaseResource
  is Azure.ResourceManager.TrackedResource<BackupEngineBase> {
  ...ResourceNameParameter<
    Resource = BackupEngineBaseResource,
    KeyName = "backupEngineName",
    SegmentName = "backupEngines",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BackupEngines {
  /**
   * Returns backup management server registered to Recovery Services Vault.
   */
  get is ArmResourceRead<
    BackupEngineBaseResource,
    Parameters = {
      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;

      /**
       * skipToken Filter.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  /**
   * Backup management servers registered to Recovery Services Vault. Returns a pageable list of servers.
   */
  list is ArmResourceListByParent<
    BackupEngineBaseResource,
    Parameters = {
      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;

      /**
       * skipToken Filter.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<BackupEngineBaseResourceList>
  >;
}

@@doc(BackupEngineBaseResource.name, "Name of the backup management server.");
@@doc(BackupEngineBaseResource.properties,
  "BackupEngineBaseResource properties"
);
