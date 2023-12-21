import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Kusto;
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
  update is ArmResourcePatchAsync<
    Cluster,
    ClusterProperties,
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
  @doc("Returns the SKUs available for the provided resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Kusto/clusters/{clusterName}/skus")
  @get
  ListSkusByResource is Azure.Core.Foundations.Operation<
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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Kusto/clusters/{clusterName}/outboundNetworkDependenciesEndpoints")
  @get
  ListOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
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

@armResourceOperations
interface ClusterPrincipalAssignments {
  @doc("Checks that the principal assignment name is valid and is not already in use.")
  checkNameAvailability is ArmResourceActionSync<
    Cluster,
    ClusterPrincipalAssignmentCheckNameRequest,
    CheckNameResult
  >;
}

@armResourceOperations
interface Databases {
  @doc("Checks that the databases resource name is valid and is not already in use.")
  checkNameAvailability is ArmResourceActionSync<
    Cluster,
    CheckNameRequest,
    CheckNameResult
  >;
}

@armResourceOperations
interface AttachedDatabaseConfigurations {
  @doc("Checks that the attached database configuration resource name is valid and is not already in use.")
  checkNameAvailability is ArmResourceActionSync<
    Cluster,
    AttachedDatabaseConfigurationsCheckNameRequest,
    CheckNameResult
  >;
}

@armResourceOperations
interface ManagedPrivateEndpoints {
  @doc("Checks that the managed private endpoints resource name is valid and is not already in use.")
  checkNameAvailability is ArmResourceActionSync<
    Cluster,
    ManagedPrivateEndpointsCheckNameRequest,
    CheckNameResult
  >;
}

@armResourceOperations
interface SandboxCustomImages {
  @doc("Checks that the sandbox custom image resource name is valid and is not already in use.")
  checkNameAvailability is ArmResourceActionSync<
    Cluster,
    SandboxCustomImagesCheckNameRequest,
    CheckNameResult
  >;
}
