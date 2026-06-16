import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * ArcSetting details.
 */
@parentResource(Cluster)
model ArcSetting is Azure.ResourceManager.ProxyResource<ArcSettingProperties> {
  ...ResourceNameParameter<
    Resource = ArcSetting,
    KeyName = "arcSettingName",
    SegmentName = "arcSettings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ArcSettings {
  /**
   * Get ArcSetting resource details of HCI Cluster.
   */
  get is ArmResourceRead<ArcSetting>;

  /**
   * Create ArcSetting for HCI cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceSync<
    ArcSetting,
    Response = ArmResourceUpdatedResponse<ArcSetting>
  >;

  /**
   * Update ArcSettings for HCI cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<ArcSetting, PatchModel = ArcSettingsPatch>;

  /**
   * Delete ArcSetting resource details of HCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ArcSetting,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Get ArcSetting resources of HCI Cluster.
   */
  listByCluster is ArmResourceListByParent<
    ArcSetting,
    Response = ArmResponse<ArcSettingList>
  >;

  /**
   * Generate password for arc settings.
   */
  generatePassword is ArmResourceActionSync<
    ArcSetting,
    void,
    ArmResponse<PasswordCredential>
  >;

  /**
   * Create Aad identity for arc settings.
   */
  @action("createArcIdentity")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createIdentity is ArmResourceActionAsync<
    ArcSetting,
    void,
    ArmResponse<ArcIdentityResponse>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ArcIdentityResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Reconcile Arc Settings with information related to all nodes.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  reconcile is ArmResourceActionAsync<
    ArcSetting,
    ReconcileArcSettingsRequest,
    ArmResponse<ArcSetting>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ArcSetting> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Add consent time for default extensions and initiate extensions installation
   */
  consentAndInstallDefaultExtensions is ArmResourceActionSync<
    ArcSetting,
    void,
    ArmResponse<ArcSetting>
  >;

  /**
   * Initializes ARC Disable process on the cluster
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  initializeDisableProcess is ArmResourceActionAsync<
    ArcSetting,
    void,
    OkResponse,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(ArcSetting.name,
  "The name of the proxy resource holding details of HCI ArcSetting information."
);
@@doc(ArcSetting.properties, "ArcSetting properties.");
@@doc(ArcSettings.create::parameters.resource,
  "Parameters supplied to the Create ArcSetting resource for this HCI cluster."
);
@@doc(ArcSettings.update::parameters.properties,
  "ArcSettings parameters that needs to be updated"
);
@@doc(ArcSettings.reconcile::parameters.body,
  "Request for reconciling Arc Settings."
);
