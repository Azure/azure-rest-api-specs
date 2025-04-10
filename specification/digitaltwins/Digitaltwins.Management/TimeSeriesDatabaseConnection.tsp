import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DigitalTwinsDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DigitalTwins;
/**
 * Describes a time series database connection resource.
 */
@parentResource(DigitalTwinsDescription)
model TimeSeriesDatabaseConnection
  is Azure.ResourceManager.ProxyResource<TimeSeriesDatabaseConnectionProperties> {
  ...ResourceNameParameter<
    Resource = TimeSeriesDatabaseConnection,
    KeyName = "timeSeriesDatabaseConnectionName",
    SegmentName = "timeSeriesDatabaseConnections",
    NamePattern = "^(?![0-9]+$)(?!-)[a-zA-Z0-9-]{2,49}[a-zA-Z0-9]$"
  >;
}

@armResourceOperations
interface TimeSeriesDatabaseConnections {
  /**
   * Get the description of an existing time series database connection.
   */
  get is ArmResourceRead<TimeSeriesDatabaseConnection>;

  /**
   * Create or update a time series database connection.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    TimeSeriesDatabaseConnection,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a time series database connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    TimeSeriesDatabaseConnection,
    Parameters = {
      /**
       * Specifies whether or not to attempt to clean up artifacts that were created in order to establish a connection to the time series database. This is a best-effort attempt that will fail if appropriate permissions are not in place. Setting this to 'true' does not delete any recorded data.
       */
      @query("cleanupConnectionArtifacts")
      cleanupConnectionArtifacts?: CleanupConnectionArtifacts;
    },
    Response = ArmResponse<TimeSeriesDatabaseConnection> | (ArmDeleteAcceptedLroResponse & {
      @bodyRoot
      _: TimeSeriesDatabaseConnection;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * Get all existing time series database connections for this DigitalTwins instance.
   */
  list is ArmResourceListByParent<TimeSeriesDatabaseConnection>;
}

@@maxLength(TimeSeriesDatabaseConnection.name, 49);
@@minLength(TimeSeriesDatabaseConnection.name, 2);
@@doc(TimeSeriesDatabaseConnection.name,
  "Name of time series database connection."
);
@@doc(TimeSeriesDatabaseConnection.properties,
  "Properties of a specific time series database connection."
);
@@doc(TimeSeriesDatabaseConnections.createOrUpdate::parameters.resource,
  "The time series database connection description."
);
