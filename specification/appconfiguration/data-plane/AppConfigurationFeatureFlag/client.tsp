import "../AppConfiguration/main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using AzureAppConfiguration;

namespace SdkCustomizations;

@@clientName(AzureAppConfiguration, "FeatureFlagClient");
@@clientName(Azure.Core.Foundations.Error, "CommonError");

// Hide configuration operations from the feature-flag-only package.
@@scope(getKeys, "!(csharp, python, java, javascript, go, rust)");
@@scope(checkKeys, "!(csharp, python, java, javascript, go, rust)");
@@scope(getKeyValues, "!(csharp, python, java, javascript, go, rust)");
@@scope(checkKeyValues, "!(csharp, python, java, javascript, go, rust)");
@@scope(getKeyValue, "!(csharp, python, java, javascript, go, rust)");
@@scope(putKeyValue, "!(csharp, python, java, javascript, go, rust)");
@@scope(deleteKeyValue, "!(csharp, python, java, javascript, go, rust)");
@@scope(checkKeyValue, "!(csharp, python, java, javascript, go, rust)");
@@scope(getSnapshots, "!(csharp, python, java, javascript, go, rust)");
@@scope(checkSnapshots, "!(csharp, python, java, javascript, go, rust)");
@@scope(getSnapshot, "!(csharp, python, java, javascript, go, rust)");
@@scope(createSnapshot, "!(csharp, python, java, javascript, go, rust)");
@@scope(updateSnapshot, "!(csharp, python, java, javascript, go, rust)");
@@scope(checkSnapshot, "!(csharp, python, java, javascript, go, rust)");
@@scope(checkLabels, "!(csharp, python, java, javascript, go, rust)");
@@scope(putLock, "!(csharp, python, java, javascript, go, rust)");
@@scope(deleteLock, "!(csharp, python, java, javascript, go, rust)");
@@scope(getRevisions, "!(csharp, python, java, javascript, go, rust)");
@@scope(checkRevisions, "!(csharp, python, java, javascript, go, rust)");
@@scope(getOperationDetails, "!(csharp, python, java, javascript, go, rust)");

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
