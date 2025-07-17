// This file contains common aliases used across the IoT Operations Management API.
// It should contain simple scalar aliases or aliases for objects with simple scalar properties.
// Complex objects or models should be defined in their respective files.
alias All = "All";
alias Tag = "Tag";
alias Map = "Map";
alias Avro = "Avro";
alias Cron = "Cron";
alias Json = "Json";
alias Mqtt = "Mqtt";
alias None = "None";
alias Sasl = "Sasl";
alias Sink = "Sink";
alias Block = "Block";
alias Delta = "Delta";
alias Graph = "Graph";
alias Never = "Never";
alias Always = "Always";
alias Binary = "Binary";
alias Digest = "Digest";
alias Branch = "Branch";
alias Custom = "Custom";
alias Filter = "Filter";
alias Secret = "Secret";
alias String = "String";
alias Source = "Source";
alias Enabled = "Enabled";
alias Expired = "Expired";
alias Parquet = "Parquet";
alias Pattern = "Pattern";
alias RunOnce = "RunOnce";
alias Diagnose = "Diagnose";
alias Disabled = "Disabled";
alias Eventhub = "Eventhub";
alias FabricRT = "FabricRT";
alias Anonymous = "Anonymous";
alias ConfigMap = "ConfigMap";
alias EventGrid = "EventGrid";
alias Bucketized = "Bucketized";
alias Continuous = "Continuous";
alias Filesystem = "Filesystem";
alias AccessToken = "AccessToken";
alias Concatenate = "Concatenate";
alias Destination = "Destination";
alias LocalBroker = "LocalBroker";
alias IfNotPresent = "IfNotPresent";
alias X509Certificate = "X509Certificate";
alias ContainerRegistry = "ContainerRegistry";
alias DiagnoseAndRepair = "DiagnoseAndRepair";
alias HelmConfiguration = "HelmConfiguration";
alias ArtifactPullSecret = "ArtifactPullSecret";
alias ImageConfiguration = "ImageConfiguration";
alias OneToOneAllocation = "OneToOneAllocation";
alias AzureDeviceRegistry = "AzureDeviceRegistry";
alias RegistryEndpointRef = "RegistryEndpointRef";
alias ServiceAccountToken = "ServiceAccountToken";
alias BucketizedAllocation = "BucketizedAllocation";
alias ManagedConfiguration = "ManagedConfiguration";
alias BuiltInTransformation = "BuiltInTransformation";
alias StatefulSetConfiguration = "StatefulSetConfiguration";
alias UserAssignedManagedIdentity = "UserAssignedManagedIdentity";
alias SystemAssignedManagedIdentity = "SystemAssignedManagedIdentity";

alias BaseUserAssignedManagedIdentity = {
  @doc("Client ID for the user-assigned managed identity.")
  clientId: string;

  @doc("Resource identifier (application ID URI) of the resource, affixed with the .default suffix.")
  scope?: string;

  @doc("Tenant ID.")
  tenantId: string;
};

alias BaseSystemAssignedManagedIdentity = {
  @doc("Audience of the service to authenticate against. Optional; defaults to the audience for Service host configuration.")
  audience?: string;
};
