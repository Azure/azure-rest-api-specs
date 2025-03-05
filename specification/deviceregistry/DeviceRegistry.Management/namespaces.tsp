import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2024_10_01_preview)
@doc("namespace definition.")
model Namespace is TrackedResource<NamespaceProperties> {
  @doc("Namespace name parameter.")
  @key("namespaceName")
  @segment("namespaces")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(64)
  name: string;

  ...ManagedSystemAssignedIdentityProperty;
}

@added(Versions.v2024_10_01_preview)
@doc("The namespace messaging endpoints model.")
model Messaging {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("Dictionary of messaging endpoints.")
  endpoints?: Record<MessagingEndpoint>;
}

@added(Versions.v2024_10_01_preview)
@doc("The namespace properties model.")
model NamespaceProperties {
  @doc("Globally unique, immutable, non-reusable id.")
  @visibility(Lifecycle.Read)
  uuid?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("Assigned and unassigned messaging endpoints.")
  messaging?: Messaging;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2024_10_01_preview)
@doc("Namespace messaging endpoint model used by a device to connect to a service.")
model MessagingEndpoint {
  @doc("Type of connection used for messaging endpoint.")
  type?: string;

  @doc("The messaging endpoint Azure resource Id.")
  resourceId?: string;
}

@added(Versions.v2024_10_01_preview)
@armResourceOperations
interface Namespaces {
  get is ArmResourceRead<Namespace>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<Namespace>;
  update is ArmResourcePatchAsync<Namespace, NamespaceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Namespace>;
  listByResourceGroup is ArmResourceListByParent<Namespace>;
  listBySubscription is ArmListBySubscription<Namespace>;
}
