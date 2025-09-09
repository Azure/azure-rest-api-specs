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
 * Web app configuration ARM resource.
 */
@singleton("web")
@parentResource(Site)
model SiteConfigResource is Azure.ResourceManager.ProxyResource<SiteConfig> {
  ...ResourceNameParameter<
    Resource = SiteConfigResource,
    KeyName = "config",
    SegmentName = "config",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SiteConfigResourceOps
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
        @segment("config")
        @key
        web: "web",
      }
    > {}

@armResourceOperations
interface SiteConfigResources {
  /**
   * Description for Gets the configuration of an app, such as platform version and bitness, default documents, virtual applications, Always On, etc.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetConfiguration")
  getConfiguration is SiteConfigResourceOps.Read<SiteConfigResource>;

  /**
   * Description for Updates the configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateConfiguration")
  createOrUpdateConfiguration is SiteConfigResourceOps.CreateOrUpdateSync<
    SiteConfigResource,
    Response = ArmResourceUpdatedResponse<SiteConfigResource>
  >;

  /**
   * Description for Updates the configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_UpdateConfiguration")
  @patch(#{ implicitOptionality: false })
  updateConfiguration is SiteConfigResourceOps.CustomPatchSync<
    SiteConfigResource,
    PatchModel = SiteConfigResource
  >;

  /**
   * Description for Gets a list of web app configuration snapshots identifiers. Each element of the list contains a timestamp and the ID of the snapshot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListConfigurationSnapshotInfo")
  @get
  @action("snapshots")
  @list
  listConfigurationSnapshotInfo is ArmResourceActionSync<
    SiteConfigResource,
    void,
    ArmResponse<SiteConfigurationSnapshotInfoCollection>
  >;
}
@armResourceOperations
interface SiteConfigResourceOperationGroupOps
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

        /** undefined */
        @path
        @segment("config")
        @key
        web: "web",
      },
      {
        /** The ID of the snapshot to read. */
        @path
        @segment("snapshots")
        @key
        snapshotId: string,
      }
    > {}

@armResourceOperations
interface ListConfigurationsOps
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
        @segment("config")
        @key
        web: "web",
      }
    > {}

@armResourceOperations
interface SiteConfigResourceOperationGroup {
  /**
   * Description for Gets a snapshot of the configuration of an app at a previous point in time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetConfigurationSnapshot")
  getConfigurationSnapshot is SiteConfigResourceOperationGroupOps.Read<SiteConfigResource>;

  /**
   * Description for List the configurations of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListConfigurations")
  listConfigurations is ListConfigurationsOps.List<
    SiteConfigResource,
    Response = ArmResponse<SiteConfigResourceCollection>
  >;

  /**
   * Description for Reverts the configuration of an app to a previous snapshot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_RecoverSiteConfigurationSnapshot")
  @action("recover")
  recoverSiteConfigurationSnapshot is SiteConfigResourceOperationGroupOps.ActionSync<
    SiteConfigResource,
    void,
    NoContentResponse
  >;
}
@armResourceOperations
interface SiteConfigSlotResourceOperationGroupOps
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

        /** Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** undefined */
        @path
        @segment("config")
        @key
        web: "web",
      }
    > {}

@armResourceOperations
interface SiteConfigSlotResourceOperationGroup {
  /**
   * Description for Gets the configuration of an app, such as platform version and bitness, default documents, virtual applications, Always On, etc.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetConfigurationSlot")
  getConfigurationSlot is SiteConfigSlotResourceOperationGroupOps.Read<
    SiteConfigResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates the configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateConfigurationSlot")
  createOrUpdateConfigurationSlot is SiteConfigSlotResourceOperationGroupOps.CreateOrUpdateSync<
    SiteConfigResource,
    Response = ArmResourceUpdatedResponse<SiteConfigResource>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Updates the configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_UpdateConfigurationSlot")
  @patch(#{ implicitOptionality: false })
  updateConfigurationSlot is SiteConfigSlotResourceOperationGroupOps.CustomPatchSync<
    SiteConfigResource,
    PatchModel = SiteConfigResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets a list of web app configuration snapshots identifiers. Each element of the list contains a timestamp and the ID of the snapshot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListConfigurationSnapshotInfoSlot")
  @get
  @action("snapshots")
  @list
  listConfigurationSnapshotInfoSlot is SiteConfigSlotResourceOperationGroupOps.ActionSync<
    SiteConfigResource,
    void,
    ArmResponse<SiteConfigurationSnapshotInfoCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@armResourceOperations
interface SiteConfigResourceSnapshotSlotOperationGroupOps
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

        /** Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,

        /** undefined */
        @path
        @segment("config")
        @key
        web: "web",
      },
      {
        /** The ID of the snapshot to read. */
        @path
        @segment("snapshots")
        @key
        snapshotId: string,
      }
    > {}

@armResourceOperations
interface ListConfigurationsSlotOps
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

        /** Name of the deployment slot. If a slot is not specified, the API will return configuration for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** undefined */
        @path
        @segment("config")
        @key
        web: "web",
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SiteConfigSnapshotSlotResourceOperationGroup {
  /**
   * Description for Gets a snapshot of the configuration of an app at a previous point in time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetConfigurationSnapshotSlot")
  getConfigurationSnapshotSlot is SiteConfigResourceSnapshotSlotOperationGroupOps.Read<SiteConfigResource>;

  /**
   * Description for List the configurations of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListConfigurationsSlot")
  listConfigurationsSlot is ListConfigurationsSlotOps.List<
    SiteConfigResource,
    Response = ArmResponse<SiteConfigResourceCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Reverts the configuration of an app to a previous snapshot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_RecoverSiteConfigurationSnapshotSlot")
  @action("recover")
  recoverSiteConfigurationSnapshotSlot is SiteConfigResourceSnapshotSlotOperationGroupOps.ActionSync<
    SiteConfigResource,
    void,
    NoContentResponse
  >;
}

@@doc(SiteConfigResource.name, "");
@@doc(SiteConfigResource.properties, "Core resource properties");
@@doc(SiteConfigResources.createOrUpdateConfiguration::parameters.resource,
  "JSON representation of a SiteConfig object. See example."
);
@@doc(SiteConfigResources.updateConfiguration::parameters.properties,
  "JSON representation of a SiteConfig object. See example."
);
@@doc(SiteConfigSlotResourceOperationGroup.createOrUpdateConfigurationSlot::parameters.resource,
  "JSON representation of a SiteConfig object. See example."
);
@@doc(SiteConfigSlotResourceOperationGroup.updateConfigurationSlot::parameters.properties,
  "JSON representation of a SiteConfig object. See example."
);
