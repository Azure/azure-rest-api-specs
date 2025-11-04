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
@parentResource(BatchAccount)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = "^[a-zA-Z0-9_-]+\\.?[a-fA-F0-9-]*$"
  >;

  /***
   * The entity tag for the certificate.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /**
   * The tags of the certificate.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets information about the specified private endpoint connection.
   */
  get is ArmResourceRead<PrivateEndpointConnection, Error = CloudError>;

  /**
   * Updates the properties of an existing private endpoint connection.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    PrivateEndpointConnection,
    PatchModel = PrivateEndpointConnection,
    LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Parameters = {
      /**
       * The state (ETag) version of the private endpoint connection to update. This value can be omitted or set to "*" to apply the operation unconditionally.
       */
      @header("If-Match")
      ifMatch?: string;
    },
    Error = CloudError
  >;

  /**
   * Deletes the specified private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Error = CloudError
  >;

  /**
   * Lists all of the private endpoint connections in the specified account.
   */
  listByBatchAccount is ArmResourceListByParent<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * The maximum number of items to return in the response.
       */
      @query("maxresults")
      maxresults?: int32;
    },
    Response = ArmResponse<ListPrivateEndpointConnectionsResult>,
    Error = CloudError
  >;
}

@@maxLength(PrivateEndpointConnection.name, 101);
@@minLength(PrivateEndpointConnection.name, 1);
@@doc(PrivateEndpointConnection.name,
  "The private endpoint connection name. This must be unique within the account."
);
@@doc(PrivateEndpointConnection.properties,
  "The properties associated with the private endpoint connection."
);
@@doc(PrivateEndpointConnections.update::parameters.properties,
  "PrivateEndpointConnection properties that should be updated. Properties that are supplied will be updated, any property not supplied will be unchanged."
);
