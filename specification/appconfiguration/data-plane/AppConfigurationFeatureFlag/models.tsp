import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

namespace AppConfigurationFeatureFlag;

@doc("Feature Flag fields.")
@added(Versions.v2026_05_01_preview)
union FeatureFlagFields {
  @doc("Name field.")
  name: "name",

  @doc("Enabled field.")
  enabled: "enabled",

  @doc("Label field.")
  label: "label",

  @doc("Description field.")
  description: "description",

  @doc("Conditions field.")
  conditions: "conditions",

  @doc("Variants field.")
  variants: "variants",

  @doc("Allocation field.")
  allocation: "allocation",

  @doc("Telemetry field.")
  telemetry: "telemetry",

  @doc("Tags field.")
  tags: "tags",

  @doc("Last modified field.")
  last_modified: "last_modified",

  @doc("Etag field.")
  etag: "etag",

  string,
}

@doc("Azure App Configuration error object.")
@error
model Error {
  @doc("The type of the error.")
  type?: string;

  @doc("A brief summary of the error.")
  title?: string;

  @doc("The name of the parameter that resulted in the error.")
  name?: string;

  @doc("A detailed description of the error.")
  detail?: string;

  @doc("The HTTP status code that the error maps to.")
  status?: int32;
}

@doc("The result of a Feature Flag list request.")
@added(Versions.v2026_05_01_preview)
model FeatureFlagListResult {
  @doc("The collection value.")
  @pageItems
  items?: FeatureFlag[];

  @doc("An identifier representing the returned state of the resource.")
  etag?: string;

  @doc("The URI that can be used to request the next set of paged results.")
  @nextLink
  `@nextLink`?: string;
}

@doc("A feature flag.")
@added(Versions.v2026_05_01_preview)
@resource("ff")
model FeatureFlag {
  @key
  @visibility(Lifecycle.Read)
  @doc("The name of the feature flag.")
  name: string;

  @doc("The enabled state of the feature flag.")
  enabled: boolean;

  @visibility(Lifecycle.Read)
  @doc("The label the feature flag belongs to.")
  label?: string;

  @doc("The description of the feature flag.")
  description?: string;

  @doc("The conditions of the feature flag.")
  conditions?: FeatureFlagConditions;

  @doc("The variants of the feature flag.")
  variants?: FeatureFlagVariantDefinition[];

  @doc("The allocation of the feature flag.")
  allocation?: FeatureFlagAllocation;

  @doc("The telemetry settings of the feature flag.")
  telemetry?: FeatureFlagTelemetryConfiguration;

  @doc("The tags of the feature flag")
  tags?: Record<string>;

  @doc("A date representing the last time the feature flag was modified.")
  @encodedName("application/json", "last_modified")
  @visibility(Lifecycle.Read)
  lastModified?: utcDateTime;

  @doc("A value representing the current state of the resource.")
  @visibility(Lifecycle.Read)
  etag?: string;
}

@doc("The conditions that must be met for the feature flag to be enabled.")
@added(Versions.v2026_05_01_preview)
model FeatureFlagConditions {
  @doc("The requirement type for the conditions.")
  @encodedName("application/json", "requirement_type")
  requirementType?: RequirementType;

  @doc("The filters that will conditionally enable or disable the flag.")
  filters?: FeatureFlagFilter[];
}

@doc("Controls how multiple feature-flag filters are combined.")
@added(Versions.v2026_05_01_preview)
union RequirementType {
  @doc("Enables the feature flag when any filter matches.")
  any: "Any",

  @doc("Enables the feature flag only when all filters match.")
  all: "All",

  string,
}

@doc("Feature Flag Filter object.")
@added(Versions.v2026_05_01_preview)
model FeatureFlagFilter {
  @doc("The name of the filter.")
  name: string;

  @doc("The parameters used by the filter")
  parameters?: Record<string>;
}

@doc("Feature Flag Variants object.")
@added(Versions.v2026_05_01_preview)
model FeatureFlagVariantDefinition {
  @doc("The name of the variant.")
  name: string;

  @doc("The value of the variant.")
  value?: string;

  @doc("The content type of the value stored within the key-value.")
  @encodedName("application/json", "content_type")
  contentType?: string;

  @doc("Determines if the variant should override the status of the flag.")
  @encodedName("application/json", "status_override")
  statusOverride?: StatusOverride;
}

@doc("Status Override.")
@added(Versions.v2026_05_01_preview)
union StatusOverride {
  @doc("No status override.")
  none: "None",

  @doc("Overrides the status to enabled.")
  enabled: "Enabled",

  @doc("Overrides the status to disabled.")
  disabled: "Disabled",

  string,
}

@doc("Defines how to allocate variants based on context.")
@added(Versions.v2026_05_01_preview)
model FeatureFlagAllocation {
  @doc("The default variant to use when disabled.")
  @encodedName("application/json", "default_when_disabled")
  defaultWhenDisabled?: string;

  @doc("The default variant to use when enabled but not allocated.")
  @encodedName("application/json", "default_when_enabled")
  defaultWhenEnabled?: string;

  @doc("Allocates percentiles to variants.")
  percentile?: PercentileAllocation[];

  @doc("Allocates users to variants.")
  user?: UserAllocation[];

  @doc("Allocates groups to variants.")
  group?: GroupAllocation[];

  @doc("The seed used for random allocation.")
  seed?: string;
}

@doc("Feature Flag PercentileAllocation object.")
@added(Versions.v2026_05_01_preview)
model PercentileAllocation {
  @doc("The variant to allocate these percentiles to.")
  variant: string;

  @maxValue(100)
  @minValue(0)
  @doc("The lower bounds for this percentile allocation.")
  from: float64;

  @maxValue(100)
  @minValue(0)
  @doc("The upper bounds for this percentile allocation.")
  to: float64;
}

@doc("Feature Flag UserAllocation object.")
@added(Versions.v2026_05_01_preview)
model UserAllocation {
  @doc("The variant to allocate these percentiles to.")
  variant: string;

  @doc("The users to get this variant.")
  users: string[];
}

@doc("Feature Flag GroupAllocation object.")
@added(Versions.v2026_05_01_preview)
model GroupAllocation {
  @doc("The variant to allocate these percentiles to.")
  variant: string;

  @doc("The groups to get this variant.")
  groups: string[];
}

@doc("Feature Flag Telemetry object.")
@added(Versions.v2026_05_01_preview)
model FeatureFlagTelemetryConfiguration {
  @doc("The enabled state of the telemetry.")
  enabled: boolean;

  @doc("The metadata to include on outbound telemetry")
  metadata?: Record<string>;
}

alias SyncTokenHeader = {
  @doc("Used to guarantee real-time consistency between requests.")
  @header("Sync-Token")
  syncToken?: string;
};

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Needs fix: https://github.com/microsoft/typespec/issues/2853"
alias ContentTypeHeader<T extends string> = {
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" "Avoiding creating a bunch of types for each content type."
  @doc("Content-Type header")
  @header("Content-Type")
  contentType?: T | "application/problem+json";
};

alias AppConfigResponseHeaders = {
  ...SyncTokenHeader;

  @doc("A value representing the current state of the resource.")
  @header("ETag")
  etagHeader?: string;
};

alias AfterQueryParam = {
  @doc("""
    Instructs the server to return elements that appear after the element referred
    to by the specified token.
    """)
  @query("After")
  after?: string;
};

alias AcceptDatetimeHeader = {
  @doc("""
    Requests the server to respond with the state of the resource at the specified
    time.
    """)
  @header("Accept-Datetime")
  acceptDatetime?: string;
};

alias SelectQueryParam<Type extends TypeSpec.Reflection.Model | string> = {
  @doc("Used to select what fields are present in the returned resource(s).")
  @query("$Select")
  select?: Type[];
};

alias NameQueryParam<TDoc extends valueof string> = {
  @doc(TDoc)
  @query("name")
  name?: string;
};

alias IfMatchHeader = {
  @doc("""
    Used to perform an operation only if the targeted resource's etag matches the
    value provided.
    """)
  @header("If-Match")
  ifMatch?: string;
};

alias IfNoneMatchHeader = {
  @doc("""
    Used to perform an operation only if the targeted resource's etag does not
    match the value provided.
    """)
  @header("If-None-Match")
  ifNoneMatch?: string;
};

alias LabelQueryParam<TDoc extends valueof string> = {
  @doc(TDoc)
  @query("label")
  label?: string;
};

alias TagsQueryParam<TDoc extends valueof string> = {
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Pre-existing API contract."
  @doc(TDoc)
  @query(#{ name: "tags", explode: true })
  tags?: string[];
};

alias NamePathParam<TDoc extends valueof string> = {
  @doc(TDoc)
  @maxLength(256)
  @path
  name: string;
};
