import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * ArcSetting details.
 */
@parentResource(Cluster)
model ArcSetting is ProxyResource<ArcSettingProperties> {
  /**
   * The name of the proxy resource holding details of HCI ArcSetting information.
   */
  @path
  @key("arcSettingName")
  @segment("arcSettings")
  name: string;
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
  create is ArmResourceCreateOrReplaceSync<ArcSetting>;

  /**
   * Update ArcSettings for HCI cluster.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ArcSetting, ArcSettingsPatch>;

  /**
   * Delete ArcSetting resource details of HCI Cluster.
   */
  delete is ArmResourceDeleteAsync<
    ArcSetting,
    BaseParameters<ArcSetting>,
    ArmAsyncOperationHeader
  >;

  /**
   * Get ArcSetting resources of HCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ArcSettings_ListByCluster")
  listByCluster is ArmResourceListByParent<ArcSetting>;

  /**
   * Generate password for arc settings.
   */
  generatePassword is ArmResourceActionSync<
    ArcSetting,
    void,
    PasswordCredential
  >;

  /**
   * Create Aad identity for arc settings.
   */
  createIdentity is ArmResourceActionAsync<
    ArcSetting,
    void,
    ArcIdentityResponse,
    BaseParameters<ArcSetting>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(ArcSettings.create::parameters.resource, "json", "arcSetting");
@@extension(ArcSettings.create::parameters.resource,
  "x-ms-client-name",
  "arcSetting"
);
@@doc(ArcSettings.create::parameters.resource,
  "Parameters supplied to the Create ArcSetting resource for this HCI cluster."
);
@@projectedName(ArcSettings.update::parameters.properties,
  "json",
  "arcSetting"
);
@@extension(ArcSettings.update::parameters.properties,
  "x-ms-client-name",
  "arcSetting"
);
@@doc(ArcSettings.update::parameters.properties,
  "ArcSettings parameters that needs to be updated"
);
