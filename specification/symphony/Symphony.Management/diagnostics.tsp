import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ToolchainOrchestrator;

@doc("The properties of a Diagnostic resource.")
@added(Versions.v2024_08_01_preview)
model DiagnosticProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("A Diagnostic resource.")
@added(Versions.v2024_08_01_preview)
@resource("diagnostics")
model Diagnostic is TrackedResource<DiagnosticProperties> {
  @doc("Name of Diagnostic.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  @path
  @key("diagnosticName")
  @segment("diagnostics")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
@added(Versions.v2024_08_01_preview)
interface Diagnostics {
  @doc("Returns details of specified Diagnostic resource.")
  get is Azure.ResourceManager.ArmResourceRead<Diagnostic>;
  @doc("Creates new or updates existing Diagnostic resource.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceAsync<Diagnostic>;
  @doc("Updates existing Diagnostic resource.")
  update is ArmCustomPatchAsync<Diagnostic>;
  @doc("Deletes specified Diagnostic resource.")
  delete is ArmResourceDeleteWithoutOkAsync<Diagnostic>;
  @doc("Returns a collection of Diagnostic resources within the resource group.")
  listByResourceGroup is Azure.ResourceManager.ArmResourceListByParent<Diagnostic>;
  @doc("Lists Diagnostics resources within an Azure subscription.")
  listBySubscription is ArmListBySubscription<Diagnostic>;
}
