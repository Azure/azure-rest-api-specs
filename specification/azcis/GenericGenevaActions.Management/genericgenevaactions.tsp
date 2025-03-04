import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("GenericGenevaActions properties")
model GenericGenevaActionsResourceProperties {
  @doc("User given name for geneva action")
  actionName: string;

  @doc("The execution environment for geneva action")
  environment: string;

  @doc("The extension name for geneva action")
  extension: string;

  @doc("The endpoint name for geneva action")
  endpoint: string;

  @doc("The operation for geneva action")
  operation: string;

  @doc("The input mode for geneva action (single/batch)")
  inputMode?: string;

  @added(Versions.v2024_06_24_preview)
  @doc("The Azure location")
  azureLocation?: azureLocation;

  @doc("The parameter list for geneva action")
  @Azure.ResourceManager.identifiers(#[])
  parameters?: Array<Parameter>;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: GenericGenevaActionsProvisioningState;

  @added(Versions.v2024_06_24_preview)
  @doc("Resource event argument result; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  genericGenevaActionsOpResult?: string;
}

@doc("genericGenevaActions Resource")
model GenericGenevaActionsResource
  is ProxyResource<GenericGenevaActionsResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("genericGenevaActions") // start with lower case
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@doc("GenericGenevaActions Resource Parameter")
model Parameter {
  @doc("Parameter name.")
  name: string;

  @doc("Parameter value.")
  value: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface GenericGenevaActions {
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "Fix on next update"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    GenericGenevaActionsResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  listBySubscription is ArmListBySubscription<GenericGenevaActionsResource>;
  listByResourceGroup is ArmResourceListByParent<GenericGenevaActionsResource>;
  get is ArmResourceRead<GenericGenevaActionsResource>;
}

@@visibility(GenericGenevaActionsResource.properties,
  Lifecycle.Read,
  Lifecycle.Create
);
