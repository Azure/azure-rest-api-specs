/*
  Definitions of elements exclusively defined for the Azure Monitor Workspace for Logs exporter.
*/

using OpenAPI;

namespace Microsoft.Monitor;

@doc("Azure Monitor Workspace Logs specific configurations.")
model AzureMonitorWorkspaceLogsExporter {
  @doc("API configurations for Azure Monitor workspace exporter.")
  api: AzureMonitorWorkspaceLogsApiConfig;

  @doc("Concurrency configuration for the exporter.")
  concurrency?: ConcurrencyConfiguration;

  @doc("Cache configurations.")
  cache?: CacheConfiguration;
}

@doc("Azure Monitor Workspace Logs Api configurations.")
model AzureMonitorWorkspaceLogsApiConfig {
  @doc("Data collection endpoint ingestion url.")
  @pattern("^(https?)://[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*$")
  dataCollectionEndpointUrl: string;

  @doc("Stream name in destination. Azure Monitor stream is related to the destination table.")
  @pattern("^(?!-)[a-zA-Z0-9._-]{1,1000}[^-]$")
  stream: string;

  @doc("Data Collection Rule (DCR) immutable id.")
  @pattern("^(?!-)[a-zA-Z0-9.-]{1,1000}[^-]$")
  dataCollectionRule: string;

  @doc("The schema mapping for incoming data.")
  schema: SchemaMap;
}

@doc("Schema map for azure monitor for logs.")
model SchemaMap {
  @doc("Record Map.")
  @extension("x-ms-identifiers", [])
  recordMap: RecordMap[];

  @doc("Resource Map captures information about the entity for which telemetry is recorded. For example, metrics exposed by a Kubernetes container can be linked to a resource that specifies the cluster, namespace, pod, and container name.Resource may capture an entire hierarchy of entity identification. It may describe the host in the cloud and specific container or an application running in the process.")
  @extension("x-ms-identifiers", [])
  resourceMap?: ResourceMap[];

  @extension("x-ms-identifiers", [])
  @doc("A scope map is a logical unit of the application code with which the emitted telemetry can be associated.")
  scopeMap?: ScopeMap[];
}

@doc("Record map for schema in azure monitor.")
model RecordMap {
  @doc("Record Map Key.")
  from: string;

  @doc("Record Map Value.")
  to: string;
}

@doc("Resource map for schema in azure monitor.")
model ResourceMap {
  @doc("Resource Map Key.")
  from: string;

  @doc("Resource Map Value.")
  to: string;
}

@doc("Scope map for schema in azure monitor.")
model ScopeMap {
  @doc("Scope Map Key.")
  from: string;

  @doc("Scope Map Value.")
  to: string;
}

@doc("Concurrent publishing configuration.")
model ConcurrencyConfiguration {
  @doc("Number of parallel workers processing the log queues.")
  workerCount?: int32 = 4;

  @doc("Size of the queue for log batches.")
  batchQueueSize?: int32 = 100;
}

@doc("Cache configurations.")
model CacheConfiguration {
  @doc("Max storage usage in megabytes.")
  maxStorageUsage?: int32;

  @doc("Retention period in minutes.")
  retentionPeriod?: int32;
}
