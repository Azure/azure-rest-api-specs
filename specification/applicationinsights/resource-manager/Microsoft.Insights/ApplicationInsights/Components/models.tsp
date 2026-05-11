import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Components;

/**
 * Type of application being monitored.
 */
union ApplicationType {
  string,

  /**
   * web
   */
  web: "web",

  /**
   * other
   */
  other: "other",
}

/**
 * Used by the Application Insights system to determine what kind of flow this component was created by. This is to be set to 'Bluefield' when creating/updating a component via the REST API.
 */
union FlowType {
  string,

  /**
   * Bluefield
   */
  Bluefield: "Bluefield",
}

/**
 * Describes what tool created this Application Insights component. Customers using this API should set this to the default 'rest'.
 */
union RequestSource {
  string,

  /**
   * rest
   */
  rest: "rest",
}

/**
 * The network access type for operating on the Application Insights Component. By default it is Enabled
 */
union PublicNetworkAccessType {
  string,

  /**
   * Enables connectivity to Application Insights through public DNS.
   */
  Enabled: "Enabled",

  /**
   * Disables public connectivity to Application Insights through public DNS.
   */
  Disabled: "Disabled",
}

/**
 * Indicates the flow of the ingestion.
 */
union IngestionMode {
  string,

  /**
   * ApplicationInsights
   */
  ApplicationInsights: "ApplicationInsights",

  /**
   * ApplicationInsightsWithDiagnosticSettings
   */
  ApplicationInsightsWithDiagnosticSettings: "ApplicationInsightsWithDiagnosticSettings",

  /**
   * LogAnalytics
   */
  LogAnalytics: "LogAnalytics",
}

/**
 * Status of the operation represented by the requested Id.
 */
union PurgeState {
  string,

  /**
   * pending
   */
  pending: "pending",

  /**
   * completed
   */
  completed: "completed",
}

/**
 * Properties that define an Application Insights component resource.
 */
model ApplicationInsightsComponentProperties {
  /**
   * The unique ID of your application. This field mirrors the 'Name' field and cannot be changed.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ApplicationId?: string;

  /**
   * Application Insights Unique ID for your Application.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  AppId?: string;

  /**
   * Application name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  Name?: string;

  /**
   * Type of application being monitored.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  Application_Type: ApplicationType = ApplicationType.web;

  /**
   * Used by the Application Insights system to determine what kind of flow this component was created by. This is to be set to 'Bluefield' when creating/updating a component via the REST API.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Flow_Type?: FlowType = FlowType.Bluefield;

  /**
   * Describes what tool created this Application Insights component. Customers using this API should set this to the default 'rest'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Request_Source?: RequestSource = RequestSource.rest;

  /**
   * Application Insights Instrumentation key. A read-only value that applications can use to identify the destination for all telemetry sent to Azure Application Insights. This value will be supplied upon construction of each new Application Insights component.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  InstrumentationKey?: string;

  /**
   * Creation Date for the Application Insights component, in ISO 8601 format.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  CreationDate?: utcDateTime;

  /**
   * Azure Tenant Id.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  TenantId?: string;

  /**
   * The unique application ID created when a new application is added to HockeyApp, used for communications with HockeyApp.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/ewjuel")
  HockeyAppId?: string;

  /**
   * Token used to authenticate communications with between Application Insights and HockeyApp.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/sls76s")
  @visibility(Lifecycle.Read)
  HockeyAppToken?: string;

  /**
   * Current state of this component: whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Succeeded, Deploying, Canceled, and Failed.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Percentage of the data produced by the application being monitored that is being sampled for Application Insights telemetry.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/sl0yqd")
  SamplingPercentage?: float64;

  /**
   * Application Insights component connection string.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ConnectionString?: string;

  /**
   * Retention period in days.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RetentionInDays?: int32;

  /**
   * Disable IP masking.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DisableIpMasking?: boolean;

  /**
   * Purge data immediately after 30 days.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ImmediatePurgeDataOn30Days?: boolean;

  /**
   * Resource Id of the log analytics workspace which the data will be ingested to. This property is required to create an application with this API version. Applications from older versions will not have this property.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WorkspaceResourceId?: string;

  /**
   * The date which the component got migrated to LA, in ISO 8601 format.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  LaMigrationDate?: utcDateTime;

  /**
   * List of linked private link scope resources.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#["ScopeId"])
  PrivateLinkScopedResources?: PrivateLinkScopedResource[];

  /**
   * The network access type for accessing Application Insights ingestion.
   */
  publicNetworkAccessForIngestion?: PublicNetworkAccessType = PublicNetworkAccessType.Enabled;

  /**
   * The network access type for accessing Application Insights query.
   */
  publicNetworkAccessForQuery?: PublicNetworkAccessType = PublicNetworkAccessType.Enabled;

  /**
   * Indicates the flow of the ingestion.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IngestionMode?: IngestionMode = IngestionMode.LogAnalytics;

  /**
   * Disable Non-AAD based Auth.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DisableLocalAuth?: boolean;

  /**
   * Force users to create their own storage account for profiler and debugger.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ForceCustomerStorageForProfiler?: boolean;
}

/**
 * The private link scope resource reference.
 */
model PrivateLinkScopedResource {
  /**
   * The full resource Id of the private link scope resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ResourceId?: string;

  /**
   * The private link scope unique Identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ScopeId?: string;
}

/**
 * An azure resource object
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model ComponentsResource {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Azure resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
model ErrorResponseComponents {
  /**
   * Error response indicates Insights service is not able to process the incoming request. The reason is provided in the error message.
   */
  error?: ErrorResponseComponentsError;
}

/**
 * Error response indicates Insights service is not able to process the incoming request. The reason is provided in the error message.
 */
model ErrorResponseComponentsError {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Describes the body of a purge request for an App Insights component
 */
model ComponentPurgeBody {
  /**
   * Table from which to purge data.
   */
  table: string;

  /**
   * The set of columns and filters (queries) to run over them to purge the resulting data.
   */
  @identifiers(#[])
  filters: ComponentPurgeBodyFilters[];
}

/**
 * User-defined filters to return data which will be purged from the table.
 */
model ComponentPurgeBodyFilters {
  /**
   * The column of the table over which the given query should run
   */
  column?: string;

  /**
   * A query operator to evaluate over the provided column and value(s). Supported operators are ==, =~, in, in~, >, >=, <, <=, between, and have the same behavior as they would in a KQL query.
   */
  operator?: string;

  /**
   * the value for the operator to function over. This can be a number (e.g., > 100), a string (timestamp >= '2017-09-01') or array of values.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: unknown;

  /**
   * When filtering over custom dimensions, this key will be used as the name of the custom dimension.
   */
  key?: string;
}

/**
 * Response containing operationId for a specific purge action.
 */
model ComponentPurgeResponse {
  /**
   * Id to use when querying for status for a particular purge operation.
   */
  operationId: string;
}

/**
 * Response containing status for a specific purge operation.
 */
model ComponentPurgeStatusResponse {
  /**
   * Status of the operation represented by the requested Id.
   */
  status: PurgeState;
}
