import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Rest;

namespace Microsoft.ContainerService;

/** Scaling configuration */
model ScalingConfiguration {
  /** Scaling type for the app. Default is manual scaling */
  type?: ScalingType;

  /** Minimum number of replicas for the app when using autoscaling */
  minReplicas?: int32;

  /** Maximum number of replicas for the app when using autoscaling */
  maxReplicas?: int32;

  /** List of autoscaling triggers for the app */
  @identifiers(#["type"])
  autoscalingTriggers?: AutoscalingTrigger[];
}

/** Scaling type for the app */
union ScalingType {
  /** Auto scale */
  Autoscale: "autoscale",

  /** Manual scale */
  Manual: "manual",

  string,
}

/** KEDA Autoscaling Trigger */
model AutoscalingTrigger {
  /** Type of the autoscaling trigger */
  type: AutoscalingTriggerType;

  /** Configuration for GitHub Runner trigger. Only required when type is 'github-runner'. */
  gitHubRunner?: GitHubRunnerTriggerMetadata;

  /** Configuration for Azure App Insights trigger. Only required when type is 'azure-app-insights'. */
  azureAppInsights?: AzureAppInsightsTriggerMetadata;

  /** Configuration for Azure Pipelines trigger. Only required when type is 'azure-pipelines'. */
  azurePipelines?: AzurePipelinesTriggerMetadata;

  /** Configuration for Azure Blob trigger. Only required when type is 'azure-blob'. */
  azureBlob?: AzureBlobTriggerMetadata;

  /** Configuration for Azure Data Explorer trigger. Only required when type is 'azure-data-explorer'. */
  azureDataExplorer?: AzureDataExplorerTriggerMetadata;

  /** Configuration for Azure Event Hub trigger. Only required when type is 'azure-eventhub'. */
  azureEventHub?: AzureEventHubTriggerMetadata;

  /** Configuration for Azure Log Analytics trigger. Only required when type is 'azure-log-analytics'. */
  azureLogAnalytics?: AzureLogAnalyticsTriggerMetadata;

  /** Configuration for Azure Monitor trigger. Only required when type is 'azure-monitor'. */
  azureMonitor?: AzureMonitorTriggerMetadata;

  /** Configuration for Azure Service Bus trigger. Only required when type is 'azure-servicebus'. */
  azureServiceBus?: AzureServiceBusTriggerMetadata;

  /** Configuration for Azure Storage Queue trigger. Only required when type is 'azure-storage-queue'. */
  azureStorageQueue?: AzureStorageQueueTriggerMetadata;
}

/** KEDA Autoscaling Trigger Types */
union AutoscalingTriggerType {
  /** CPU based autoscaling */
  Cpu: "cpu",

  /** Memory based autoscaling */
  Memory: "memory",

  /** Keda Cron trigger */
  Cron: "cron",

  /** Keda GitHub Runner trigger */
  GitHubRunner: "github-runner",

  /** Keda Azure App Insights trigger */
  AzureAppInsights: "azure-app-insights",

  /** Keda Azure Blob trigger */
  AzureBlob: "azure-blob",

  /** Keda Azure Data Explorer trigger */
  AzureDataExplorer: "azure-data-explorer",

  /** Keda Azure Event Hub trigger */
  AzureEventHub: "azure-eventhub",

  /** Keda Azure Log Analytics trigger */
  AzureLogAnalytics: "azure-log-analytics",

  /** Keda Azure Monitor trigger */
  AzureMonitor: "azure-monitor",

  /** Keda Azure Pipelines Trigger */
  AzurePipelines: "azure-pipelines",

  /** Keda Azure Service Bus Trigger */
  AzureServiceBus: "azure-servicebus",

  /** Keda Azure Storage Queue Trigger */
  AzureStorageQueue: "azure-storage-queue",

  string,
}

/** GitHub Runner Trigger Configuration */
model GitHubRunnerTriggerMetadata {
  /** The URL of the GitHub API (Default: https://api.github.com) */
  githubApiUrl?: string;

  /** The owner of the GitHub repository or organization */
  owner?: string;

  /** The scope of the runner: org (organization), ent (enterprise), or repo (repository) */
  runnerScope?: string;

  /** List of repositories to scale, separated by comma */
  repos?: string;

  /** List of runner labels to scale on, separated by comma */
  labels?: string;

  /** Do not scale on default runner labels (self-hosted, linux, x64) (Default: false) */
  noDefaultLabels?: string;

  /** When enabled, unlabeled jobs will not match unlabeled runners (Default: false) */
  matchUnlabeledJobsWithUnlabeledRunners?: string;

  /** Enable etag headers for conditional requests to GitHub API (Default: false) */
  enableEtags?: string;

  /** Target number of queued jobs to scale on (Default: 1) */
  targetWorkflowQueueLength?: string;

  /** Application ID from the GitHub App */
  applicationId?: string;

  /** Installation ID from the GitHub App once installed into org or repo */
  installationId?: string;
}

/** Azure App Insights Trigger Configuration */
model AzureAppInsightsTriggerMetadata {
  /** Metric aggregation timespan */
  metricAggregationTimespan?: string;

  /** Type of metric aggregation */
  metricAggregationType?: string;

  /** Filter expression for the metric */
  metricFilter?: string;

  /** Metric ID to monitor */
  metricId?: string;

  /** Target value for scaling */
  targetValue?: string;

  /** Activation target value */
  activationTargetValue?: string;

  /** Environment variable name for Active Directory Client ID */
  activeDirectoryClientIdFromEnv?: string;

  /** Environment variable name for Active Directory Client Password */
  activeDirectoryClientPasswordFromEnv?: string;

  /** Environment variable name for Application Insights ID */
  applicationInsightsIdFromEnv?: string;

  /** Environment variable name for Tenant ID */
  tenantIdFromEnv?: string;

  /** Cloud environment (Default: AzurePublicCloud) */
  cloud?: string;

  /** Application Insights resource URL (required when cloud = Private) */
  appInsightsResourceUrl?: string;

  /** Active Directory endpoint (required when cloud = Private) */
  activeDirectoryEndpoint?: string;

  /** Whether to ignore null values in query results (Default: false) */
  ignoreNullValues?: boolean;
}

/** Azure Pipelines Trigger Configuration */
model AzurePipelinesTriggerMetadata {
  /** Name of the pool in Azure DevOps */
  poolName?: string;

  /** Pool ID in Azure DevOps */
  poolId?: string;

  /** Environment variable name for Azure DevOps organization URL */
  organizationUrlFromEnv?: string;

  /** Environment variable name for Personal Access Token */
  personalAccessTokenFromEnv?: string;

  /** Target queue length (Default: 1) */
  targetPipelinesQueueLength?: string;

  /** Activation target queue length (Default: 0) */
  activationTargetPipelinesQueueLength?: string;

  /** Parent template to read demands from */
  parent?: string;

  /** Demands string to read from ScaledObject */
  demands?: string;

  /** Whether job demands must exactly match trigger capabilities */
  requireAllDemands?: boolean;

  /** Whether to require specified demands and ignore extras */
  requireAllDemandsAndIgnoreOthers?: boolean;

  /** Number of jobs to fetch in API call (Default: 250) */
  jobsToFetch?: string;

  /** Whether to only fetch unfinished jobs (Default: false) */
  fetchUnfinishedJobsOnly?: boolean;

  /** Enable case-insensitive comparison of demands (Default: false) */
  caseInsensitiveDemandsProcessing?: boolean;
}

/** Azure Blob Trigger Configuration */
model AzureBlobTriggerMetadata {
  /** Blob container name */
  blobContainerName?: string;

  /** Target blob count */
  blobCount?: string;

  /** Activation blob count */
  activationBlobCount?: string;

  /** Environment variable name for storage connection string */
  connectionFromEnv?: string;

  /** Storage account name */
  accountName?: string;

  /** Blob prefix filter */
  blobPrefix?: string;

  /** Blob delimiter */
  blobDelimiter?: string;

  /** Cloud environment (Default: AzurePublicCloud) */
  cloud?: string;

  /** Endpoint suffix (required when cloud = Private) */
  endpointSuffix?: string;

  /** Whether to search recursively */
  recursive?: boolean;

  /** Glob pattern for filtering blobs */
  globPattern?: string;
}

/** Azure Data Explorer Trigger Configuration */
model AzureDataExplorerTriggerMetadata {
  /** Azure Data Explorer endpoint */
  endpoint?: string;

  /** Database name */
  databaseName?: string;

  /** Kusto query to execute */
  query?: string;

  /** Threshold value for scaling */
  threshold?: string;

  /** Activation threshold value */
  activationThreshold?: string;

  /** Tenant ID */
  tenantId?: string;

  /** Client ID */
  clientId?: string;

  /** Environment variable name for Client ID */
  clientIdFromEnv?: string;

  /** Environment variable name for Client Secret */
  clientSecretFromEnv?: string;

  /** Environment variable name for Tenant ID */
  tenantIdFromEnv?: string;

  /** Cloud environment (Default: AzurePublicCloud) */
  cloud?: string;

  /** Active Directory endpoint (required when cloud = Private) */
  activeDirectoryEndpoint?: string;
}

/** Azure Event Hub Trigger Configuration */
model AzureEventHubTriggerMetadata {
  /** Environment variable name for Event Hub connection string */
  connectionFromEnv?: string;

  /** Environment variable name for storage connection string */
  storageConnectionFromEnv?: string;

  /** Consumer group name */
  consumerGroup?: string;

  /** Unprocessed event threshold */
  unprocessedEventThreshold?: string;

  /** Activation unprocessed event threshold */
  activationUnprocessedEventThreshold?: string;

  /** Blob container name */
  blobContainer?: string;

  /** Cloud environment (Default: AzurePublicCloud) */
  cloud?: string;

  /** Service Bus endpoint suffix (required when cloud = Private) */
  endpointSuffix?: string;

  /** Storage endpoint suffix (required when cloud = Private) */
  storageEndpointSuffix?: string;

  /** Storage account name (required for workload identity auth) */
  storageAccountName?: string;
}

/** Azure Log Analytics Trigger Configuration */
model AzureLogAnalyticsTriggerMetadata {
  /** Tenant ID */
  tenantId?: string;

  /** Service Principal Client ID */
  clientId?: string;

  /** Service Principal Client Secret */
  @secret
  clientSecret?: string;

  /** Log Analytics Workspace ID */
  workspaceId?: string;

  /** Kusto query to execute */
  query?: string;

  /** Threshold value for scaling */
  threshold?: string;

  /** Activation threshold value */
  activationThreshold?: string;

  /** Environment variable name for Workspace ID */
  workspaceIdFromEnv?: string;

  /** Environment variable name for Client ID */
  clientIdFromEnv?: string;

  /** Environment variable name for Tenant ID */
  tenantIdFromEnv?: string;

  /** Environment variable name for Client Secret */
  clientSecretFromEnv?: string;

  /** Cloud environment (Default: AzurePublicCloud) */
  cloud?: string;

  /** Log Analytics resource URL (required when cloud = Private) */
  logAnalyticsResourceUrl?: string;

  /** Active Directory endpoint (required when cloud = Private) */
  activeDirectoryEndpoint?: string;

  /** Whether to disable SSL verification (Default: false) */
  unsafeSsl?: string;

  /** Custom timeout for HTTP client in milliseconds */
  timeout?: string;
}

/** Azure Monitor Trigger Configuration */
model AzureMonitorTriggerMetadata {
  /** Resource URI in Azure Monitor */
  resourceUri?: string;

  /** Tenant ID */
  tenantId?: string;

  /** Subscription ID */
  subscriptionId?: string;

  /** Resource group name */
  resourceGroupName?: string;

  /** Metric name to monitor */
  metricName?: string;

  /** Filter expression for the metric */
  metricFilter?: string;

  /** Metric aggregation interval */
  metricAggregationInterval?: string;

  /** Target value for scaling */
  targetValue?: string;

  /** Activation target value */
  activationTargetValue?: string;

  /** Active Directory Client ID */
  activeDirectoryClientId?: string;

  /** Environment variable name for Active Directory Client ID */
  activeDirectoryClientIdFromEnv?: string;

  /** Environment variable name for Active Directory Client Password */
  activeDirectoryClientPasswordFromEnv?: string;

  /** Cloud environment (Default: AzurePublicCloud) */
  cloud?: string;

  /** Azure Resource Manager endpoint (required when cloud = Private) */
  azureResourceManagerEndpoint?: string;

  /** Active Directory endpoint (required when cloud = Private) */
  activeDirectoryEndpoint?: string;
}

/** Azure Service Bus Trigger Configuration */
model AzureServiceBusTriggerMetadata {
  /** Queue name (required if not using topic) */
  queueName?: string;

  /** Topic name (required if using topic) */
  topicName?: string;

  /** Subscription name (required when using topic) */
  subscriptionName?: string;

  /** Service Bus namespace (required when using workload identity) */
  serviceBusNamespace?: string;

  /** Environment variable name for Service Bus connection string */
  connectionFromEnv?: string;

  /** Message count threshold (Default: 5) */
  messageCount?: string;

  /** Activation message count */
  activationMessageCount?: string;

  /** Cloud environment (Default: AzurePublicCloud) */
  cloud?: string;

  /** Service Bus endpoint suffix (required when cloud = Private) */
  endpointSuffix?: string;
}

/** Azure Storage Queue Trigger Configuration */
model AzureStorageQueueTriggerMetadata {
  /** Queue name */
  queueName?: string;

  /** Target queue length */
  queueLength?: string;

  /** Queue length strategy (all or visibleonly) */
  queueLengthStrategy?: string;

  /** Activation queue length */
  activationQueueLength?: string;

  /** Environment variable name for storage connection string */
  connectionFromEnv?: string;

  /** Storage account name */
  accountName?: string;

  /** Cloud environment */
  cloud?: string;
}
