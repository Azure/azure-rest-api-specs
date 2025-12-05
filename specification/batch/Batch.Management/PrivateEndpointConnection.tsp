import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
/**
 * Contains information about a private link resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(BatchAccount)
model PrivateEndpointConnection extends AzureProxyResource {
  properties?: PrivateEndpointConnectionProperties;
}

alias PrivateEndpointConnectionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider<PrivateEndpointConnection>;

    /** The name of the Batch account. */
    @path
    @segment("batchAccounts")
    @key
    @pattern("^[a-zA-Z0-9]+$")
    @maxLength(24)
    @minLength(3)
    accountName: string;
  },
  {
    /** The private endpoint connection name. This must be unique within the account. */
    @path
    @segment("privateEndpointConnections")
    @key
    @minLength(1)
    @maxLength(101)
    @pattern("^[a-zA-Z0-9_-]+\\.?[a-fA-F0-9-]*$")
    privateEndpointConnectionName: string;
  },
  ErrorType = CloudError
>;

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets information about the specified private endpoint connection.
   */
  get is PrivateEndpointConnectionOps.Read<PrivateEndpointConnection>;

  /**
   * Updates the properties of an existing private endpoint connection.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @patch(#{ implicitOptionality: false })
  update is PrivateEndpointConnectionOps.CustomPatchAsync<
    PrivateEndpointConnection,
    PatchModel = PrivateEndpointConnection,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader,
    Parameters = {
      /**
       * The state (ETag) version of the private endpoint connection to update. This value can be omitted or set to "*" to apply the operation unconditionally.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    }
  >;

  /**
   * Deletes the specified private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is PrivateEndpointConnectionOps.DeleteWithoutOkAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists all of the private endpoint connections in the specified account.
   */
  listByBatchAccount is PrivateEndpointConnectionOps.List<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;
    },
    Response = ArmResponse<ListPrivateEndpointConnectionsResult>
  >;
}

@@doc(PrivateEndpointConnection.properties,
  "The properties associated with the private endpoint connection."
);
@@doc(PrivateEndpointConnections.update::parameters.properties,
  "PrivateEndpointConnection properties that should be updated. Properties that are supplied will be updated, any property not supplied will be unchanged."
);
