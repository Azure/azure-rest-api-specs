import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Cluster details.
 */
model Cluster is Azure.ResourceManager.TrackedResource<ClusterProperties> {
  ...ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * This property identifies the purpose of the Cluster deployment. For example, a valid value is AzureLocal
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^[-\\w\\._,\\(\\\\\\)]+$")
  kind?: string;
}

@armResourceOperations
interface Clusters {
  /**
   * Get HCI cluster.
   */
  get is ArmResourceRead<Cluster>;

  /**
   * Create an HCI cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceSync<
    Cluster,
    Response = ArmResourceUpdatedResponse<Cluster>
  >;

  /**
   * Update an HCI cluster.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Cluster, PatchModel = ClusterPatch>;

  /**
   * Delete an HCI cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all HCI clusters in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Cluster,
    Response = ArmResponse<ClusterList>
  >;

  /**
   * List all HCI clusters in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    Cluster,
    Response = ArmResponse<ClusterList>
  >;

  /**
   * Update cluster secrets locations.
   */
  updateSecretsLocations is ArmResourceActionAsync<
    Cluster,
    SecretsLocationsChangeRequest,
    ArmResponse<Cluster>
  >;

  /**
   * Upload certificate.
   */
  uploadCertificate is ArmResourceActionAsyncBase<
    Cluster,
    UploadCertificateRequest,
    ArmAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  /**
   * Create cluster identity.
   */
  @action("createClusterIdentity")
  createIdentity is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<ClusterIdentityResponse>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ClusterIdentityResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Extends Software Assurance Benefit to a cluster
   */
  extendSoftwareAssuranceBenefit is ArmResourceActionAsync<
    Cluster,
    SoftwareAssuranceChangeRequest,
    ArmResponse<Cluster>
  >;

  /**
   * Changes ring of a cluster
   */
  changeRing is ArmResourceActionAsync<
    Cluster,
    ChangeRingRequest,
    ArmResponse<Cluster>
  >;

  /**
   * Trigger Log Collection on a cluster
   */
  triggerLogCollection is ArmResourceActionAsync<
    Cluster,
    LogCollectionRequest,
    ArmResponse<Cluster>
  >;

  /**
   * Configure RemoteSupport on a cluster
   */
  configureRemoteSupport is ArmResourceActionAsync<
    Cluster,
    RemoteSupportRequest,
    ArmResponse<Cluster>
  >;

  /**
   * List Offers available across publishers for the HCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Offers_ListByCluster")
  @list
  @get
  @action("offers")
  listByCluster is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<OfferList>,
    Parameters = {
      /**
       * Specify $expand=content,contentVersion to populate additional fields related to the marketplace offer.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
}

@@doc(Cluster.name, "The name of the cluster.");
@@doc(Cluster.properties, "Cluster properties.");
@@doc(Clusters.create::parameters.resource, "Details of the HCI cluster.");
@@doc(Clusters.update::parameters.properties, "Details of the HCI cluster.");
@@doc(Clusters.uploadCertificate::parameters.body,
  "Upload certificate request."
);
@@doc(Clusters.extendSoftwareAssuranceBenefit::parameters.body,
  "Software Assurance Change Request Payload"
);
@@doc(Clusters.changeRing::parameters.body, "Change ring request payload");
@@doc(Clusters.triggerLogCollection::parameters.body,
  "Trigger Log Collection Request Payload"
);
@@doc(Clusters.configureRemoteSupport::parameters.body,
  "Configure Remote Support Request Payload"
);
