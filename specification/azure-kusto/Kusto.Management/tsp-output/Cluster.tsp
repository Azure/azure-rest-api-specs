import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;
@doc("Class representing a Kusto cluster.")
model Cluster is TrackedResource<ClusterProperties> {
  @doc("The name of the Kusto cluster.")
  @pattern("^.*$")
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;

  @doc("The availability zones of the cluster.")
  zones?: string[];

  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Clusters {
  @doc("Gets a Kusto cluster.")
  get is ArmResourceRead<Cluster>;

  @doc("Create or update a Kusto cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Cluster,
    {
      ...BaseParameters<Cluster>;

      @doc("The ETag of the cluster. Omit this value to always overwrite the current cluster. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;

      @doc("Set to '*' to allow a new cluster to be created, but to prevent updating an existing cluster. Other values will result in a 412 Pre-condition Failed response.")
      @header
      IfNoneMatch?: string;
    }
  >;

  @doc("Update a Kusto cluster.")
  update is ArmCustomPatchAsync<
    Cluster,
    ClusterUpdate,
    {
      ...BaseParameters<Cluster>;

      @doc("The ETag of the cluster. Omit this value to always overwrite the current cluster. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;

  @doc("Deletes a Kusto cluster.")
  delete is ArmResourceDeleteAsync<Cluster>;

  @doc("Lists all Kusto clusters within a resource group.")
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  @doc("Lists all Kusto clusters within a subscription.")
  list is ArmListBySubscription<Cluster>;

  @doc("Lists eligible SKUs for Kusto resource provider.")
  listSkus is ArmListBySubscription<Cluster>;

  @doc("Stops a Kusto cluster.")
  stop is ArmResourceActionAsync<Cluster, void, void>;

  @doc("Starts a Kusto cluster.")
  start is ArmResourceActionAsync<Cluster, void, void>;

  @doc("Migrate data from a Kusto cluster to another cluster.")
  migrate is ArmResourceActionAsync<Cluster, ClusterMigrateRequest, void>;

  @doc("Returns a list of databases that are owned by this cluster and were followed by another cluster.")
  listFollowerDatabases is ArmResourceActionSync<
    Cluster,
    void,
    FollowerDatabaseListResult
  >;

  @doc("Detaches all followers of a database owned by this cluster.")
  detachFollowerDatabases is ArmResourceActionAsync<
    Cluster,
    FollowerDatabaseDefinition,
    void
  >;

  @doc("Diagnoses network connectivity status for external resources on which the service is dependent on.")
  diagnoseVirtualNetwork is ArmResourceActionAsync<
    Cluster,
    void,
    DiagnoseVirtualNetworkResult
  >;

  @doc("Returns a list of language extensions that can run within KQL queries.")
  listLanguageExtensions is ArmResourceActionSync<
    Cluster,
    void,
    LanguageExtensionsList
  >;

  @doc("Add a list of language extensions that can run within KQL queries.")
  addLanguageExtensions is ArmResourceActionAsync<
    Cluster,
    LanguageExtensionsList,
    void
  >;

  @doc("Remove a list of language extensions that can run within KQL queries.")
  removeLanguageExtensions is ArmResourceActionAsync<
    Cluster,
    LanguageExtensionsList,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Checks that the principal assignment name is valid and is not already in use.")
  @operationId("ClusterPrincipalAssignments_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    Cluster,
    ClusterPrincipalAssignmentCheckNameRequest,
    CheckNameResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Checks that the databases resource name is valid and is not already in use.")
  @operationId("Databases_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    Cluster,
    CheckNameRequest,
    CheckNameResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Checks that the attached database configuration resource name is valid and is not already in use.")
  @operationId("AttachedDatabaseConfigurations_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    Cluster,
    AttachedDatabaseConfigurationsCheckNameRequest,
    CheckNameResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Checks that the managed private endpoints resource name is valid and is not already in use.")
  @operationId("ManagedPrivateEndpoints_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    Cluster,
    ManagedPrivateEndpointsCheckNameRequest,
    CheckNameResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Checks that the sandbox custom image resource name is valid and is not already in use.")
  @operationId("SandboxCustomImages_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    Cluster,
    SandboxCustomImagesCheckNameRequest,
    CheckNameResult
  >;

  @doc("Checks that the cluster name is valid and is not already in use.")
  checkNameAvailability is checkLocalNameAvailability<
    ClusterCheckNameRequest,
    CheckNameResult
  >;

  @doc("Returns the SKUs available for the provided resource.")
  // FIXME: Clusters_ListSkusByResource could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Kusto/clusters/{clusterName}/skus")
  @get
  listSkusByResource is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the Kusto cluster.")
      @pattern("^.*$")
      @path
      clusterName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    ListResourceSkusResult
  >;

  @doc("Gets the network endpoints of all outbound dependencies of a Kusto cluster")
  // FIXME: Clusters_ListOutboundNetworkDependenciesEndpoints could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Kusto/clusters/{clusterName}/outboundNetworkDependenciesEndpoints")
  @get
  listOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the Kusto cluster.")
      @pattern("^.*$")
      @path
      clusterName: string;
    },
    OutboundNetworkDependenciesEndpointListResult
  >;
}

@@projectedName(Clusters.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Clusters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.createOrUpdate::parameters.resource,
  "The Kusto cluster parameters supplied to the CreateOrUpdate operation."
);
@@projectedName(Clusters.update::parameters.properties, "json", "parameters");
@@extension(Clusters.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.update::parameters.properties,
  "The Kusto cluster parameters supplied to the Update operation."
);
@@projectedName(Clusters.migrate::parameters.body,
  "json",
  "clusterMigrateRequest"
);
@@extension(Clusters.migrate::parameters.body,
  "x-ms-client-name",
  "clusterMigrateRequest"
);
@@doc(Clusters.migrate::parameters.body,
  "The cluster migrate request parameters."
);
@@projectedName(Clusters.detachFollowerDatabases::parameters.body,
  "json",
  "followerDatabaseToRemove"
);
@@extension(Clusters.detachFollowerDatabases::parameters.body,
  "x-ms-client-name",
  "followerDatabaseToRemove"
);
@@doc(Clusters.detachFollowerDatabases::parameters.body,
  "The follower databases properties to remove."
);
@@projectedName(Clusters.addLanguageExtensions::parameters.body,
  "json",
  "languageExtensionsToAdd"
);
@@extension(Clusters.addLanguageExtensions::parameters.body,
  "x-ms-client-name",
  "languageExtensionsToAdd"
);
@@doc(Clusters.addLanguageExtensions::parameters.body,
  "The language extensions to add."
);
@@projectedName(Clusters.removeLanguageExtensions::parameters.body,
  "json",
  "languageExtensionsToRemove"
);
@@extension(Clusters.removeLanguageExtensions::parameters.body,
  "x-ms-client-name",
  "languageExtensionsToRemove"
);
@@doc(Clusters.removeLanguageExtensions::parameters.body,
  "The language extensions to remove."
);
@@projectedName(Clusters.checkNameAvailability::parameters.body,
  "json",
  "principalAssignmentName"
);
@@extension(Clusters.checkNameAvailability::parameters.body,
  "x-ms-client-name",
  "principalAssignmentName"
);
@@doc(Clusters.checkNameAvailability::parameters.body,
  "The name of the principal assignment."
);
@@projectedName(Clusters.checkNameAvailability::parameters.body,
  "json",
  "resourceName"
);
@@extension(Clusters.checkNameAvailability::parameters.body,
  "x-ms-client-name",
  "resourceName"
);
@@doc(Clusters.checkNameAvailability::parameters.body,
  "The name of the resource."
);
@@projectedName(Clusters.checkNameAvailability::parameters.body,
  "json",
  "resourceName"
);
@@extension(Clusters.checkNameAvailability::parameters.body,
  "x-ms-client-name",
  "resourceName"
);
@@doc(Clusters.checkNameAvailability::parameters.body,
  "The name of the resource."
);
@@projectedName(Clusters.checkNameAvailability::parameters.body,
  "json",
  "resourceName"
);
@@extension(Clusters.checkNameAvailability::parameters.body,
  "x-ms-client-name",
  "resourceName"
);
@@doc(Clusters.checkNameAvailability::parameters.body,
  "The name of the resource."
);
@@projectedName(Clusters.checkNameAvailability::parameters.body,
  "json",
  "resourceName"
);
@@extension(Clusters.checkNameAvailability::parameters.body,
  "x-ms-client-name",
  "resourceName"
);
@@doc(Clusters.checkNameAvailability::parameters.body,
  "The name of the resource."
);
