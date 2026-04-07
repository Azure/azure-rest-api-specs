import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Legacy;
using TypeSpec.Http;

namespace Microsoft.RecoveryServices;
/**
 * The base backup engine class. All workload specific backup engines derive from this class.
 */
@parentResource(VaultResource)
model BackupEngineBaseResource is ProxyResource<BackupEngineBase> {
  ...ResourceNameParameter<
    Resource = BackupEngineBaseResource,
    KeyName = "backupEngineName",
    SegmentName = "backupEngines",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Optional location"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: Azure.Core.azureLocation;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Backward compatibility for optional ETag"
  eTag?: string;
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
  @list
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
