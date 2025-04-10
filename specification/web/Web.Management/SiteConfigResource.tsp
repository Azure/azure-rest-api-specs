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
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = SiteConfigResource,
        KeyName = "web",
        SegmentName = "config",
        NamePattern = ""
      >>
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
  @patch(#{ implicitOptionality: false })
  @operationId("WebApps_UpdateConfiguration")
  updateConfiguration is SiteConfigResourceOps.CustomPatchSync<
    SiteConfigResource,
    PatchModel = SiteConfigResource
  >;

  /**
   * Description for Gets a list of web app configuration snapshots identifiers. Each element of the list contains a timestamp and the ID of the snapshot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("snapshots")
  @operationId("WebApps_ListConfigurationSnapshotInfo")
  listConfigurationSnapshotInfo is SiteConfigResourceOps.ActionSync<
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
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = SiteConfigResource,
          KeyName = "web",
          SegmentName = "config",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = SiteConfigResource,
        KeyName = "snapshotId",
        SegmentName = "snapshots",
        NamePattern = ""
      >>
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
  listConfigurations is SiteConfigResourceOperationGroupOps.List<
    SiteConfigResource,
    Response = ArmResponse<SiteConfigResourceCollection>
  >;

  /**
   * Description for Reverts the configuration of an app to a previous snapshot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("recover")
  @operationId("WebApps_RecoverSiteConfigurationSnapshot")
  recoverSiteConfigurationSnapshot is SiteConfigResourceOperationGroupOps.ActionSync<
    SiteConfigResource,
    void,
    NoContentResponse
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
        Resource = SiteConfigResource,
        KeyName = "web",
        SegmentName = "config",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface SiteConfigResourceOperationGroup {
  /**
   * Description for Gets the configuration of an app, such as platform version and bitness, default documents, virtual applications, Always On, etc.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetConfigurationSlot")
  getConfigurationSlot is SiteConfigResourceOperationGroupOps.Read<SiteConfigResource>;

  /**
   * Description for Updates the configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateConfigurationSlot")
  createOrUpdateConfigurationSlot is SiteConfigResourceOperationGroupOps.CreateOrUpdateSync<
    SiteConfigResource,
    Response = ArmResourceUpdatedResponse<SiteConfigResource>
  >;

  /**
   * Description for Updates the configuration of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("WebApps_UpdateConfigurationSlot")
  updateConfigurationSlot is SiteConfigResourceOperationGroupOps.CustomPatchSync<
    SiteConfigResource,
    PatchModel = SiteConfigResource
  >;

  /**
   * Description for Gets a list of web app configuration snapshots identifiers. Each element of the list contains a timestamp and the ID of the snapshot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("snapshots")
  @operationId("WebApps_ListConfigurationSnapshotInfoSlot")
  listConfigurationSnapshotInfoSlot is SiteConfigResourceOperationGroupOps.ActionSync<
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
        ...KeysOf<ResourceNameParameter<
          Resource = SiteConfigResource,
          KeyName = "web",
          SegmentName = "config",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = SiteConfigResource,
        KeyName = "snapshotId",
        SegmentName = "snapshots",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface SiteConfigResourceOperationGroup {
  /**
   * Description for Gets a snapshot of the configuration of an app at a previous point in time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetConfigurationSnapshotSlot")
  getConfigurationSnapshotSlot is SiteConfigResourceOperationGroupOps.Read<SiteConfigResource>;

  /**
   * Description for List the configurations of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListConfigurationsSlot")
  listConfigurationsSlot is SiteConfigResourceOperationGroupOps.List<
    SiteConfigResource,
    Response = ArmResponse<SiteConfigResourceCollection>
  >;

  /**
   * Description for Reverts the configuration of an app to a previous snapshot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("recover")
  @operationId("WebApps_RecoverSiteConfigurationSnapshotSlot")
  recoverSiteConfigurationSnapshotSlot is SiteConfigResourceOperationGroupOps.ActionSync<
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
@@doc(SiteConfigResourceOperationGroup.createOrUpdateConfigurationSlot::parameters.resource,
  "JSON representation of a SiteConfig object. See example."
);
@@doc(SiteConfigResourceOperationGroup.updateConfigurationSlot::parameters.properties,
  "JSON representation of a SiteConfig object. See example."
);
