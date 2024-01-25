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

namespace Microsoft.AzureStackHCI;
/**
 * Cluster details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ClusterProperties)
model Cluster extends TrackedResourceBase {
  /**
   * The name of the cluster.
   */
  @path
  @key("clusterName")
  @segment("clusters")
  @visibility("read")
  name: string;

  /**
   * Cluster properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ClusterProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
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
  create is ArmResourceCreateOrReplaceSync<Cluster>;

  /**
   * Update an HCI cluster.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Cluster, ClusterPatch>;

  /**
   * Delete an HCI cluster.
   */
  delete is ArmResourceDeleteAsync<Cluster>;

  /**
   * List all HCI clusters in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Clusters_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  /**
   * List all HCI clusters in a subscription.
   */
  listBySubscription is ArmListBySubscription<Cluster>;

  /**
   * Upload certificate.
   */
  uploadCertificate is ArmResourceActionNoResponseContentAsync<
    Cluster,
    UploadCertificateRequest,
    BaseParameters<Cluster>,
    ArmAsyncOperationHeader
  >;

  /**
   * Create cluster identity.
   */
  createIdentity is ArmResourceActionAsync<
    Cluster,
    void,
    ClusterIdentityResponse,
    BaseParameters<Cluster>,
    ArmAsyncOperationHeader
  >;

  /**
   * Extends Software Assurance Benefit to a cluster
   */
  extendSoftwareAssuranceBenefit is ArmResourceActionAsync<
    Cluster,
    SoftwareAssuranceChangeRequest,
    Cluster,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  /**
   * List Offers available across publishers for the HCI Cluster.
   */
  // FIXME: Offers_ListByCluster could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Offers_ListByCluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/clusters/{clusterName}/offers")
  @get
  listByCluster is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the cluster.
       */
      @path
      clusterName: string;

      /**
       * Specify $expand=content,contentVersion to populate additional fields related to the marketplace offer.
       */
      @query("$expand")
      $expand?: string;
    },
    ResourceListResult<Offer>
  >;
}

@@projectedName(Clusters.create::parameters.resource, "json", "cluster");
@@extension(Clusters.create::parameters.resource,
  "x-ms-client-name",
  "cluster"
);
@@doc(Clusters.create::parameters.resource, "Details of the HCI cluster.");
@@projectedName(Clusters.update::parameters.properties, "json", "cluster");
@@extension(Clusters.update::parameters.properties,
  "x-ms-client-name",
  "cluster"
);
@@doc(Clusters.update::parameters.properties, "Details of the HCI cluster.");
@@projectedName(Clusters.uploadCertificate::parameters.body,
  "json",
  "uploadCertificateRequest"
);
@@extension(Clusters.uploadCertificate::parameters.body,
  "x-ms-client-name",
  "uploadCertificateRequest"
);
@@doc(Clusters.uploadCertificate::parameters.body,
  "Upload certificate request."
);
@@projectedName(Clusters.extendSoftwareAssuranceBenefit::parameters.body,
  "json",
  "softwareAssuranceChangeRequest"
);
@@extension(Clusters.extendSoftwareAssuranceBenefit::parameters.body,
  "x-ms-client-name",
  "softwareAssuranceChangeRequest"
);
@@doc(Clusters.extendSoftwareAssuranceBenefit::parameters.body,
  "Software Assurance Change Request Payload"
);
