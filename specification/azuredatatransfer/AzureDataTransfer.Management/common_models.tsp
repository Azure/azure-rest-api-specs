import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.AzureDataTransfer;

/**
 * Flow type for the specified resource
 */
union FlowType {
  string,

  /**
   * This type of flow is not set.
   */
  Unknown: "Unknown",

  /**
   * This flow sends complex documents, such as Microsoft Office documents of Portable document format files.
   */
  Complex: "Complex",

  /**
   * This flow sends source code files and artifacts.
   */
  DevSecOps: "DevSecOps",

  /**
   * This flow over the Azure Data Transfer low latency messaging subsystem.
   */
  Messaging: "Messaging",

  /**
   * This flow sends data that will not be processed by any security system.
   */
  Mission: "Mission",

  /**
   * This flow is assigned to internal Microsoft use cases.
   */
  MicrosoftInternal: "MicrosoftInternal",

  /**
   * This flow sends blobs that can be used for multiple use cases.
   */
  BasicFiles: "BasicFiles",

  /**
   * This flow sends blobs that can be used for multiple use cases.
   */
  Data: "Data",

  /**
   * This flow sends blobs that can be used for multiple use cases.
   */
  Standard: "Standard",

  /**
   * This flow sends video streams.
   */
  StreamingVideo: "StreamingVideo",

  /**
   * This flow sends blobs that will not be processed by any security system.
   */
  Opaque: "Opaque",

  /**
   * This flow sends Extensible Markup Language that will not be processed by any security system.
   */
  MissionOpaqueXML: "MissionOpaqueXML",

  /**
   * This flow sends blobs that can be used for Virtual Machines.
   */
  DiskImages: "DiskImages",

  /**
   * This flow sends data via an Application Programmer Interface.
   */
  API: "API",
}

/**
 * Provisioning state of the pipeline, connection, flow.
 */
union ProvisioningState {
  ResourceProvisioningState,

  /**
   * Resource has been accepted for creation.
   */
  Accepted: "Accepted",
}

/**
 * Link status of the current pipeline, connection, flow.
 */
union LinkStatus {
  string,

  /**
   * The pipeline, connection, or flow is currently linked with another corresponding pipeline,
   * connection, or flow, and can be used.
   */
  Linked: "Linked",

  /**
   * The pipeline, connection, or flow is not linked with another corresponding pipeline,
   * connection, or flow, and cannot be used.
   */
  Unlinked: "Unlinked",
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

  /**
   * The direction is on the sending side of a pipeline, connection, or flow.
   */
  Send: "Send",

  /**
   * The direction is on the receiving side side of a pipeline, connection, or flow.
   */
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
