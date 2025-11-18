import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace Microsoft.AzureStackHCI;
/**
 * ArcSetting details.
 */
@parentResource(Cluster)
model ArcSetting is Azure.ResourceManager.ProxyResource<ArcSettingProperties> {
  ...ResourceNameParameter<
    Resource = ArcSetting,
    KeyName = "arcSettingName",
    SegmentName = "arcSettings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ArcSettings {
  /**
   * Get ArcSetting resource details of HCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  get is ArmResourceRead<ArcSetting>;

  /**
   * Create ArcSetting for HCI cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceSync<
    ArcSetting,
    Response = ArmResourceUpdatedResponse<ArcSetting>
  >;

  /**
   * Update ArcSettings for HCI cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<ArcSetting, PatchModel = ArcSettingsPatch>;

  /**
   * Delete ArcSetting resource details of HCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ArcSetting,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Get ArcSetting resources of HCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  listByCluster is ArmResourceListByParent<
    ArcSetting,
    Response = ArmResponse<ArcSettingList>
  >;

  /**
   * Generate password for arc settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  generatePassword is ArmResourceActionSync<
    ArcSetting,
    void,
    ArmResponse<PasswordCredential>
  >;

  /**
   * Create Aad identity for arc settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("createArcIdentity")
  createIdentity is ArmResourceActionAsync<
    ArcSetting,
    void,
    ArmResponse<StackHciArcIdentityResponseResult>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = StackHciArcIdentityResponseResult> &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader
  >;

  /**
   * Reconcile Arc Settings with information related to all nodes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  reconcile is ArmResourceActionAsync<
    ArcSetting,
    ReconcileArcSettingsRequest,
    ArmResponse<ArcSetting>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ArcSetting> &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader
  >;

  /**
   * Add consent time for default extensions and initiate extensions installation
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  consentAndInstallDefaultExtensions is ArmResourceActionSync<
    ArcSetting,
    void,
    ArmResponse<ArcSetting>
  >;

  /**
   * Initializes ARC Disable process on the cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  initializeDisableProcess is ArmResourceActionAsync<
    ArcSetting,
    void,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader
  >;
}

@@doc(ArcSetting.name,
  "The name of the proxy resource holding details of HCI ArcSetting information."
);
@@doc(ArcSetting.properties, "ArcSetting properties.");
@@doc(ArcSettings.create::parameters.resource,
  "Parameters supplied to the Create ArcSetting resource for this HCI cluster."
);
@@doc(ArcSettings.update::parameters.properties,
  "ArcSettings parameters that needs to be updated"
);
@@doc(ArcSettings.reconcile::parameters.body,
  "Request for reconciling Arc Settings."
);

// Models

/**
 * List of ArcSetting proxy resources for the HCI cluster.
 */
model ArcSettingList is Azure.Core.Page<ArcSetting>;

/**
 * ArcSetting properties.
 */
model ArcSettingProperties {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Provisioning state of the ArcSetting proxy resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The resource group that hosts the Arc agents, ie. Hybrid Compute Machine resources.
   */
  arcInstanceResourceGroup?: string;

  /**
   * App id of arc AAD identity.
   */
  arcApplicationClientId?: string;

  /**
   * Tenant id of arc AAD identity.
   */
  arcApplicationTenantId?: string;

  /**
   * Object id of arc AAD service principal.
   */
  arcServicePrincipalObjectId?: string;

  /**
   * Object id of arc AAD identity.
   */
  arcApplicationObjectId?: string;

  /**
   * Aggregate state of Arc agent across the nodes in this HCI cluster.
   */
  @visibility(Lifecycle.Read)
  aggregateState?: ArcSettingAggregateState;

  /**
   * State of Arc agent in each of the nodes.
   */
  @visibility(Lifecycle.Read)
  perNodeDetails?: PerNodeState[];

  /**
   * contains connectivity related configuration for ARC resources
   */
  connectivityProperties?: ArcConnectivityProperties;

  /**
   * Properties for each of the default extensions category
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["category"])
  defaultExtensions?: DefaultExtensionDetails[];
}

/**
 * Status of Arc agent for a particular node in HCI Cluster.
 */
model PerNodeState {
  /**
   * Name of the Node in HCI Cluster
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Fully qualified resource ID for the Arc agent of this node.
   */
  @visibility(Lifecycle.Read)
  arcInstance?: string;

  /**
   * The service principal id of the arc for server node
   */
  @visibility(Lifecycle.Read)
  arcNodeServicePrincipalObjectId?: string;

  /**
   * State of Arc agent in this node.
   */
  @visibility(Lifecycle.Read)
  state?: NodeArcState;
}

/**
 * Properties for a particular default extension category.
 */
model DefaultExtensionDetails {
  /**
   * Default extension category
   */
  @visibility(Lifecycle.Read)
  category?: string;

  /**
   * Consent time for extension category
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  consentTime?: utcDateTime;
}

/**
 * ArcSetting details to update.
 */
model ArcSettingsPatch {
  /**
   * ArcSettings properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  properties?: ArcSettingsPatchProperties;
}

/**
 * ArcSettings properties.
 */
model ArcSettingsPatchProperties {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * contains connectivity related configuration for ARC resources
   */
  connectivityProperties?: ArcConnectivityProperties;
}

/**
 * The password credential associated with the arc setting.
 */
model PasswordCredential {
  /**
   * The password secret text.
   */
  secretText?: string;

  /**
   * The unique identifier of the password key.
   */
  keyId?: string;

  /**
   * The start date and time of the password validity.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * The end date and time of the password validity.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;
}

/**
 * ArcIdentity details.
 */
@clientName("ArcIdentityResponse")
model StackHciArcIdentityResponseResult {
  /**
   * ArcIdentity properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @visibility(Lifecycle.Read)
  properties?: ArcIdentityResponseProperties;
}

/**
 * Arc identity response properties.
 */
model ArcIdentityResponseProperties {
  /**
   * The Arc application client identifier.
   */
  arcApplicationClientId?: string;

  /**
   * The Arc application tenant identifier.
   */
  arcApplicationTenantId?: string;

  /**
   * The Arc service principal object identifier.
   */
  arcServicePrincipalObjectId?: string;

  /**
   * The Arc application object identifier.
   */
  arcApplicationObjectId?: string;
}

/**
 * Request for reconciling Arc Settings.
 */
model ReconcileArcSettingsRequest {
  /**
   * List of Arc Nodes in the cluster
   */
  properties?: ReconcileArcSettingsRequestProperties;
}

/**
 * List of Arc Nodes in the cluster
 */
model ReconcileArcSettingsRequestProperties {
  /**
   * List of cluster node names to reconcile Arc settings for.
   */
  clusterNodes?: string[];
}

/**
 * Connectivity related configuration required by arc server.
 */
model ArcConnectivityProperties {
  /**
   * True indicates ARC connectivity is enabled
   */
  enabled?: boolean;

  /**
   * Service configurations associated with the connectivity resource. They are only processed by the server if 'enabled' property is set to 'true'.
   */
  @identifiers(#["serviceName"])
  serviceConfigurations?: ServiceConfiguration[];
}

/**
 * Service configuration details
 */
model ServiceConfiguration {
  /**
   * Name of the service.
   */
  serviceName: ServiceName;

  /**
   * The port on which service is enabled.
   */
  port: int64;
}
