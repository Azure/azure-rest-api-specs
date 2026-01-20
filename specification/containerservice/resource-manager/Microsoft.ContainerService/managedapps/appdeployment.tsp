import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./managedapp.tsp";
import "./autoscalingtriggers.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Rest;

namespace Microsoft.ContainerService;

/** Represents a managed cluster. Just a placeholder until rest of aks is converted to typespec */
model ManagedCluster is TrackedResource<ManagedClusterProperties> {
  ...ResourceNameParameter<ManagedCluster>;
}

/** Managed Cluster properties. Just a placeholder */
model ManagedClusterProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Fleet resource, just a placeholder */
model Fleet is TrackedResource<FleetProperties> {
  ...ResourceNameParameter<Fleet>;
}

/** Fleet properties. Just a placeholder */
model FleetProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@parentResource(Fleet)
@resource("appDeployments")
model FleetAppDeployment is ProxyResource<AppDeploymentProperties> {
  ...ResourceNameParameter<AppDeployment>;
}

/** Represents deploying a revision of an app inside a managed namespace */
@parentResource(ManagedCluster)
model AppDeployment is ProxyResource<AppDeploymentProperties> {
  ...ResourceNameParameter<AppDeployment>;
}

scalar AppRevisionId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/apps/revisions",
    }
  ]>;

/** Properties of the App Deployment */
model AppDeploymentProperties {
  /** The App Revision Id */
  appRevisionId: AppRevisionId;

  /** The kubernetes namespace to deploy into */
  `namespace`: string;

  /** The user assigned identity assigned to the app deployment */
  @visibility(Lifecycle.Read)
  identity: AppDeploymentUserAssignedIdentity;

  /** Observability properties for the app. */
  observability?: ObservabilityProperties;

  /** Overrides for the app template. This will overwrite the template inherited from the app */
  overrides?: AppTemplate;

  /** The name of the generated service account. This is generated from the app deployment name, and namespace name */
  @visibility(Lifecycle.Read)
  generatedServiceAccountName: string;

  /** The name of the generated kubernetes service. This is generated from the app deployment name and namespace name */
  @visibility(Lifecycle.Read)
  generatedKubernetesServiceName: string;

  /** The fqdn of the ingress */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Observability properties for the app */
model ObservabilityProperties {
  /** Log Analytics Workspace ID */
  logAnalyticsWorkspaceId?: logAnalyticsWorkspaceId;

  /** Azure Managed Prometheus Workspace ID */
  azureMonitorAccount?: azureManagedPrometheusWorkspaceId;
}

scalar UserAssignedIdentity
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities",
    }
  ]>;

/** App Deployment User Assigned Identity */
model AppDeploymentUserAssignedIdentity {
  /** The resource id of the user assigned identity */
  userAssignedIdentityId: UserAssignedIdentity;

  /** The client id of the user assigned identity */
  clientId: string;

  /** The principal id of the user assigned identity */
  principalId: string;
}

/** Volume for a container */
model VolumeMount {
  /** Name of the volume */
  name: string;

  /** Mount path for the volume */
  mountPath: string;

  /** Volume is ReadOnly or not */
  readOnly: boolean;
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

/** Used to program traffic rules. Matches a domain name to a set of app deployments. Supports traffic splitting by weight */
@parentResource(ManagedApp)
model TrafficRule is ProxyResource<TrafficRuleProperties> {
  ...ResourceNameParameter<TrafficRule>;
}

scalar AppDeploymentId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedNamespaces/appDeployments",
    }
  ]>;

/** Properties of the Traffic Rule */
model TrafficRuleProperties {
  /** The hostname that will receive traffic. i.e. example.com */
  hostName: string;

  /** An array of deployment references with traffic percentages. The sum of traffic percentages should be 100 */
  @identifiers(#["deploymentId"])
  deployments: TrafficRuleDeploymentReference[];

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Deployment reference for a traffic rule with traffic percentage */
model TrafficRuleDeploymentReference {
  /** The deployment id */
  deploymentId: AppDeploymentId;

  /** The traffic percentage assigned to this deployment. Optional, default is 100 */
  trafficPercentage?: int32;
}
