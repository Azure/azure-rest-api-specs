import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Premier add-on.
 */
@parentResource(Site)
model PremierAddOn
  is Azure.ResourceManager.TrackedResource<PremierAddOnProperties> {
  ...ResourceNameParameter<
    Resource = PremierAddOn,
    KeyName = "premierAddOnName",
    SegmentName = "premieraddons",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PremierAddOnOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PremierAddOn,
        KeyName = "premierAddOnName",
        SegmentName = "premieraddons",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface PremierAddOns {
  /**
   * Description for Gets a named add-on of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetPremierAddOn")
  getPremierAddOn is PremierAddOnOps.Read<PremierAddOn>;

  /**
   * Description for Updates a named add-on of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_AddPremierAddOn")
  addPremierAddOn is PremierAddOnOps.CreateOrUpdateSync<
    PremierAddOn,
    Response = ArmResourceUpdatedResponse<PremierAddOn>
  >;

  /**
   * Description for Updates a named add-on of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("WebApps_UpdatePremierAddOn")
  updatePremierAddOn is PremierAddOnOps.CustomPatchSync<
    PremierAddOn,
    PatchModel = PremierAddOnPatchResource
  >;

  /**
   * Description for Delete a premier add-on from an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeletePremierAddOn")
  deletePremierAddOn is PremierAddOnOps.DeleteSync<
    PremierAddOn,
    Response = ArmDeletedResponse
  >;
}
@armResourceOperations
interface PremierAddOnOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "slot",
          SegmentName = "slots",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PremierAddOn,
        KeyName = "premierAddOnName",
        SegmentName = "premieraddons",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface PremierAddOnOperationGroup {
  /**
   * Description for Gets a named add-on of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetPremierAddOnSlot")
  getPremierAddOnSlot is PremierAddOnOperationGroupOps.Read<PremierAddOn>;

  /**
   * Description for Updates a named add-on of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_AddPremierAddOnSlot")
  addPremierAddOnSlot is PremierAddOnOperationGroupOps.CreateOrUpdateSync<
    PremierAddOn,
    Response = ArmResourceUpdatedResponse<PremierAddOn>
  >;

  /**
   * Description for Updates a named add-on of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("WebApps_UpdatePremierAddOnSlot")
  updatePremierAddOnSlot is PremierAddOnOperationGroupOps.CustomPatchSync<
    PremierAddOn,
    PatchModel = PremierAddOnPatchResource
  >;

  /**
   * Description for Delete a premier add-on from an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeletePremierAddOnSlot")
  deletePremierAddOnSlot is PremierAddOnOperationGroupOps.DeleteSync<
    PremierAddOn,
    Response = ArmDeletedResponse
  >;
}

@@doc(PremierAddOn.name, "Add-on name.");
@@doc(PremierAddOn.properties, "PremierAddOn resource specific properties");
@@doc(PremierAddOns.addPremierAddOn::parameters.resource,
  "A JSON representation of the edited premier add-on."
);
@@doc(PremierAddOns.updatePremierAddOn::parameters.properties,
  "A JSON representation of the edited premier add-on."
);
@@doc(PremierAddOnOperationGroup.addPremierAddOnSlot::parameters.resource,
  "A JSON representation of the edited premier add-on."
);
@@doc(PremierAddOnOperationGroup.updatePremierAddOnSlot::parameters.properties,
  "A JSON representation of the edited premier add-on."
);
