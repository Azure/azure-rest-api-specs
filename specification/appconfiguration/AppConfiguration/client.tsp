import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using Azure.Core;
using Azure.ClientGenerator.Core;
using AzureAppConfiguration;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace SdkCustomizations;

@@alternateType(KeyValueListResult.`@nextLink`, string, "!csharp");

// Python specific customizations
@@clientName(KeyValueFields, "ConfigurationSettingFields", "python");
@@clientName(CompositionType, "SnapshotComposition", "python");
@@access(putKeyValue, Access.internal, "python");
@@access(updateSnapshot, Access.internal, "python");
@@access(SnapshotUpdateParameters, Access.public, "python");

// .NET specific customizations
//@@clientName(SnapshotStatus, "ConfigurationSnapshotStatus", "csharp");
//@@clientName(AzureAppConfiguration, "ConfigurationClient", "csharp");
@@clientName(getKeyValue, "GetConfigurationSetting", "csharp");
@@clientName(getKeyValues, "GetConfigurationSettings", "csharp");
@@clientName(putKeyValue, "SetConfigurationSettingInternal", "csharp");
@@clientName(deleteKeyValue, "DeleteConfigurationSetting", "csharp");
@@clientName(updateSnapshot, "UpdateSnapshotStatus", "csharp");
@@clientName(putLock, "CreateReadOnlyLock", "csharp");
@@clientName(deleteLock, "DeleteReadOnlyLock", "csharp");

@@access(putKeyValue, Access.internal, "csharp");
// @@access(deleteKeyValue, Access.internal, "csharp");
// @@access(getSnapshot, Access.internal, "csharp");
// @@access(createSnapshot, Access.internal, "csharp");
// @@access(updateSnapshot, Access.internal, "csharp");


@@alternateType(KeyValuesRequestParams.select, string[], "csharp");
@@alternateType(RevisionsRequestParams.select, string[], "csharp");
@@override(getRevisions, getRevisionsCustom, "csharp");

// Custom override for the getRevisions operation to reinject the request parameters in the next link
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
@summary("Gets a list of key-value revisions.")
@doc("Gets a list of key-value revisions.")
@get
op getRevisionsCustom is AppConfigOperation<
  RevisionsRequestParams,
  KeyValueListResultCustom &
    AppConfigResponseHeaders &
    ContentTypeHeader<"application/vnd.microsoft.appconfig.kvset+json">
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Existing usage of legacy type"
@doc("The result of a list request.")
@pagedResult
model KeyValueListResultCustom {
  @doc("The collection value.")
  @items
  items?: KeyValue[];

  @doc("An identifier representing the returned state of the resource.")
  etag?: string;

  @doc("The URI that can be used to request the next set of paged results.")
  @nextLink
  `@nextLink`?: Azure.Core.Legacy.parameterizedNextLink<[SyncTokenHeader.syncToken, AcceptDatetimeHeader.acceptDatetime]>;
}

