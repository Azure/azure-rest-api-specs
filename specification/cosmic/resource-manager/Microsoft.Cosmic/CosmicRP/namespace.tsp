import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.Cosmic;

@doc("A Namespace resource representing a logical grouping of Cosmic environments.")
model Namespace is TrackedResource<NamespaceProperties> {
  @doc("the name of the namespace.")
  @key("namespaceName")
  @segment("namespaces")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(3)
  @maxLength(63)
  @path
  name: string;
}

@doc("Properties of a Namespace resource.")
model NamespaceProperties {
  @doc("Workload name this resource belongs to.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  workload: string;

  @doc("The ServiceTree GUID (with all letters in lower case) for billing")
  serviceTreeId: string;

  @doc("Torus Team Name")
  torusTeam: string;

  @doc("The IcM Account for Escalations")
  icmAccount: string;

  @doc("The IcM tenant for auditing")
  icmTenant: string;

  @doc("Email Alias")
  emailAlias?: string;

  @doc("The isolation group for this namespace.")
  isolationGroup?: string;

  @doc("Indicates whether Nightwatch monitoring is enabled for the namespace.")
  nightwatchEnabled: boolean = false;

  @doc("The provisioning state of the namespace resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: CosmicProvisioningState;
}

@armResourceOperations
interface Namespaces {
  get is ArmResourceRead<Namespace>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Namespace>;
  update is ArmCustomPatchSync<
    Namespace,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Namespace,
      NamespaceProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Namespace>;
  listByResourceGroup is ArmResourceListByParent<Namespace>;
  listBySubscription is ArmListBySubscription<Namespace>;
}
