import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * MySQL migration status.
 */
@singleton("status")
@parentResource(Site)
model MigrateMySqlStatus
  is Azure.ResourceManager.ProxyResource<MigrateMySqlStatusProperties> {
  ...ResourceNameParameter<
    Resource = MigrateMySqlStatus,
    KeyName = "migratemysql",
    SegmentName = "migratemysql",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MigrateMySqlStatusOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = MigrateMySqlStatus,
        KeyName = "status",
        SegmentName = "migratemysql",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface MigrateMySqlStatuses {
  /**
   * Description for Returns the status of MySql in app migration, if one is active, and whether or not MySql in app is enabled
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetMigrateMySqlStatus")
  getMigrateMySqlStatus is MigrateMySqlStatusOps.Read<MigrateMySqlStatus>;
}
@armResourceOperations
interface MigrateMySqlStatusOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "slot",
          SegmentName = "slots",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = MigrateMySqlStatus,
        KeyName = "status",
        SegmentName = "migratemysql",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface MigrateMySqlStatusOperationGroup {
  /**
   * Description for Returns the status of MySql in app migration, if one is active, and whether or not MySql in app is enabled
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetMigrateMySqlStatusSlot")
  getMigrateMySqlStatusSlot is MigrateMySqlStatusOperationGroupOps.Read<MigrateMySqlStatus>;
}

@@doc(MigrateMySqlStatus.name, "");
@@doc(MigrateMySqlStatus.properties,
  "MigrateMySqlStatus resource specific properties"
);
