import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Provisioning state of resource")
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Resource Provisioning is initialized")
  Initialized: "Initialized",

  @doc("Resource Provisioning is in progress")
  Inprogress: "InProgress",

  @doc("Resource Provisioning is deleting")
  Deleting: "Deleting",

  string,
}
