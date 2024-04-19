import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
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

  @doc("The parameter list for geneva action")
  @extension("x-ms-identifiers", [])
  parameters?: Array<Parameter>;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: GenericGenevaActionsProvisioningState;
}

@doc("genericGenevaActions Resource")
model GenericGenevaActionsResource
  is ProxyResource<GenericGenevaActionsResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("genericGenevaActions") // start with lower case
  @visibility("read")
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
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GenericGenevaActionsResource>;
  listBySubscription is ArmListBySubscription<GenericGenevaActionsResource>;
  listByResourceGroup is ArmResourceListByParent<GenericGenevaActionsResource>;
  get is ArmResourceRead<GenericGenevaActionsResource>;
}
