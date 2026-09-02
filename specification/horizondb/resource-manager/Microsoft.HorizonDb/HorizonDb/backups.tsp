import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@added(Versions.v2026_10_01)
@doc("Represents an available backup for a HorizonDB cluster.")
@parentResource(Cluster)
model Backup is Azure.ResourceManager.ProxyResource<BackupResourceProperties> {
  @doc("The name of the HorizonDB backup.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{0,62}$")
  @minLength(1)
  @maxLength(63)
  @key("backupName")
  @path
  @segment("backups")
  name: string;
}

@added(Versions.v2026_10_01)
@doc("Backup configuration properties for a HorizonDB cluster.")
model BackupProperties {
  @doc("The geo-redundancy state.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  geoRedundancy: GeoRedundancyState;

  @doc("The number of days that automatic backups are retained. The service defaults to 7 days when this property is omitted.")
  @minValue(1)
  @maxValue(35)
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  retentionDays?: int32 = 7;

  @added(Versions.v2026_10_01)
  @doc("The earliest point in time, in UTC, to which the cluster can currently be restored.")
  @visibility(Lifecycle.Read)
  earliestRestorePointUtc?: utcDateTime;
}

@added(Versions.v2026_10_01)
@doc("Backup configuration properties for updating a HorizonDB cluster.")
model BackupPropertiesForPatchUpdate {
  @doc("The number of days that automatic backups are retained.")
  @minValue(1)
  @maxValue(35)
  @visibility(Lifecycle.Update)
  retentionDays?: int32;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Backups are immutable point-in-time records and do not have a resource provisioning state."
@added(Versions.v2026_10_01)
@doc("Properties of an available HorizonDB backup.")
model BackupResourceProperties {
  @doc("The date and time when the backup was taken, in UTC.")
  @visibility(Lifecycle.Read)
  takenAtUtc: utcDateTime;

  @doc("The PostgreSQL version of the backed-up cluster.")
  @visibility(Lifecycle.Read)
  postgreSqlVersion: PostgreSqlVersion;

  @doc("The type of the backup.")
  @visibility(Lifecycle.Read)
  backupType: BackupType;

  @doc("The date and time when an automatic backup expires, in UTC. This property can be absent for backup types that do not expire automatically.")
  @visibility(Lifecycle.Read)
  expiredAtUtc?: utcDateTime;
}

@added(Versions.v2026_10_01)
@doc("Indicates the geo-redundancy state.")
union GeoRedundancyState {
  string,

  @doc("Geo-redundancy is enabled")
  Enabled: "Enabled",

  @doc("Geo-redundancy is disabled")
  Disabled: "Disabled",
}

@added(Versions.v2026_10_01)
@doc("The type of a HorizonDB backup. New values may be added over time.")
union BackupType {
  string,

  /** A backup created automatically by the HorizonDB service. */
  System: "System",

  /** A backup created at a customer's request. */
  @added(Versions.v2027_03_01_preview)
  User: "User",
}

@added(Versions.v2026_10_01)
@doc("Backup operations for HorizonDB clusters.")
@armResourceOperations
interface Backups {
  @doc("Gets an available backup for a HorizonDB cluster. Expired automatic backups are not available through this operation.")
  get is ArmResourceRead<Backup>;

  @added(Versions.v2027_03_01_preview)
  @doc("Creates a user backup with the name specified in the request path. Backup properties are service-generated and cannot be supplied by the caller.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is Azure.ResourceManager.Legacy.CreateOrReplaceAsync<
    Backup,
    void,
    OptionalRequestBody = true
  >;

  @added(Versions.v2027_03_01_preview)
  @doc("Deletes a user-created backup. The request fails with 409 Conflict when the specified backup is an automatic backup. Automatic backups cannot be deleted explicitly and are removed only when they reach their expiry date.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Backup,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @doc("Lists the backups available for a HorizonDB cluster. Expired automatic backups are omitted.")
  list is ArmResourceListByParent<Backup>;
}
