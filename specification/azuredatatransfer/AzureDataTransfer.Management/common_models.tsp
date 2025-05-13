import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.AzureDataTransfer;

/**
 * Flow type for the specified resource
 */
union FlowType {
  string,
  Unknown: "Unknown",
  Complex: "Complex",
  DevSecOps: "DevSecOps",
  Messaging: "Messaging",
  Mission: "Mission",
  MicrosoftInternal: "MicrosoftInternal",
  BasicFiles: "BasicFiles",
  Data: "Data",
  Standard: "Standard",
  StreamingVideo: "StreamingVideo",
  Opaque: "Opaque",
  MissionOpaqueXML: "MissionOpaqueXML",
  DiskImages: "DiskImages",
  API: "API",
}

/**
 * Provisioning state of the connection
 */
union ProvisioningState {
  ResourceProvisioningState,
  Accepted: "Accepted",
}

/**
 * Status of the current pipeline
 */
union PipelineStatus {
  string,
  Enabled: "Enabled",
  Disabled: "Disabled",
}

/**
 * Link status of the current flow
 */
union LinkStatus {
  string,
  Linked: "Linked",
  Unlinked: "Unlinked",
}

/**
 * Status of the current flow
 */
union FlowStatus {
  string,
  Enabled: "Enabled",
  Disabled: "Disabled",
}

/**
 * The resource to reference.
 */
model ResourceBody {
  /**
   * ID of the resource.
   */
  id: string;

  /**
   * Reason for resource operation.
   */
  statusReason?: string;
}

/**
 * Direction of data movement
 */
union Direction {
  string,
  Send: "Send",
  Receive: "Receive",
}

/**
 * The schema object.
 */
model Schema {
  /**
   * ID associated with this schema
   */
  id?: string;

  /**
   * Connection ID associated with this schema
   */
  connectionId?: string;

  /**
   * Status of the schema
   */
  status?: SchemaStatus;

  /**
   * Name of the schema
   */
  name?: string;

  /**
   * Content of the schema
   */
  content?: string;

  /**
   * The direction of the schema.
   */
  direction?: SchemaDirection;

  /**
   * Uri containing SAS token for the zipped schema
   */
  schemaUri?: url;

  /**
   * The Schema Type
   */
  schemaType?: SchemaType;
}
