import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Eventhub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.EventHub;

/**
 * A Microsoft Fabric shortcut attached to an Event Hub.
 */
@added(Versions.v2026_07_01_preview)
@parentResource(Eventhub)
model FabricShortcut
  is Azure.ResourceManager.ProxyResource<FabricShortcutProperties> {
  ...ResourceNameParameter<
    Resource = FabricShortcut,
    KeyName = "fabricShortcutName",
    SegmentName = "fabricShortcuts",
    NamePattern = "^.+$"
  >;

  /**
   * The geo-location where the resource lives.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The backend resource model returns location as a read-only top-level ARM envelope property, not as a Fabric shortcut property."
  @visibility(Lifecycle.Read)
  location?: string;
}

/**
 * Properties of a Microsoft Fabric shortcut.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "The synchronous backend contract does not define or return provisioningState; shortcut lifecycle is reported through the read-only shortcutStatus property."
@added(Versions.v2026_07_01_preview)
model FabricShortcutProperties {
  /**
   * Microsoft Fabric workspace and artifact configuration.
   */
  configuration: FabricShortcutConfiguration;

  /**
   * The type of the shortcut.
   */
  shortcutType?: FabricShortcutType;

  /**
   * The current shortcut status. Only Pending can be supplied on create or update.
   */
  shortcutStatus?: FabricShortcutStatus;

  /**
   * A description of the current shortcut status.
   */
  @visibility(Lifecycle.Read)
  statusDescription?: string;

  /**
   * The UTC time when the shortcut was created.
   */
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  /**
   * The UTC time when the shortcut was last modified.
   */
  @visibility(Lifecycle.Read)
  modifiedAt?: utcDateTime;
}

/**
 * Microsoft Fabric workspace and artifact configuration.
 */
@added(Versions.v2026_07_01_preview)
model FabricShortcutConfiguration {
  /**
   * The Microsoft Fabric tenant ID.
   */
  tenantId: uuid;

  /**
   * The Microsoft Fabric workspace ID.
   */
  workspaceId: uuid;

  /**
   * The Microsoft Fabric artifact ID.
   */
  artifactId: uuid;

  /**
   * The Microsoft Fabric premium capacity ID.
   */
  premiumCapacityId?: string;

  /**
   * The resource ID of the Log Analytics workspace.
   */
  logAnalyticsResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  /**
   * The Microsoft Fabric workspace name.
   */
  workspaceName?: string;

  /**
   * The Microsoft Fabric artifact name.
   */
  artifactName?: string;
}

/**
 * The type of Microsoft Fabric shortcut.
 */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The service validates the value against this fixed set and rejects unknown values."
@added(Versions.v2026_07_01_preview)
union FabricShortcutType {
  /**
   * An entity shortcut.
   */
  Entity: "Entity",

  /**
   * A network shortcut.
   */
  Network: "Network",
}

/**
 * The status of a Microsoft Fabric shortcut.
 */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The service validates the value against this fixed set and rejects unknown values."
@added(Versions.v2026_07_01_preview)
union FabricShortcutStatus {
  /**
   * The shortcut is awaiting approval.
   */
  Pending: "Pending",

  /**
   * The shortcut is approved.
   */
  Approved: "Approved",

  /**
   * The shortcut is rejected.
   */
  Rejected: "Rejected",
}

@added(Versions.v2026_07_01_preview)
@armResourceOperations
interface FabricShortcuts {
  /**
   * Gets a Microsoft Fabric shortcut.
   */
  get is ArmResourceRead<FabricShortcut, Error = ErrorResponse>;

  /**
   * Creates or updates a Microsoft Fabric shortcut.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The service returns 200 for both create and update."
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    FabricShortcut,
    Response = ArmResourceUpdatedResponse<FabricShortcut>,
    Error = ErrorResponse
  >;

  /**
   * Lists Microsoft Fabric shortcuts for an Event Hub.
   */
  listByEventHub is ArmResourceListByParent<
    FabricShortcut,
    Error = ErrorResponse
  >;

  /**
   * Deletes a Microsoft Fabric shortcut.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "The service returns 200 when the shortcut is deleted."
  delete is ArmResourceDeleteSync<
    FabricShortcut,
    Response = ArmDeletedResponse,
    Error = ErrorResponse
  >;

  /**
   * Approves a Microsoft Fabric shortcut.
   */
  @action("approve")
  approve is ArmResourceActionSync<
    FabricShortcut,
    void,
    ArmResponse<FabricShortcut>,
    Error = ErrorResponse
  >;

  /**
   * Rejects a Microsoft Fabric shortcut.
   */
  @action("reject")
  reject is ArmResourceActionSync<
    FabricShortcut,
    void,
    ArmResponse<FabricShortcut>,
    Error = ErrorResponse
  >;
}

@@doc(FabricShortcut.name, "The Microsoft Fabric shortcut name.");
@@doc(
  FabricShortcut.properties,
  "Properties of the Microsoft Fabric shortcut."
);
@@doc(
  FabricShortcuts.createOrUpdate::parameters.resource,
  "The Microsoft Fabric shortcut."
);
