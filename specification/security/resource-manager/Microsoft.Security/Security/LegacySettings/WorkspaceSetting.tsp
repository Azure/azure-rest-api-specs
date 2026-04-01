import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * Configures where to store the OMS agent data for workspaces under a scope
 */
@subscriptionResource
model WorkspaceSetting
  is Azure.ResourceManager.ProxyResource<WorkspaceSettingProperties> {
  ...ResourceNameParameter<
    Resource = WorkspaceSetting,
    KeyName = "workspaceSettingName",
    SegmentName = "workspaceSettings",
    NamePattern = ""
  >;
}

@armResourceOperations
@tag("Workspace Settings")
interface WorkspaceSettings {
  /**
   * Settings about where we should store your security data and logs. If the result is empty, it means that no custom-workspace configuration was set
   */
  get is ArmResourceRead<
    WorkspaceSetting,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * creating settings about where we should store your security data and logs
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceSync<
    WorkspaceSetting,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResourceUpdatedResponse<WorkspaceSetting>,
    Error = CloudError
  >;

  /**
   * Settings about where we should store your security data and logs
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    WorkspaceSetting,
    PatchModel = WorkspaceSetting,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;

  /**
   * Deletes the custom workspace settings for this subscription. new VMs will report to the default workspace
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteSync<
    WorkspaceSetting,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Settings about where we should store your security data and logs. If the result is empty, it means that no custom-workspace configuration was set
   */
  list is ArmResourceListByParent<
    WorkspaceSetting,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<WorkspaceSettingList>,
    Error = CloudError
  >;
}

@@doc(WorkspaceSetting.name, "Name of the security setting");
@@doc(WorkspaceSetting.properties, "Workspace setting data");
@@doc(WorkspaceSettings.create::parameters.resource,
  "Security data setting object"
);
@@doc(WorkspaceSettings.update::parameters.properties,
  "Security data setting object"
);
