import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforMySQL;
/**
 * Server backup properties
 */
@parentResource(Server)
model ServerBackupV2
  is Azure.ResourceManager.ProxyResource<ServerBackupPropertiesV2> {
  ...ResourceNameParameter<
    Resource = ServerBackupV2,
    KeyName = "backupName",
    SegmentName = "backupsV2",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ServerBackupV2sOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /**
         * The name of the server.
         */
        @path
        @segment("flexibleServers")
        @pattern("^[a-z0-9][-a-z0-9]*(?<!-)$")
        @minLength(1)
        @maxLength(63)
        serverName: string,

        /**
         * The name of the backup.
         */
        @path
        @segment("backupsV2")
        @pattern("^[-\\w\\._]+$")
        backupName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface LongRunningBackups {
  /**
   * Get backup for a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<ServerBackupV2>;

  /**
   * List all the backups for a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  list is ArmResourceListByParent<
    ServerBackupV2,
    Response = ArmResponse<ServerBackupV2ListResult>
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface LongRunningBackup {
  /**
   * Create backup for a given server with specified backup name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ServerBackupV2sOps.CreateOrUpdateAsync<
    ServerBackupV2,
    Response = ArmResourceUpdatedResponse<ServerBackupV2> | ArmResourceCreatedResponse<ServerBackupV2> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ServerBackupV2> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OptionalRequestBody = true
  >;
}

@@doc(ServerBackupV2.name, "The name of the backup.");
@@doc(ServerBackupV2.properties, "The properties of a server backup.");
@@doc(LongRunningBackup.create::parameters.resource,
  "The required parameters for creating and exporting backup of the given server."
);
