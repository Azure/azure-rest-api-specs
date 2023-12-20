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
model HciCluster is TrackedResource<ClusterProperties> {
  @doc("The name of the cluster.")
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface HciClusters {
  @doc("Get HCI cluster.")
  get is ArmResourceRead<HciCluster>;
  @doc("Create an HCI cluster.")
  create is ArmResourceCreateOrReplaceSync<HciCluster>;
  @doc("Update an HCI cluster.")
  update is ArmResourcePatchSync<HciCluster, ClusterProperties>;
  @doc("Delete an HCI cluster.")
  delete is ArmResourceDeleteAsync<HciCluster>;
  @doc("List all HCI clusters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<HciCluster>;
  @doc("List all HCI clusters in a subscription.")
  listBySubscription is ArmListBySubscription<HciCluster>;
  @doc("Upload certificate.")
  uploadCertificate is ArmResourceActionNoResponseContentAsync<
    HciCluster,
    UploadCertificateRequest
  >;
  @doc("Create cluster identity.")
  createIdentity is ArmResourceActionAsync<
    HciCluster,
    void,
    ClusterIdentityResponse
  >;
  @doc("Extends Software Assurance Benefit to a cluster")
  extendSoftwareAssuranceBenefit is ArmResourceActionAsync<
    HciCluster,
    SoftwareAssuranceChangeRequest,
    HciCluster
  >;
  @doc("List Offers available across publishers for the HCI Cluster.")
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
    OfferList
  >;
}
