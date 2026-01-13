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

namespace Microsoft.Web;
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

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface PremierAddOnOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** Add-on name. */
        @path
        @segment("premieraddons")
        @key
        premierAddOnName: string,
      }
    > {}

@armResourceOperations
interface PremierAddOns {
  /**
   * Description for Gets a named add-on of an app.
   */
  @summary("Gets a named add-on of an app.")
  getPremierAddOn is PremierAddOnOps.Read<
    PremierAddOn,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates a named add-on of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates a named add-on of an app.")
  addPremierAddOn is PremierAddOnOps.CreateOrUpdateSync<
    PremierAddOn,
    Response = ArmResourceUpdatedResponse<PremierAddOn>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates a named add-on of an app.
   */
  @summary("Updates a named add-on of an app.")
  @patch(#{ implicitOptionality: false })
  updatePremierAddOn is PremierAddOnOps.CustomPatchSync<
    PremierAddOn,
    PatchModel = PremierAddOnPatchResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Delete a premier add-on from an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a premier add-on from an app.")
  deletePremierAddOn is PremierAddOnOps.DeleteSync<
    PremierAddOn,
    Response = ArmDeletedResponse,
    OverrideErrorType = DefaultErrorResponse
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

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API will get the named add-on for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Add-on name. */
        @path
        @segment("premieraddons")
        @key
        premierAddOnName: string,
      }
    > {}

@armResourceOperations
interface PremierAddOnOperationGroup {
  /**
   * Description for Gets a named add-on of an app.
   */
  @summary("Gets a named add-on of an app.")
  getPremierAddOnSlot is PremierAddOnOperationGroupOps.Read<
    PremierAddOn,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates a named add-on of an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates a named add-on of an app.")
  addPremierAddOnSlot is PremierAddOnOperationGroupOps.CreateOrUpdateSync<
    PremierAddOn,
    Response = ArmResourceUpdatedResponse<PremierAddOn>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates a named add-on of an app.
   */
  @summary("Updates a named add-on of an app.")
  @patch(#{ implicitOptionality: false })
  updatePremierAddOnSlot is PremierAddOnOperationGroupOps.CustomPatchSync<
    PremierAddOn,
    PatchModel = PremierAddOnPatchResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Delete a premier add-on from an app.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a premier add-on from an app.")
  deletePremierAddOnSlot is PremierAddOnOperationGroupOps.DeleteSync<
    PremierAddOn,
    Response = ArmDeletedResponse,
    OverrideErrorType = DefaultErrorResponse
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
