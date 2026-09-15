import "../AppConfiguration/main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using AzureAppConfiguration;

namespace SdkCustomizations;

@@clientName(AzureAppConfiguration, "FeatureFlagClient");
@@clientName(Azure.Core.Foundations.Error, "CommonError");

// Hide configuration operations from the feature-flag-only package.
@@scope(getKeys, "!(csharp, python, java, javascript, go)");
@@scope(checkKeys, "!(csharp, python, java, javascript, go)");
@@scope(getKeyValues, "!(csharp, python, java, javascript, go)");
@@scope(checkKeyValues, "!(csharp, python, java, javascript, go)");
@@scope(getKeyValue, "!(csharp, python, java, javascript, go)");
@@scope(putKeyValue, "!(csharp, python, java, javascript, go)");
@@scope(deleteKeyValue, "!(csharp, python, java, javascript, go)");
@@scope(checkKeyValue, "!(csharp, python, java, javascript, go)");
@@scope(getSnapshots, "!(csharp, python, java, javascript, go)");
@@scope(checkSnapshots, "!(csharp, python, java, javascript, go)");
@@scope(getSnapshot, "!(csharp, python, java, javascript, go)");
@@scope(createSnapshot, "!(csharp, python, java, javascript, go)");
@@scope(updateSnapshot, "!(csharp, python, java, javascript, go)");
@@scope(checkSnapshot, "!(csharp, python, java, javascript, go)");
@@scope(checkLabels, "!(csharp, python, java, javascript, go)");
@@scope(putLock, "!(csharp, python, java, javascript, go)");
@@scope(deleteLock, "!(csharp, python, java, javascript, go)");
@@scope(getRevisions, "!(csharp, python, java, javascript, go)");
@@scope(checkRevisions, "!(csharp, python, java, javascript, go)");
@@scope(getOperationDetails, "!(csharp, python, java, javascript, go)");

// .NET specific customizations
@@access(getFeatureFlag, Access.internal, "csharp");
@@access(checkFeatureFlag, Access.internal, "csharp");
@@access(getFeatureFlags, Access.internal, "csharp");
@@access(checkFeatureFlags, Access.internal, "csharp");
@@access(putFeatureFlag, Access.internal, "csharp");
@@access(deleteFeatureFlag, Access.internal, "csharp");
@@access(getFeatureFlagRevisions, Access.internal, "csharp");
@@access(checkFeatureFlagRevisions, Access.internal, "csharp");

@@alternateType(FeatureFlagRevisionsRequestParams.select, string[], "csharp");
@@alternateType(FeatureFlagsRequestParams.select, string[], "csharp");
@@alternateType(FeatureFlagFilter.parameters, Record<string>, "csharp");

// Surface the feature flag etag as Azure.ETag to match ConfigurationSetting.ETag.
@@alternateType(FeatureFlag.etag, Azure.Core.eTag, "csharp");
