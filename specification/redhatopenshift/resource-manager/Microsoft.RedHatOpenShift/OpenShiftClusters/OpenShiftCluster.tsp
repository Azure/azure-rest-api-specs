import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RedHatOpenShift;
/**
 * OpenShiftCluster represents an Azure Red Hat OpenShift cluster.
 */
model OpenShiftCluster
  is Azure.ResourceManager.TrackedResource<OpenShiftClusterProperties> {
  ...ResourceNameParameter<
    Resource = OpenShiftCluster,
    KeyName = "resourceName",
    SegmentName = "openShiftClusters",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface OpenShiftClusters {
  /**
   * The operation returns properties of a OpenShift cluster.
   */
  @summary("Gets a OpenShift cluster with the specified subscription, resource group and resource name.")
  get is ArmResourceRead<OpenShiftCluster, Error = CloudError>;

  /**
   * The operation returns properties of a OpenShift cluster.
   */
  @summary("Creates or updates a OpenShift cluster with the specified subscription, resource group and resource name.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    OpenShiftCluster,
    LroHeaders = ArmLroLocationHeader<FinalResult = OpenShiftCluster> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * The operation returns properties of a OpenShift cluster.
   */
  @summary("Creates or updates a OpenShift cluster with the specified subscription, resource group and resource name.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    OpenShiftCluster,
    PatchModel = OpenShiftClusterUpdate,
    Response = ArmResponse<OpenShiftCluster> | ArmResourceCreatedResponse<
      OpenShiftCluster,
      LroHeaders = ArmLroLocationHeader<FinalResult = OpenShiftCluster> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    Error = CloudError
  >;

  /**
   * The operation returns nothing.
   */
  @summary("Deletes a OpenShift cluster with the specified subscription, resource group and resource name.")
  delete is ArmResourceDeleteWithoutOkAsync<
    OpenShiftCluster,
    Error = CloudError
  >;

  /**
   * The operation returns properties of each OpenShift cluster.
   */
  @summary("Lists OpenShift clusters in the specified subscription and resource group.")
  listByResourceGroup is ArmResourceListByParent<
    OpenShiftCluster,
    Response = ArmResponse<OpenShiftClusterList>,
    Error = CloudError
  >;

  /**
   * The operation returns properties of each OpenShift cluster.
   */
  @summary("Lists OpenShift clusters in the specified subscription.")
  list is ArmListBySubscription<
    OpenShiftCluster,
    Response = ArmResponse<OpenShiftClusterList>,
    Error = CloudError
  >;

  /**
   * The operation returns the admin kubeconfig.
   */
  @summary("Lists admin kubeconfig of an OpenShift cluster with the specified subscription, resource group and resource name.")
  listAdminCredentials is ArmResourceActionSync<
    OpenShiftCluster,
    void,
    OpenShiftClusterAdminKubeconfig,
    Error = CloudError
  >;

  /**
   * The operation returns the credentials.
   */
  @summary("Lists credentials of an OpenShift cluster with the specified subscription, resource group and resource name.")
  listCredentials is ArmResourceActionSync<
    OpenShiftCluster,
    void,
    OpenShiftClusterCredentials,
    Error = CloudError
  >;
}

@@doc(OpenShiftCluster.name, "The name of the OpenShift cluster resource.");
@@doc(OpenShiftCluster.properties, "The cluster properties.");
@@doc(OpenShiftClusters.createOrUpdate::parameters.resource,
  "The OpenShift cluster resource."
);
@@doc(OpenShiftClusters.update::parameters.properties,
  "The OpenShift cluster resource."
);
