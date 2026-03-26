import "../common.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Oracle.Database;

@added(Versions.v20260101_preview)
@doc("ManagedIdentityResource resource definition")
model ManagedIdentityResource
  is TrackedResource<ManagedIdentityResourceProperties> {
  ...ResourceNameParameter<ManagedIdentityResource, NamePattern = ".*">;
  ...AvailabilityZonesProperty;
  ...ManagedServiceIdentityProperty;
}

@added(Versions.v20260101_preview)
@doc("ManagedIdentityResource resource model")
model ManagedIdentityResourceProperties {
  @doc("Optional metadata for the managed identity resource. This is intended only for small, non-sensitive descriptive information and MUST NOT contain arbitrary customer payload or secrets.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  metadata?: ManagedIdentityMetadata;

  @doc("Managed Identity Resources provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;
}

@added(Versions.v20260101_preview)
@doc("Metadata associated with a managed identity resource.")
model ManagedIdentityMetadata {
  @doc("A short, non-sensitive description of the managed identity resource. Do not include secrets or customer data. Maximum length is 1024 characters.")
  @maxLength(1024)
  description?: string;
}
