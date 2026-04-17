import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using AzureAppConfiguration;

@client({
  name: "AzureAppConfigurationClient",
  service: AzureAppConfiguration,
})
namespace SdkCustomizations;

// Java specific customizations
@@clientName(Azure.Core.Foundations.Error, "CommonError", "java");

// Python specific customizations
@@clientName(KeyValueFields, "ConfigurationSettingFields", "python");
@@clientName(CompositionType, "SnapshotComposition", "python");
@@access(putKeyValue, Access.internal, "python");
@@access(updateSnapshot, Access.internal, "python");
@@access(SnapshotUpdateParameters, Access.public, "python");

//
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

// Access changes feature flags
@@access(getFeatureFlag, Access.internal, "csharp");
@@access(checkFeatureFlag, Access.internal, "csharp");
@@access(getFeatureFlags, Access.internal, "csharp");
@@access(checkFeatureFlags, Access.internal, "csharp");
@@access(putFeatureFlag, Access.internal, "csharp");
@@access(deleteFeatureFlag, Access.internal, "csharp");
@@access(getFeatureFlagRevisions, Access.internal, "csharp");
@@access(checkFeatureFlagRevisions, Access.internal, "csharp");

// Alternate types for select parameters
@@alternateType(FeatureFlagRevisionsRequestParams.select, string[], "csharp");
@@alternateType(FeatureFlagsRequestParams.select, string[], "csharp");
@@alternateType(KeyValuesRequestParams.select, string[], "csharp");
@@alternateType(RevisionsRequestParams.select, string[], "csharp");

@@clientName(Azure.Core.Foundations.Error, "CommonError", "python");
