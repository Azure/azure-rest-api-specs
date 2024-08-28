import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace
@service({
  title: "Microsoft.DurableTask",
})
@versioned(Versions)
namespace Microsoft.DurableTask;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("API Versions")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2024-02-01-preview")
  v2024_02_01_Preview: "2024-02-01-preview",
}

@doc("A DurableTaskService resource")
model Namespace is Azure.ResourceManager.TrackedResource<NamespaceProperties> {
  @doc("The name of the service")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  @key("namespaceName")
  @segment("namespaces")
  @path
  @visibility("read", "create")
  name: string;
}

@doc("Update namespace")
model NamespaceUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** RP-specific properties */
  properties?: NamespaceProperties;
}

model NamespacePropertiesUpdate
  is OptionalProperties<UpdateableProperties<NamespaceProperties>>;

@doc("Details of the Namespace.")
model NamespaceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("URL of the durable task service")
  @visibility("read")
  url?: string;

  @doc("URL of the durable task service dashboard")
  @visibility("read")
  dashboardUrl?: string;

  @doc("IP allow list for durable task service. Values can be Pv4, IPv6 or CIDR")
  ipAllowlist?: string[];
}

@doc("An Task Hub resource belonging to the namespace.")
@parentResource(Namespace)
model TaskHub is Azure.ResourceManager.ProxyResource<TaskHubProperties> {
  @doc("Task Hub name")
  @key("taskHubName")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  @segment("taskHubs")
  @path
  @visibility("read", "create")
  name: string;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}

@doc("The properties of Task Hub")
model TaskHubProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Update Task Hub")
model TaskHubUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The resource is being provisioned")
  Provisioning: "Provisioning",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",
}

@armResourceOperations(Namespace)
interface Namespaces {
  get is ArmResourceRead<Namespace>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Namespace>;
  update is ArmCustomPatchAsync<Namespace, NamespaceUpdate>;
  //update is ArmResourcePatchSync<Namespace, NamespaceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Namespace>;
  listByResourceGroup is ArmResourceListByParent<Namespace>;
  listBySubscription is ArmListBySubscription<Namespace>;
}

@armResourceOperations(TaskHub)
interface TaskHubs {
  @doc("Get a Task Hub")
  get is ArmResourceRead<TaskHub>;
  @doc("Create or update a Task Hub")
  createOrUpdate is ArmResourceCreateOrReplaceSync<TaskHub>;
  @doc("Update a Task Hub")
  update is ArmCustomPatchSync<TaskHub, TaskHubUpdate>;
  @doc("Delete a Task Hub")
  delete is ArmResourceDeleteSync<TaskHub>;
  @doc("List Task Hubs")
  listByNamespace is ArmResourceListByParent<TaskHub>;
}
