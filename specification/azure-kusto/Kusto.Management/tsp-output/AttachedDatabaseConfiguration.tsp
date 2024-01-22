import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;
/**
 * Class representing an attached database configuration.
 */
@parentResource(Cluster)
model AttachedDatabaseConfiguration
  is ProxyResource<AttachedDatabaseConfigurationProperties> {
  /**
   * The name of the attached database configuration.
   */
  @pattern("^.*$")
  @path
  @key("attachedDatabaseConfigurationName")
  @segment("attachedDatabaseConfigurations")
  name: string;
}

@armResourceOperations
interface AttachedDatabaseConfigurations {
  /**
   * Returns an attached database configuration.
   */
  get is ArmResourceRead<AttachedDatabaseConfiguration>;

  /**
   * Creates or updates an attached database configuration.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AttachedDatabaseConfiguration>;

  /**
   * Deletes the attached database configuration with the given name.
   */
  delete is ArmResourceDeleteAsync<AttachedDatabaseConfiguration>;

  /**
   * Returns the list of attached database configurations of the given Kusto cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AttachedDatabaseConfigurations_ListByCluster")
  listByCluster is ArmResourceListByParent<AttachedDatabaseConfiguration>;
}

@@projectedName(AttachedDatabaseConfigurations.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(AttachedDatabaseConfigurations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(AttachedDatabaseConfigurations.createOrUpdate::parameters.resource,
  "The database parameters supplied to the CreateOrUpdate operation."
);
