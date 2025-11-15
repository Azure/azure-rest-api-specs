import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;
using TypeSpec.Versioning;

namespace Microsoft.Edge;

#suppress "@azure-tools/typespec-azure-resource-manager/empty-updateable-properties" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@doc("The properties of a Diagnostic resource.")
model DiagnosticProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("A Diagnostic resource.")
@resource("diagnostics")
model Diagnostic
  is Azure.ResourceManager.TrackedResource<DiagnosticProperties> {
  @doc("Name of Diagnostic.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  @path
  @key("diagnosticName")
  @segment("diagnostics")
  name: string;

  ...ExtendedLocationProperty;
  ...EntityTagProperty;
}

/** The type used for update operations of the Diagnostic. */
model DiagnosticUpdate {
  @doc("The resource-specific properties for this resource.")
  properties?: DiagnosticUpdateProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@doc("The updatable properties of the Diagnostic.")
model DiagnosticUpdateProperties {}

@armResourceOperations
interface Diagnostics {
  @doc("Returns details of specified Diagnostic resource.")
  get is Azure.ResourceManager.ArmResourceRead<Diagnostic>;
  @doc("Creates new or updates existing Diagnostic resource.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceAsync<Diagnostic>;
  @doc("Updates existing Diagnostic resource.")
  update is ArmCustomPatchAsync<Diagnostic, PatchModel = DiagnosticUpdate>;
  @doc("Deletes specified Diagnostic resource.")
  delete is ArmResourceDeleteWithoutOkAsync<Diagnostic>;
  @doc("Returns a collection of Diagnostic resources within the resource group.")
  listByResourceGroup is Azure.ResourceManager.ArmResourceListByParent<Diagnostic>;
  @doc("Lists Diagnostics resources within an Azure subscription.")
  listBySubscription is ArmListBySubscription<Diagnostic>;
}
