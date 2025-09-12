import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.RecoveryServices;
/**
 * The base backup engine class. All workload specific backup engines derive from this class.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(VaultResource)
@Azure.ResourceManager.Private.armResourceInternal(BackupEngineBase)
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model BackupEngineBaseResource extends Resource {
  ...ResourceNameParameter<
    Resource = BackupEngineBaseResource,
    KeyName = "backupEngineName",
    SegmentName = "backupEngines",
    NamePattern = ""
  >;

  /**
   * BackupEngineBaseResource properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: BackupEngineBase;
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
