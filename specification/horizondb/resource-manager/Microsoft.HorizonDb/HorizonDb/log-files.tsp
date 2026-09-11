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

@added(Versions.v2026_10_01_preview)
@doc("The configuration for capturing one type of HorizonDB log.")
@parentResource(Cluster)
model LogCaptureConfiguration
  is Azure.ResourceManager.ProxyResource<LogCaptureConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = LogCaptureConfiguration,
    KeyName = "logCaptureConfigurationName",
    SegmentName = "logCaptureConfigurations",
    NamePattern = "^PostgreSqlServer$"
  >;
}

@added(Versions.v2026_10_01_preview)
@doc("The settings for capturing a specific type of HorizonDB log.")
model LogCaptureConfigurationProperties {
  @doc("Specifies whether HorizonDB captures this type of log. Disabling capture stops the production of new log files; existing files remain available until their retention period expires.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  state: LogCaptureState;

  @doc("The number of days captured log files are retained.")
  @minValue(1)
  @maxValue(35)
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  retentionDays: int32;

  @doc("The provisioning state of the log capture configuration.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_10_01_preview)
@doc("Properties for updating the log capture configuration. Omitted properties preserve their current values.")
model LogCaptureConfigurationPropertiesForPatchUpdate {
  @doc("Specifies whether HorizonDB captures this type of log. Disabling capture stops the production of new log files; existing files remain available until their retention period expires.")
  @visibility(Lifecycle.Update)
  state?: LogCaptureState;

  @doc("The number of days captured log files are retained.")
  @minValue(1)
  @maxValue(35)
  @visibility(Lifecycle.Update)
  retentionDays?: int32;
}

@added(Versions.v2026_10_01_preview)
@doc("A sparse update request for a log capture configuration.")
model LogCaptureConfigurationForPatchUpdate {
  @doc("The log capture properties to update.")
  properties?: LogCaptureConfigurationPropertiesForPatchUpdate;
}

@added(Versions.v2026_10_01_preview)
@doc("Specifies whether HorizonDB captures log files.")
union LogCaptureState {
  string,

  @doc("Log capture is enabled.")
  Enabled: "Enabled",

  @doc("Log capture is disabled.")
  Disabled: "Disabled",
}

@added(Versions.v2026_10_01_preview)
@doc("A service-generated log file captured for a HorizonDB cluster.")
@parentResource(Cluster)
model LogFile is Azure.ResourceManager.ProxyResource<LogFileProperties> {
  ...ResourceNameParameter<
    Resource = LogFile,
    KeyName = "logFileName",
    SegmentName = "logFiles",
    NamePattern = "^[a-zA-Z0-9](?:[-._a-zA-Z0-9]{0,253}[a-zA-Z0-9])?$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Log files are immutable or actively written service-generated artifacts and do not have an independent provisioning lifecycle."
@added(Versions.v2026_10_01_preview)
@doc("Metadata for a service-generated HorizonDB log file.")
model LogFileProperties {
  @doc("The type of the captured log file.")
  @visibility(Lifecycle.Read)
  logType: LogFileType;

  @doc("The date and time when the log file was created, in UTC.")
  @visibility(Lifecycle.Read)
  createdAtUtc: utcDateTime;

  @doc("The date and time when the log file was last modified, in UTC.")
  @visibility(Lifecycle.Read)
  lastModifiedAtUtc: utcDateTime;

  @doc("The date and time when the log file expires according to its retention period, in UTC.")
  @visibility(Lifecycle.Read)
  retentionExpiresAtUtc: utcDateTime;

  @doc("Whether the platform can still append to or otherwise modify the log file.")
  @visibility(Lifecycle.Read)
  isMutable: boolean;

  @doc("The size of the log file in kilobytes, where one kilobyte is 1024 bytes.")
  @minValue(0)
  @visibility(Lifecycle.Read)
  sizeInKilobytes: int64;

  @doc("The name of the HorizonDB pool that generated the log file.")
  @visibility(Lifecycle.Read)
  poolName: PoolName;

  @doc("The name of the HorizonDB node that generated the log file.")
  @visibility(Lifecycle.Read)
  nodeName: string;
}

@added(Versions.v2026_10_01_preview)
@doc("The type of a captured HorizonDB log file.")
union LogFileType {
  string,

  @doc("A PostgreSQL server log file.")
  PostgreSqlServer: "PostgreSqlServer",
}

@added(Versions.v2026_10_01_preview)
@doc("A short-lived signed URL for downloading a captured log file.")
model LogFileDownloadUrl {
  @doc("A short-lived signed URL from which the original log file can be downloaded.")
  @secret
  downloadUri: url;

  @doc("The date and time when the signed download URL expires, in UTC.")
  expiresAtUtc: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "A log capture configuration is disabled through its state property rather than deleted."
@added(Versions.v2026_10_01_preview)
@doc("Operations for HorizonDB log capture configurations.")
@armResourceOperations
interface LogCaptureConfigurations {
  @doc("Gets a log capture configuration for a HorizonDB cluster.")
  get is ArmResourceRead<LogCaptureConfiguration>;

  @doc("Creates or replaces a log capture configuration for a HorizonDB cluster.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LogCaptureConfiguration,
    LroHeaders = HorizonDbResourceLroHeaders<LogCaptureConfiguration>,
    Response =
      | HorizonDbResourceUpdatedLroResponse<LogCaptureConfiguration>
      | ArmResourceCreatedResponse<
          LogCaptureConfiguration,
          HorizonDbResourceLroHeaders<LogCaptureConfiguration>
        >
  >;

  @doc("Updates a log capture configuration. Omitted properties preserve their current values.")
  update is ArmCustomPatchAsync<
    LogCaptureConfiguration,
    LogCaptureConfigurationForPatchUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = LogCaptureConfiguration> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Lists the log capture configurations for a HorizonDB cluster.")
  list is ArmResourceListByParent<LogCaptureConfiguration>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Log files are service-generated and expire according to the configured retention period; customers cannot delete them independently."
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-put-operation" "Log files are read-only service-generated artifacts and cannot be created or replaced independently."
@added(Versions.v2026_10_01_preview)
@doc("Operations for captured HorizonDB log files.")
@armResourceOperations
interface LogFiles {
  @doc("Gets metadata for a captured HorizonDB log file.")
  get is ArmResourceRead<LogFile>;

  @doc("Lists captured log files for a HorizonDB cluster.")
  list is ArmResourceListByParent<LogFile>;

  @doc("Gets a short-lived signed URL for downloading a captured log file. The signed URL is returned only by this action so routine resource GET and LIST responses do not expose bearer credentials.")
  listDownloadUrls is ArmResourceActionSync<LogFile, void, LogFileDownloadUrl>;
}
