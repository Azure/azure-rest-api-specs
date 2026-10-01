import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./MapsAccount.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Maps;
/**
 * The private endpoint connection resource.
 */
model PrivateEndpointConnection is PrivateEndpointConnectionResource;
alias PrivateEndpointOperations = PrivateEndpoints<PrivateEndpointConnection>;

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the Maps Account.
   */
  get is PrivateEndpointOperations.Read<MapsAccount>;

  /**
   * Create or update the state of specified private endpoint connection associated with the Maps account.
   */
  @removed(Versions.v2026_12_01)
  @renamedFrom(Versions.v2026_12_01, "create")
  @sharedRoute
  @Azure.Core.useFinalStateVia("location")
  createV1 is PrivateEndpointOperations.CreateOrUpdateAsync<
    MapsAccount,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Create or update the state of specified private endpoint connection associated with the Maps account.
   */
  @added(Versions.v2026_12_01)
  @sharedRoute
  @Azure.Core.useFinalStateVia("original-uri")
  create is PrivateEndpointOperations.CreateOrUpdateAsync<
    MapsAccount,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the specified private endpoint connection associated with the Maps Account.
   */
  @Azure.Core.useFinalStateVia("location")
  delete is PrivateEndpointOperations.DeleteAsync<
    MapsAccount,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Get a private endpoint connections on the Maps Account.
   */
  listByAccount is PrivateEndpointOperations.ListByParent<
    MapsAccount,
    Response = ArmResponse<PrivateEndpointConnectionList>
  >;
}

@@maxLength(CommonTypes.PrivateEndpointConnection.name, 98);
@@minLength(CommonTypes.PrivateEndpointConnection.name, 3);
@@pattern(CommonTypes.PrivateEndpointConnection.name, "^[^%&:\\\\/#?]+$");

@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(
  PrivateEndpointConnections.create::parameters.resource,
  "The private endpoint connection properties."
);
@@doc(
  PrivateEndpointConnections.createV1::parameters.resource,
  "The private endpoint connection properties."
);
