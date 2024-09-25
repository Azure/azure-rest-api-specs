import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Portal;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Supported operations of this resource provider.
 */
model ResourceProviderOperation {
  /**
   * Operation name, in format of {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * Indicates whether the operation applies to data-plane.
   */
  isDataAction?: string;

  /**
   * Display metadata associated with the operation.
   */
  display?: ResourceProviderOperationDisplay;
}

/**
 * Display metadata associated with the operation.
 */
model ResourceProviderOperationDisplay {
  /**
   * Resource provider: Microsoft Custom Providers.
   */
  provider?: string;

  /**
   * Resource on which the operation is performed.
   */
  resource?: string;

  /**
   * Type of operation: get, read, delete, etc.
   */
  operation?: string;

  /**
   * Description of this operation.
   */
  description?: string;
}

/**
 * Error definition.
 */
model ErrorDefinition {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility("read")
  code?: int32;

  /**
   * Description of the error.
   */
  @visibility("read")
  message?: string;

  /**
   * Internal error details.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["code"])
  details?: ErrorDefinition[];
}

@doc("Dashboard Properties with Provisioning state")
model DashboardPropertiesWithProvisioningState {
  ...DashboardProperties;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

/**
 * The shared dashboard properties.
 */
model DashboardProperties {
  /**
   * The dashboard lenses.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  lenses?: DashboardLens[];

  /**
   * The dashboard metadata.
   */
  metadata?: {};
}

/**
 * A dashboard lens.
 */
model DashboardLens {
  /**
   * The lens order.
   */
  order: int32;

  /**
   * The dashboard parts.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  parts: DashboardParts[];

  /**
   * The dashboard len's metadata.
   */
  metadata?: {};
}

/**
 * A dashboard part.
 */
model DashboardParts {
  /**
   * The dashboard's part position.
   */
  position: DashboardPartsPosition;

  /**
   * The dashboard part's metadata.
   */
  metadata?: DashboardPartMetadata;
}

/**
 * The dashboard's part position.
 */
model DashboardPartsPosition {
  /**
   * The dashboard's part x coordinate.
   */
  x: int32;

  /**
   * The dashboard's part y coordinate.
   */
  y: int32;

  /**
   * The dashboard's part row span.
   */
  rowSpan: int32;

  /**
   * The dashboard's part column span.
   */
  colSpan: int32;

  /**
   * The dashboard part's metadata.
   */
  metadata?: {};
}

/**
 * A dashboard part metadata.
 */
@discriminator("type")
model DashboardPartMetadata {
  type: DashboardPartMetadataType;
}

@doc("The dashboard part metadata type.")
union DashboardPartMetadataType {
  @doc("The markdown part type.")
  markdown: "Extension/HubsExtension/PartType/MarkdownPart",

  string,
}
/**
 * The shared dashboard resource definition.
 */
model PatchableDashboard {
  /**
   * The shared dashboard properties.
   */
  properties?: DashboardProperties;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  tags?: Record<string>;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
 * Markdown part metadata.
 */
model MarkdownPartMetadata extends DashboardPartMetadata {
  /**
   * Input to dashboard part.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  inputs?: {}[];

  /**
   * Markdown part settings.
   */
  settings?: MarkdownPartMetadataSettings;

  /**
   * The type of dashboard part.
   */
  type: DashboardPartMetadataType.markdown;
}

/**
 * Markdown part settings.
 */
model MarkdownPartMetadataSettings {
  /**
   * The content of markdown part.
   */
  content?: MarkdownPartMetadataSettingsContent;
}

/**
 * The content of markdown part.
 */
model MarkdownPartMetadataSettingsContent {
  /**
   * The setting of the content of markdown part.
   */
  settings?: MarkdownPartMetadataSettingsContentSettings;
}

/**
 * The setting of the content of markdown part.
 */
model MarkdownPartMetadataSettingsContentSettings {
  /**
   * The content of the markdown part.
   */
  content?: string;

  /**
   * The title of the markdown part.
   */
  title?: string;

  /**
   * The subtitle of the markdown part.
   */
  subtitle?: string;

  /**
   * The source of the content of the markdown part.
   */
  markdownSource?: int32;

  /**
   * The uri of markdown content.
   */
  markdownUri?: string;
}
