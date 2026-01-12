import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * A Kubernetes cluster specialized for web workloads by Azure App Service
 */
model KubeEnvironment
  is Azure.ResourceManager.TrackedResource<KubeEnvironmentProperties> {
  ...ResourceNameParameter<
    Resource = KubeEnvironment,
    KeyName = "name",
    SegmentName = "kubeEnvironments",
    NamePattern = ""
  >;

  /**
   * Extended Location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface KubeEnvironments {
  /**
   * Description for Get the properties of a Kubernetes Environment.
   */
  @summary("Get the properties of a Kubernetes Environment.")
  get is ArmResourceRead<KubeEnvironment, Error = DefaultErrorResponse>;

  /**
   * Description for Creates or updates a Kubernetes Environment.
   */
  @summary("Creates or updates a Kubernetes Environment.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    KubeEnvironment,
    LroHeaders = ArmLroLocationHeader<FinalResult = KubeEnvironment> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates or updates a Kubernetes Environment.
   */
  @summary("Creates or updates a Kubernetes Environment.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    KubeEnvironment,
    PatchModel = KubeEnvironmentPatchResource,
    Response = ArmResponse<KubeEnvironment> | ArmResourceCreatedSyncResponse<KubeEnvironment>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Delete a Kubernetes Environment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a Kubernetes Environment.")
  delete is ArmResourceDeleteWithoutOkAsync<
    KubeEnvironment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get all the Kubernetes Environments in a resource group.
   */
  @summary("Get all the Kubernetes Environments in a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    KubeEnvironment,
    Response = ArmResponse<KubeEnvironmentCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Get all Kubernetes Environments for a subscription.
   */
  @summary("Get all Kubernetes Environments for a subscription.")
  listBySubscription is ArmListBySubscription<
    KubeEnvironment,
    Response = ArmResponse<KubeEnvironmentCollection>,
    Error = DefaultErrorResponse
  >;
}

@@doc(KubeEnvironment.name, "Name of the Kubernetes Environment.");
@@doc(KubeEnvironment.properties,
  "KubeEnvironment resource specific properties"
);
@@doc(KubeEnvironments.createOrUpdate::parameters.resource,
  "Configuration details of the Kubernetes Environment."
);
@@doc(KubeEnvironments.update::parameters.properties,
  "Configuration details of the Kubernetes Environment."
);
