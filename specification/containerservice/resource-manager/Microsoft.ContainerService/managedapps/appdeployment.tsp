import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./app.tsp";
import "./apprevision.tsp";
import "./autoscalingtriggers.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Rest;

namespace Microsoft.ContainerService;

/** Managed Cluster resource. This is just a placeholder until the managed cluster proper is converted to typespec */
model ManagedCluster is TrackedResource<ManagedClusterProperties> {
  ...ResourceNameParameter<ManagedCluster>;
}

/** Properties of the Managed Cluster */
model ManagedClusterProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Managed Namespace resource. This is just a placeholder until the managed namespace proper is converted to typespec */
@parentResource(ManagedCluster)
model ManagedNamespace is TrackedResource<ManagedNamespaceProperties> {
  ...ResourceNameParameter<ManagedNamespace>;
}
/** Provisioning state of the resource. */
model ManagedNamespaceProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@parentResource(ManagedNamespace)
model AppDeployment is ProxyResource<AppDeploymentProperties> {
  ...ResourceNameParameter<AppDeployment>;
  ...ManagedServiceIdentityProperty;
}

scalar AppRevisionId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/apps/appRevisions",
    }
  ]>;

/** Properties of the App Deployment */
model AppDeploymentProperties {
  /** The App Revision Id */
  appRevisionId: AppRevisionId;

  /** An array of permissions for k8s resources in the same namespace associated with the app. This is an override only. Any value here will overwrite permissions inherited from the app */
  @identifiers(#["apiGroups", "resources", "verbs"])
  permissionsInSameNamespace?: Permissions[];

  /** An array of permissions for k8s resources, cluster wide, associated with the app. This is an override only. Any value here will overwrite permissions inherited from the app */
  @identifiers(#["apiGroups", "resources", "verbs"])
  permissionsClusterWide?: Permissions[];

  /** An array of health checks for the app. This is an override only. Any value here will overwrite health checks inherited from the app */
  @identifiers(#["type"])
  healthChecks: HealthCheck[];

  /** Scaling type for the app. This is an override only. Any value here will overwrite scaling inherited from the app */
  scaling: ScalingType;

  /** Deployment Template for the app. Specify any configuration that will be needed or used for this deployment. This is an override only. Any value here will overwrite the template inherited from the app */
  template: AppTemplate;

  /** An array of KEDA autoscaling triggers for the app deployment. */
  @identifiers(#["type"])
  autoscalingTriggers?: AutoscalingTrigger[];

  /** The name of the generated service account */
  @visibility(Lifecycle.Read)
  generatedServiceAccountName: string;

  /** The name of the generated kubernetes service */
  @visibility(Lifecycle.Read)
  generatedKubernetesServiceName: string;

  /** The fqdn of the ingress */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
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

/** Used to program a traffic split between 2 deployments in the same managed namespace */
@parentResource(ManagedNamespace)
model TrafficSplit is ProxyResource<TrafficSplitProperties> {
  ...ResourceNameParameter<TrafficSplit>;
}

scalar AppDeploymentId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedNamespaces/appDeployments",
    }
  ]>;

/** Properties of the Traffic Split */
model TrafficSplitProperties {
  /** An array of deployment references with traffic percentages. The sum of traffic percentages should be 100 */
  @identifiers(#["deploymentId"])
  deployments: TrafficSplitDeploymentReference[];

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Deployment reference for a traffic split with traffic percentage */
model TrafficSplitDeploymentReference {
  /** The deployment id */
  deploymentId: AppDeploymentId;

  /** The traffic percentage assigned to this deployment */
  trafficPercentage: int32;
}
