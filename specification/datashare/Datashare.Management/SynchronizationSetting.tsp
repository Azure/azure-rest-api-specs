import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Share.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
// FIXME: SynchronizationSetting has no properties property
/**
 * A Synchronization Setting data transfer object.
 */
@parentResource(Share)
model SynchronizationSetting is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = SynchronizationSetting,
    KeyName = "synchronizationSettingName",
    SegmentName = "synchronizationSettings",
    NamePattern = ""
  >;

  /**
   * Kind of synchronization setting.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: SynchronizationSettingKind;
}

@armResourceOperations
interface SynchronizationSettings {
  /**
   * Get a synchronizationSetting in a share
   */
  get is ArmResourceRead<SynchronizationSetting>;

  /**
   * Create a synchronizationSetting
   */
  create is ArmResourceCreateOrReplaceSync<SynchronizationSetting>;

  /**
   * Delete a synchronizationSetting in a share
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    SynchronizationSetting,
    Response = ArmResponse<OperationResponse> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List synchronizationSettings in a share
   */
  listByShare is ArmResourceListByParent<
    SynchronizationSetting,
    Parameters = {
      /**
       * continuation token
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<SynchronizationSettingList>
  >;
}

@@doc(SynchronizationSetting.name, "The name of the synchronizationSetting.");
@@doc(SynchronizationSettings.create::parameters.resource,
  "The new synchronization setting information."
);
