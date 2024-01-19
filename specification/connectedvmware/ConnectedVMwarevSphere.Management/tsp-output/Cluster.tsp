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

namespace Microsoft.ConnectedVMwarevSphere;
@doc("Define the cluster.")
model Cluster is TrackedResource<ClusterProperties> {
  @doc("Name of the cluster.")
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;

  @doc("Gets or sets the extended location.")
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Clusters {
  @doc("Implements cluster GET method.")
  get is ArmResourceRead<Cluster>;

  @doc("Create Or Update cluster.")
  create is ArmResourceCreateOrUpdateAsync<
    Cluster,
    BaseParameters<Cluster>,
    ArmAsyncOperationHeader
  >;

  @doc("API to update certain properties of the cluster resource.")
  update is ArmCustomPatchSync<Cluster, ResourcePatch>;

  @doc("Implements cluster DELETE method.")
  delete is ArmResourceDeleteAsync<
    Cluster,
    {
      ...BaseParameters<Cluster>;

      @doc("Whether force delete was specified.")
      @query("force")
      force?: boolean;
    }
  >;

  @doc("List of clusters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  @doc("List of clusters in a subscription.")
  list is ArmListBySubscription<Cluster>;
}

@@projectedName(Clusters.create::parameters.resource, "json", "body");
@@extension(Clusters.create::parameters.resource, "x-ms-client-name", "body");
@@doc(Clusters.create::parameters.resource, "Request payload.");
@@projectedName(Clusters.update::parameters.properties, "json", "body");
@@extension(Clusters.update::parameters.properties, "x-ms-client-name", "body");
@@doc(Clusters.update::parameters.properties, "Resource properties to update.");
