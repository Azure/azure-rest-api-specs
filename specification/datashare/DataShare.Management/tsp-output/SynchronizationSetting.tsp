import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Share.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
// FIXME: SynchronizationSetting has no properties property
/**
 * A Synchronization Setting data transfer object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Share)
@includeInapplicableMetadataInPayload(false)
model SynchronizationSetting extends ProxyDto {
  /**
   * The name of the synchronizationSetting.
   */
  @path
  @key("synchronizationSettingName")
  @segment("synchronizationSettings")
  @visibility("read")
  name: string;

  /**
   * Kind of synchronization setting.
   */
  kind: SynchronizationSettingKind;

  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties?: {};
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
  delete is ArmResourceDeleteAsync<SynchronizationSetting>;

  /**
   * List synchronizationSettings in a share
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SynchronizationSettings_ListByShare")
  listByShare is ArmResourceListByParent<
    SynchronizationSetting,
    {
      ...BaseParameters<SynchronizationSetting>;

      /**
       * continuation token
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}

@@projectedName(SynchronizationSettings.create::parameters.resource,
  "json",
  "synchronizationSetting"
);
@@extension(SynchronizationSettings.create::parameters.resource,
  "x-ms-client-name",
  "synchronizationSetting"
);
@@doc(SynchronizationSettings.create::parameters.resource,
  "The new synchronization setting information."
);
