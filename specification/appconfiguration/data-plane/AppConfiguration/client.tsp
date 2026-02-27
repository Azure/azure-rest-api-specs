import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using AzureAppConfiguration;

namespace SdkCustomizations;

// Python specific customizations
@@clientName(KeyValueFields, "ConfigurationSettingFields", "python");
@@clientName(CompositionType, "SnapshotComposition", "python");
@@access(putKeyValue, Access.internal, "python");
@@access(updateSnapshot, Access.internal, "python");
@@access(SnapshotUpdateParameters, Access.public, "python");

// .NET specific customizations
@@clientName(getKeyValue, "GetConfigurationSetting", "csharp");
@@clientName(getKeyValues, "GetConfigurationSettings", "csharp");
@@clientName(putKeyValue, "SetConfigurationSettingInternal", "csharp");
@@clientName(deleteKeyValue, "DeleteConfigurationSetting", "csharp");
@@clientName(updateSnapshot, "UpdateSnapshotStatus", "csharp");
@@clientName(putLock, "CreateReadOnlyLock", "csharp");
@@clientName(deleteLock, "DeleteReadOnlyLock", "csharp");
@@clientName(Error, "AppConfigurationError", "csharp");

@@access(putKeyValue, Access.internal, "csharp");
@@access(putLock, Access.internal, "csharp");
@@access(createSnapshot, Access.internal, "csharp");
@@access(deleteKeyValue, Access.internal, "csharp");
@@access(deleteLock, Access.internal, "csharp");
@@access(getKeyValue, Access.internal, "csharp");
@@access(getSnapshot, Access.internal, "csharp");
@@access(updateSnapshot, Access.internal, "csharp");

@@alternateType(KeyValuesRequestParams.select, string[], "csharp");
@@alternateType(RevisionsRequestParams.select, string[], "csharp");
