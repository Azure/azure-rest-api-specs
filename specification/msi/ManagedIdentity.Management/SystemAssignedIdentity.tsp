import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedIdentity;
/**
 * Describes a system assigned identity resource.
 */
@singleton("default")
model SystemAssignedIdentity
  is Azure.ResourceManager.ExtensionResource<SystemAssignedIdentityProperties> {
  ...ResourceNameParameter<
    Resource = SystemAssignedIdentity,
    KeyName = "identity",
    SegmentName = "identities",
    NamePattern = ""
  >;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}
@@visibility(SystemAssignedIdentity.properties, Lifecycle.Read);

@armResourceOperations
interface SystemAssignedIdentities {
  /**
   * Gets the systemAssignedIdentity available under the specified RP scope.
   */
  // TODO: original "x-ms-identifiers", #["code"], but common type v4 is  ["message", "target"]
  // @OpenAPI.extension("x-ms-identifiers", #["code"])
  getByScope is Extension.Read<
    Extension.ScopeParameter,
    SystemAssignedIdentity,
    Error = CloudError
  >;
}

@@doc(SystemAssignedIdentity.name, "");
@@doc(SystemAssignedIdentity.properties,
  "The properties associated with the identity."
);
