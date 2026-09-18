import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using AppConfigurationFeatureFlag;

namespace SdkCustomizations;

@@clientName(AppConfigurationFeatureFlag, "FeatureFlagClient");
@@clientName(Azure.Core.Foundations.Error, "CommonError");

@@clientLocation(getFeatureFlag, "FeatureFlagClient");
@@clientLocation(checkFeatureFlag, "FeatureFlagClient");
@@clientLocation(getFeatureFlags, "FeatureFlagClient");
@@clientLocation(checkFeatureFlags, "FeatureFlagClient");
@@clientLocation(putFeatureFlag, "FeatureFlagClient");
@@clientLocation(deleteFeatureFlag, "FeatureFlagClient");
@@clientLocation(getFeatureFlagRevisions, "FeatureFlagClient");
@@clientLocation(checkFeatureFlagRevisions, "FeatureFlagClient");

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
