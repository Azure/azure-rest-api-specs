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

namespace Microsoft.Web;
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

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface MigrateMySqlStatusOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of web app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** undefined */
        @path
        @segment("migratemysql")
        @key
        status: "status",
      }
    > {}

@armResourceOperations
interface MigrateMySqlStatuses {
  /**
   * Description for Returns the status of MySql in app migration, if one is active, and whether or not MySql in app is enabled
   */
  @summary("Returns the status of MySql in app migration, if one is active, and whether or not MySql in app is enabled")
  getMigrateMySqlStatus is MigrateMySqlStatusOps.Read<
    MigrateMySqlStatus,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface MigrateMySqlStatusOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of web app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** undefined */
        @path
        @segment("migratemysql")
        @key
        status: "status",
      }
    > {}

@armResourceOperations
interface MigrateMySqlStatusOperationGroup {
  /**
   * Description for Returns the status of MySql in app migration, if one is active, and whether or not MySql in app is enabled
   */
  @summary("Returns the status of MySql in app migration, if one is active, and whether or not MySql in app is enabled")
  getMigrateMySqlStatusSlot is MigrateMySqlStatusOperationGroupOps.Read<
    MigrateMySqlStatus,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(MigrateMySqlStatus.name, "");
@@doc(MigrateMySqlStatus.properties,
  "MigrateMySqlStatus resource specific properties"
);
