import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Hci;
@doc("Cluster details.")
model Cluster is TrackedResource<ClusterProperties> {
  @doc("The name of the cluster.")
  @key("clusterName")
  @segment("clusters")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Clusters {
  @doc("Get HCI cluster.")
  get is ArmResourceRead<Cluster>;
  @doc("Create an HCI cluster.")
  create is ArmResourceCreateOrReplaceSync<Cluster>;
  @doc("Update an HCI cluster.")
  update is ArmCustomPatchSync<Cluster, ClusterPatch>;
  @doc("Delete an HCI cluster.")
  delete is ArmResourceDeleteAsync<Cluster>;
  @doc("List all HCI clusters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Cluster>;
  @doc("List all HCI clusters in a subscription.")
  listBySubscription is ArmListBySubscription<Cluster>;
  @doc("Upload certificate.")
  uploadCertificate is ArmResourceActionNoResponseContentAsync<
    Cluster,
    UploadCertificateRequest
  >;
  @doc("Create cluster identity.")
  createIdentity is ArmResourceActionAsync<
    Cluster,
    void,
    ClusterIdentityResponse
  >;
  @doc("Extends Software Assurance Benefit to a cluster")
  extendSoftwareAssuranceBenefit is ArmResourceActionAsync<
    Cluster,
    SoftwareAssuranceChangeRequest,
    Cluster
  >;
}

@armResourceOperations
interface Offers {
  @doc("List Offers available across publishers for the HCI Cluster.")
  // FIXME: Offers_ListByCluster could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/offers")
  @get
  ListByCluster is Azure.Core.Foundations.Operation<
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

      @doc("The name of the cluster.")
      @path
      clusterName: string;

      @doc("Specify $expand=content,contentVersion to populate additional fields related to the marketplace offer.")
      @query("$expand")
      $expand?: string;
    },
    ResourceListResult<Offer>
  >;
}
