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
  get is ArmResourceRead<OpenShiftCluster>;

  /**
   * The operation returns properties of a OpenShift cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    OpenShiftCluster,
    LroHeaders = ArmLroLocationHeader<FinalResult = OpenShiftCluster> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation returns properties of a OpenShift cluster.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    OpenShiftCluster,
    PatchModel = OpenShiftClusterUpdate,
    Response = ArmResponse<OpenShiftCluster> | ArmResourceCreatedResponse<OpenShiftCluster>
  >;

  /**
   * The operation returns nothing.
   */
  delete is ArmResourceDeleteWithoutOkAsync<OpenShiftCluster>;

  /**
   * The operation returns properties of each OpenShift cluster.
   */
  listByResourceGroup is ArmResourceListByParent<
    OpenShiftCluster,
    Response = ArmResponse<OpenShiftClusterList>
  >;

  /**
   * The operation returns properties of each OpenShift cluster.
   */
  list is ArmListBySubscription<
    OpenShiftCluster,
    Response = ArmResponse<OpenShiftClusterList>
  >;

  /**
   * The operation returns the admin kubeconfig.
   */
  listAdminCredentials is ArmResourceActionSync<
    OpenShiftCluster,
    void,
    ArmResponse<OpenShiftClusterAdminKubeconfig>
  >;

  /**
   * The operation returns the credentials.
   */
  listCredentials is ArmResourceActionSync<
    OpenShiftCluster,
    void,
    ArmResponse<OpenShiftClusterCredentials>
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
