import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DigitalTwinsDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DigitalTwins;
@doc("Describes a time series database connection resource.")
@parentResource(DigitalTwinsDescription)
model TimeSeriesDatabaseConnection
  is ProxyResource<TimeSeriesDatabaseConnectionProperties> {
  @doc("Name of time series database connection.")
  @maxLength(49)
  @minLength(2)
  @pattern("^(?![0-9]+$)(?!-)[a-zA-Z0-9-]{2,49}[a-zA-Z0-9]$")
  @path
  @key("timeSeriesDatabaseConnectionName")
  @segment("timeSeriesDatabaseConnections")
  name: string;
}

@armResourceOperations
interface TimeSeriesDatabaseConnections {
  @doc("Get the description of an existing time series database connection.")
  get is ArmResourceRead<TimeSeriesDatabaseConnection>;

  @doc("Create or update a time series database connection.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<TimeSeriesDatabaseConnection>;

  @doc("Delete a time series database connection.")
  delete is ArmResourceDeleteAsync<
    TimeSeriesDatabaseConnection,
    {
      ...BaseParameters<TimeSeriesDatabaseConnection>;

      @doc("Specifies whether or not to attempt to clean up artifacts that were created in order to establish a connection to the time series database. This is a best-effort attempt that will fail if appropriate permissions are not in place. Setting this to 'true' does not delete any recorded data.")
      @query("cleanupConnectionArtifacts")
      cleanupConnectionArtifacts?: CleanupConnectionArtifacts;
    }
  >;

  @doc("Get all existing time series database connections for this DigitalTwins instance.")
  list is ArmResourceListByParent<TimeSeriesDatabaseConnection>;
}

@@projectedName(TimeSeriesDatabaseConnections.createOrUpdate::parameters.resource,
  "json",
  "timeSeriesDatabaseConnectionDescription"
);
@@extension(TimeSeriesDatabaseConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "timeSeriesDatabaseConnectionDescription"
);
@@doc(TimeSeriesDatabaseConnections.createOrUpdate::parameters.resource,
  "The time series database connection description."
);
