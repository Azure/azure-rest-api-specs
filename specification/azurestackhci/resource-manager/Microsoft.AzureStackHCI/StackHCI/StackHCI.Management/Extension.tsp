import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ArcSetting.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Details of a particular extension in HCI Cluster.
 */
@parentResource(ArcSetting)
model Extension is Azure.ResourceManager.ProxyResource<ExtensionProperties> {
  ...ResourceNameParameter<
    Resource = Extension,
    KeyName = "extensionName",
    SegmentName = "extensions",
    NamePattern = ""
  >;
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
  create is ArmResourceCreateOrReplaceAsync<Extension>;

  /**
   * Update Extension for HCI cluster.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Extension, PatchModel = ExtensionPatch>;

  /**
   * Delete particular Arc Extension of HCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Extension,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all Extensions under ArcSetting resource.
   */
  listByArcSetting is ArmResourceListByParent<
    Extension,
    Response = ArmResponse<ExtensionList>
  >;

  /**
   * Upgrade a particular Arc Extension of HCI Cluster.
   */
  upgrade is ArmResourceActionAsyncBase<
    Extension,
    ExtensionUpgradeParameters,
    ArmAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Extension>
  >;
}

@@doc(Extension.name, "The name of the machine extension.");
@@doc(Extension.properties, "Describes Machine Extension Properties.");
@@doc(Extensions.create::parameters.resource,
  "Details of the Machine Extension to be created."
);
@@doc(Extensions.update::parameters.properties,
  "Details of the Machine Extension to be created."
);
@@doc(Extensions.upgrade::parameters.body,
  "Parameters supplied to the Upgrade Extensions operation."
);
