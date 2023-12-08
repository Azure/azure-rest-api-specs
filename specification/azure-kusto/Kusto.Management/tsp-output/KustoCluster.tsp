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
model KustoCluster is TrackedResource<ClusterProperties> {
  @doc("The name of the Kusto cluster.")
  @pattern("^.*$")
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;

  @doc("The availability zones of the cluster.")
  zones?: string[];

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface KustoClusters {
  @doc("Gets a Kusto cluster.")
  get is ArmResourceRead<KustoCluster>;
  @doc("Create or update a Kusto cluster.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    KustoCluster,
    {
      ...BaseParameters<KustoCluster>;

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
    KustoCluster,
    ClusterProperties,
    {
      ...BaseParameters<KustoCluster>;

      @doc("The ETag of the cluster. Omit this value to always overwrite the current cluster. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Deletes a Kusto cluster.")
  delete is ArmResourceDeleteAsync<KustoCluster>;
  @doc("Lists all Kusto clusters within a resource group.")
  listByResourceGroup is ArmResourceListByParent<KustoCluster>;
  @doc("Lists all Kusto clusters within a subscription.")
  list is ArmListBySubscription<KustoCluster>;
  @doc("Lists eligible SKUs for Kusto resource provider.")
  listSkus is ArmListBySubscription<KustoCluster>;
  @doc("Stops a Kusto cluster.")
  stop is ArmResourceActionAsync<KustoCluster, {}, {}>;
  @doc("Starts a Kusto cluster.")
  start is ArmResourceActionAsync<KustoCluster, {}, {}>;
  @doc("Migrate data from a Kusto cluster to another cluster.")
  migrate is ArmResourceActionAsync<KustoCluster, ClusterMigrateRequest, {}>;
  @doc("Returns a list of databases that are owned by this cluster and were followed by another cluster.")
  listFollowerDatabases is ArmResourceActionSync<
    KustoCluster,
    {},
    FollowerDatabaseListResult
  >;
  @doc("Detaches all followers of a database owned by this cluster.")
  detachFollowerDatabases is ArmResourceActionAsync<
    KustoCluster,
    FollowerDatabaseDefinition,
    {}
  >;
  @doc("Diagnoses network connectivity status for external resources on which the service is dependent on.")
  diagnoseVirtualNetwork is ArmResourceActionAsync<
    KustoCluster,
    {},
    DiagnoseVirtualNetworkResult
  >;
  @doc("Returns a list of language extensions that can run within KQL queries.")
  listLanguageExtensions is ArmResourceActionSync<
    KustoCluster,
    {},
    LanguageExtensionsList
  >;
  @doc("Add a list of language extensions that can run within KQL queries.")
  addLanguageExtensions is ArmResourceActionAsync<
    KustoCluster,
    LanguageExtensionsList,
    {}
  >;
  @doc("Remove a list of language extensions that can run within KQL queries.")
  removeLanguageExtensions is ArmResourceActionAsync<
    KustoCluster,
    LanguageExtensionsList,
    {}
  >;
  @doc("Checks that the principal assignment name is valid and is not already in use.")
  checkNameAvailability is ArmResourceActionSync<
    KustoCluster,
    ClusterPrincipalAssignmentCheckNameRequest,
    CheckNameResult
  >;
  @doc("Checks that the databases resource name is valid and is not already in use.")
  checkNameAvailability is ArmResourceActionSync<
    KustoCluster,
    CheckNameRequest,
    CheckNameResult
  >;
  @doc("Checks that the attached database configuration resource name is valid and is not already in use.")
  checkNameAvailability is ArmResourceActionSync<
    KustoCluster,
    AttachedDatabaseConfigurationsCheckNameRequest,
    CheckNameResult
  >;
  @doc("Checks that the managed private endpoints resource name is valid and is not already in use.")
  checkNameAvailability is ArmResourceActionSync<
    KustoCluster,
    ManagedPrivateEndpointsCheckNameRequest,
    CheckNameResult
  >;
  @doc("Checks that the sandbox custom image resource name is valid and is not already in use.")
  checkNameAvailability is ArmResourceActionSync<
    KustoCluster,
    SandboxCustomImagesCheckNameRequest,
    CheckNameResult
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
