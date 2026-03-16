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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy TrackedResourceWithOptionalLocation for back compatibility"
@parentResource(VaultResource)
model BackupEngineBaseResource
  is TrackedResourceWithOptionalLocation<BackupEngineBase> {
  ...ResourceNameParameter<
    Resource = BackupEngineBaseResource,
    KeyName = "backupEngineName",
    SegmentName = "backupEngines",
    NamePattern = ""
  >;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
