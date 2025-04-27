// This file contains common aliases used across the IoT Operations Management API.
// It should contain simple scalar aliases or aliases for objects with simple scalar properties.
// Complex objects or models should be defined in their respective files.
alias Sasl = "Sasl";
alias Mqtt = "Mqtt";
alias Block = "Block";
alias Never = "Never";
alias Always = "Always";
alias Anonymous = "Anonymous";
alias IfNotPresent = "IfNotPresent";
alias Bucketized = "Bucketized";
alias Filesystem = "Filesystem";
alias AccessToken = "AccessToken";
alias X509Certificate = "X509Certificate";
alias HelmConfiguration = "HelmConfiguration";
alias ImageConfiguration = "ImageConfiguration";
alias OneToOneAllocation = "OneToOneAllocation";
alias ServiceAccountToken = "ServiceAccountToken";
alias BucketizedAllocation = "BucketizedAllocation";
alias ManagedConfiguration = "ManagedConfiguration";
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
