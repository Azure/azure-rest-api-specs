import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ArcSetting.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Details of a particular extension in HCI Cluster.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ArcSetting)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ExtensionProperties)
model Extension extends ProxyResourceBase {
  /**
   * The name of the machine extension.
   */
  @path
  @key("extensionName")
  @segment("extensions")
  @visibility("read")
  name: string;

  /**
   * Describes Machine Extension Properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ExtensionProperties;
}

@armResourceOperations
interface Extensions {
  /**
   * Get particular Arc Extension of HCI Cluster.
   */
  get is ArmResourceRead<Extension>;

  /**
   * Create Extension for HCI cluster.
   */
  create is ArmResourceCreateOrReplaceAsync<
    Extension,
    BaseParameters<Extension>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update Extension for HCI cluster.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<Extension, Extension>;

  /**
   * Delete particular Arc Extension of HCI Cluster.
   */
  delete is ArmResourceDeleteAsync<
    Extension,
    BaseParameters<Extension>,
    ArmAsyncOperationHeader
  >;

  /**
   * List all Extensions under ArcSetting resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Extensions_ListByArcSetting")
  listByArcSetting is ArmResourceListByParent<Extension>;

  /**
   * Upgrade a particular Arc Extension of HCI Cluster.
   */
  upgrade is ArmResourceActionNoResponseContentAsync<
    Extension,
    ExtensionUpgradeParameters,
    BaseParameters<Extension>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(Extensions.create::parameters.resource, "json", "extension");
@@extension(Extensions.create::parameters.resource,
  "x-ms-client-name",
  "extension"
);
@@doc(Extensions.create::parameters.resource,
  "Details of the Machine Extension to be created."
);
@@projectedName(Extensions.update::parameters.properties, "json", "extension");
@@extension(Extensions.update::parameters.properties,
  "x-ms-client-name",
  "extension"
);
@@doc(Extensions.update::parameters.properties,
  "Details of the Machine Extension to be created."
);
@@projectedName(Extensions.upgrade::parameters.body,
  "json",
  "extensionUpgradeParameters"
);
@@extension(Extensions.upgrade::parameters.body,
  "x-ms-client-name",
  "extensionUpgradeParameters"
);
@@doc(Extensions.upgrade::parameters.body,
  "Parameters supplied to the Upgrade Extensions operation."
);
