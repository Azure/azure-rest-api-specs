import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using AzureAppConfiguration;

namespace SdkCustomizations;

// Java specific customizations
@@clientName(AzureAppConfiguration, "AzureAppConfiguration", "java");
@@clientName(Azure.Core.Foundations.Error, "CommonError", "java");
@@clientName(getKeyValues, "listConfigurationSettings", "java");
@@clientName(putKeyValue, "setConfigurationSetting", "java");
@@clientName(deleteKeyValue, "deleteConfigurationSetting", "java");

// Python specific customizations
@@clientName(KeyValueFields, "ConfigurationSettingFields", "python");
@@clientName(CompositionType, "SnapshotComposition", "python");
@@access(putKeyValue, Access.internal, "python");
@@access(updateSnapshot, Access.internal, "python");
@@access(SnapshotUpdateParameters, Access.public, "python");
@@clientName(Azure.Core.Foundations.Error, "CommonError", "python");

// Hide feature-flag operations from the config-only package.
@@scope(getFeatureFlags, "!(csharp, python, java, javascript, go)");
@@scope(checkFeatureFlags, "!(csharp, python, java, javascript, go)");
@@scope(getFeatureFlag, "!(csharp, python, java, javascript, go)");
@@scope(checkFeatureFlag, "!(csharp, python, java, javascript, go)");
@@scope(putFeatureFlag, "!(csharp, python, java, javascript, go)");
@@scope(deleteFeatureFlag, "!(csharp, python, java, javascript, go)");
@@scope(getFeatureFlagRevisions, "!(csharp, python, java, javascript, go)");
@@scope(checkFeatureFlagRevisions, "!(csharp, python, java, javascript, go)");

// Preserve the existing AutoRest operation grouping without including feature
// flag operations in any supported configuration SDK package.
@@clientLocation(
  getFeatureFlag,
  "FeatureFlagClient",
  "!(csharp, python, java, javascript, go)"
);
@@clientLocation(
  checkFeatureFlag,
  "FeatureFlagClient",
  "!(csharp, python, java, javascript, go)"
);
@@clientLocation(
  getFeatureFlags,
  "FeatureFlagClient",
  "!(csharp, python, java, javascript, go)"
);
@@clientLocation(
  checkFeatureFlags,
  "FeatureFlagClient",
  "!(csharp, python, java, javascript, go)"
);
@@clientLocation(
  putFeatureFlag,
  "FeatureFlagClient",
  "!(csharp, python, java, javascript, go)"
);
@@clientLocation(
  deleteFeatureFlag,
  "FeatureFlagClient",
  "!(csharp, python, java, javascript, go)"
);
@@clientLocation(
  getFeatureFlagRevisions,
  "FeatureFlagClient",
  "!(csharp, python, java, javascript, go)"
);
@@clientLocation(
  checkFeatureFlagRevisions,
  "FeatureFlagClient",
  "!(csharp, python, java, javascript, go)"
);

// .NET specific customizations

// Method renames
@@clientName(getKeyValue, "GetConfigurationSetting", "csharp");
@@clientName(getKeyValues, "GetConfigurationSettings", "csharp");
@@clientName(putKeyValue, "SetConfigurationSettingInternal", "csharp");
@@clientName(deleteKeyValue, "DeleteConfigurationSetting", "csharp");
@@clientName(updateSnapshot, "UpdateSnapshotStatus", "csharp");
@@clientName(putLock, "CreateReadOnlyLock", "csharp");
@@clientName(deleteLock, "DeleteReadOnlyLock", "csharp");
@@clientName(Error, "AppConfigurationError", "csharp");

// Access changes key values
@@access(putKeyValue, Access.internal, "csharp");
@@access(putLock, Access.internal, "csharp");
@@access(createSnapshot, Access.internal, "csharp");
@@access(deleteKeyValue, Access.internal, "csharp");
@@access(deleteLock, Access.internal, "csharp");
@@access(getKeyValue, Access.internal, "csharp");
@@access(getSnapshot, Access.internal, "csharp");
@@access(updateSnapshot, Access.internal, "csharp");

// Alternate types for select parameters
@@alternateType(KeyValuesRequestParams.select, string[], "csharp");
@@alternateType(RevisionsRequestParams.select, string[], "csharp");

// TypeScript specific customizations
@@clientName(Snapshot.expires, "expiresOn", "javascript");
@@clientName(Snapshot.created, "createdOn", "javascript");
@@clientName(
  Snapshot.retentionPeriod,
  "retentionPeriodInSeconds",
  "javascript"
);
@@clientName(Snapshot.size, "sizeInBytes", "javascript");
@@clientName(KeyValueFilter.key, "keyFilter", "javascript");
@@clientName(KeyValueFilter.label, "labelFilter", "javascript");
@@clientName(KeyValueFilter.tags, "tagsFilter", "javascript");
@@clientName(KeyValueFilter, "ConfigurationSettingsFilter", "javascript");
@@clientName(Snapshot, "ConfigurationSnapshot", "javascript");
@@clientName(AzureAppConfiguration, "AppConfigurationClient", "javascript");

// Go specific customizations
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Needs fix: https://github.com/microsoft/typespec/issues/2853"
#suppress "@azure-tools/typespec-azure-core/documentation-required"
union PutKeyValueRequestContentTypeGo {
  "application/vnd.microsoft.appconfig.kv+json",
  "application/vnd.microsoft.appconfig.kvset+json",
  "application/json",
  "text/json",

  @clientName("applicationAnyJson", "go")
  "application/*+json",

  "application/json-patch+json",
}
@@clientName(AppConfigResponseHeaders.etagHeader, "ETag", "go");
@@clientName(KeyValueFields, "SettingFields", "go");
@@clientName(KeyValueListResult.etag, "ETag", "go");
@@clientName(
  PutKeyValueRequestContentTypeGo,
  "PutKeyValueRequestContentType",
  "go"
);
@@clientName(SnapshotFields.etag, "ETag", "go");
@@alternateType(
  PutKeyValueRequestContentType.contentType,
  PutKeyValueRequestContentTypeGo,
  "go"
);
@@access(PutKeyValueRequestContentTypeGo, Access.internal, "!go");
@@scope(PutKeyValueRequestContentTypeGo, "go");
