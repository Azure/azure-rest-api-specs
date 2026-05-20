import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./privateEndpointConnection.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;
@removed(Microsoft.Chaos.Versions.v2025_01_01)
@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets information about a private endpoint connection under a private access resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Linting error - is actually camel-case."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required to not break existing SDKs"
  getAPrivateEndpointConnection is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Deletes a private endpoint connection under a private access resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Linting error - is actually camel-case."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required to not break existing SDKs"
  deleteAPrivateEndpointConnection is ArmResourceDeleteWithoutOkAsync<PrivateEndpointConnection>;

  /**
   * List information about private endpoint connections under a private access resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required to not break existing SDKs"
  listPrivateEndpointConnections is ArmResourceListByParent<
    PrivateEndpointConnection,
    Response = PrivateEndpointConnectionListResult
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection."
);
@@doc(PrivateEndpointConnection.properties, "Resource properties.");
