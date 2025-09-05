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
 * Source control configuration for an app.
 */
@singleton("web")
@parentResource(Site)
model SiteSourceControl
  is Azure.ResourceManager.ProxyResource<SiteSourceControlProperties> {
  ...ResourceNameParameter<
    Resource = SiteSourceControl,
    KeyName = "sourcecontrol",
    SegmentName = "sourcecontrols",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SiteSourceControlOps
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

        /** Name of the deployment slot. If a slot is not specified, the API will get the source control configuration for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** undefined */
        @path
        @segment("sourcecontrols")
        @key
        web: "web",
      }
    > {}

@armResourceOperations
interface SiteSourceControls {
  /**
   * Description for Gets the source control configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" ""
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" ""
  @operationId("WebApps_GetSourceControlSlot")
  getSourceControlSlot is SiteSourceControlOps.Read<
    SiteSourceControl,
    Response = ArmResponse<SiteSourceControl> | ArmResourceCreatedSyncResponse<SiteSourceControl> | (AcceptedResponse & {
      @bodyRoot
      _: SiteSourceControl;
    })
  >;

  /**
   * Description for Updates the source control configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateSourceControlSlot")
  createOrUpdateSourceControlSlot is SiteSourceControlOps.CreateOrUpdateAsync<
    SiteSourceControl,
    Response = ArmResourceUpdatedResponse<SiteSourceControl> | ArmResourceCreatedResponse<
      SiteSourceControl,
      ArmLroLocationHeader<FinalResult = SiteSourceControl> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: SiteSourceControl;
    })
  >;

  /**
   * Description for Updates the source control configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" ""
  @operationId("WebApps_UpdateSourceControlSlot")
  @patch(#{ implicitOptionality: false })
  updateSourceControlSlot is SiteSourceControlOps.CustomPatchSync<
    SiteSourceControl,
    PatchModel = SiteSourceControl,
    Response = ArmResponse<SiteSourceControl> | ArmResourceCreatedSyncResponse<SiteSourceControl> | (AcceptedResponse & {
      @bodyRoot
      _: SiteSourceControl;
    })
  >;

  /**
   * Description for Deletes the source control configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" ""
  @operationId("WebApps_DeleteSourceControlSlot")
  deleteSourceControlSlot is SiteSourceControlOps.DeleteSync<
    SiteSourceControl,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("additionalFlags")
      additionalFlags?: string;
    },
    Response = ArmDeletedResponse | AcceptedResponse | ArmNotFoundResponse
  >;
}
@armResourceOperations
interface SiteSourceControlOperationGroupOps
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
        /** undefined */
        @path
        @segment("sourcecontrols")
        @key
        web: "web",
      }
    > {}

@armResourceOperations
interface SiteSourceControlOperationGroup {
  /**
   * Description for Gets the source control configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" ""
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" ""
  @operationId("WebApps_GetSourceControl")
  getSourceControl is SiteSourceControlOperationGroupOps.Read<
    SiteSourceControl,
    Response = ArmResponse<SiteSourceControl> | ArmResourceCreatedSyncResponse<SiteSourceControl> | (AcceptedResponse & {
      @bodyRoot
      _: SiteSourceControl;
    })
  >;

  /**
   * Description for Updates the source control configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateSourceControl")
  createOrUpdateSourceControl is SiteSourceControlOperationGroupOps.CreateOrUpdateAsync<
    SiteSourceControl,
    Response = ArmResourceUpdatedResponse<SiteSourceControl> | ArmResourceCreatedResponse<
      SiteSourceControl,
      ArmLroLocationHeader<FinalResult = SiteSourceControl> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: SiteSourceControl;
    })
  >;

  /**
   * Description for Updates the source control configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" ""
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("WebApps_UpdateSourceControl")
  @patch(#{ implicitOptionality: false })
  updateSourceControl is SiteSourceControlOperationGroupOps.CustomPatchSync<
    SiteSourceControl,
    PatchModel = SiteSourceControl,
    Response = ArmResponse<SiteSourceControl> | ArmResourceCreatedSyncResponse<SiteSourceControl> | (AcceptedResponse & {
      @bodyRoot
      _: SiteSourceControl;
    })
  >;

  /**
   * Description for Deletes the source control configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" ""
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteSourceControl")
  deleteSourceControl is SiteSourceControlOperationGroupOps.DeleteSync<
    SiteSourceControl,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("additionalFlags")
      additionalFlags?: string;
    },
    Response = ArmDeletedResponse | AcceptedResponse | ArmNotFoundResponse
  >;
}

@@doc(SiteSourceControl.name, "");
@@doc(SiteSourceControl.properties,
  "SiteSourceControl resource specific properties"
);
@@doc(SiteSourceControls.createOrUpdateSourceControlSlot::parameters.resource,
  "JSON representation of a SiteSourceControl object. See example."
);
@@doc(SiteSourceControls.updateSourceControlSlot::parameters.properties,
  "JSON representation of a SiteSourceControl object. See example."
);
@@doc(SiteSourceControlOperationGroup.createOrUpdateSourceControl::parameters.resource,
  "JSON representation of a SiteSourceControl object. See example."
);
@@doc(SiteSourceControlOperationGroup.updateSourceControl::parameters.properties,
  "JSON representation of a SiteSourceControl object. See example."
);
