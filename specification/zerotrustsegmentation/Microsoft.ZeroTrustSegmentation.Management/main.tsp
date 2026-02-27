import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "ZeroTrustSegmentationClient" })
@versioned(Versions)
@doc("ZeroTrustSegmentation resource provider API.")
namespace Microsoft.ZeroTrustSegmentation;

/** ZeroTrustSegmentation API versions */
enum Versions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_02_01_preview: "2025-02-01-preview",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_07_01_preview: "2025-07-01-preview",
}

@doc("A zero trust segmentation resource. this resource defines the SegmentationManager.")
model SegmentationManager is TrackedResource<SegmentationManagerProperties> {
  @doc("Name of the segmentation manager")
  @key("segmentationManagerName")
  @pattern("^[a-zA-Z0-9-]{3,250}$")
  @path
  @segment("segmentationManagers")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Adding property for versioning"
  @added(Versions.v2025_07_01_preview)
  @doc("The managed service identities assigned to this resource.")
  identity?: SegmentationManagerManagedServiceIdentity;
}

@added(Versions.v2025_07_01_preview)
@doc("Managed service identity for the segmentation manager.")
model SegmentationManagerManagedServiceIdentity {
  @doc("The type of managed service identity.")
  type: SegmentationManagerManagedServiceIdentityType;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Following ARM pattern for user assigned identities"
  @doc("The user assigned identities associated with the resource.")
  userAssignedIdentities?: Record<Azure.ResourceManager.CommonTypes.UserAssignedIdentity | null>;
}

@added(Versions.v2025_07_01_preview)
@doc("The type of managed service identity.")
union SegmentationManagerManagedServiceIdentityType {
  @doc("No managed identity is assigned to this resource.")
  "None",

  @doc("User Assigned Managed Identity")
  "UserAssigned",

  string,
}

@doc("Segmentation manager properties")
model SegmentationManagerProperties {
  @doc("The collection of ARM resource IDs for the monitored logs.")
  logSources: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/networkWatchers/flowLogs";
    }
  ]>[];

  @doc("The analysis run type")
  analysisRunType: AnalysisRunType;

  @doc("The start time of a snapshot run")
  startTime?: utcDateTime;

  @doc("The end time of a snapshot run")
  endTime?: utcDateTime;

  @doc("The mode of segmentation to be applied")
  segmentationMode: SegmentationMode;

  @doc("The description of the segmentation manager")
  description?: string;

  ...DefaultProvisioningStateProperty;
  ...ManagedByProperty;
}

@doc("Specifies the mode of segmentation to be applied.")
union SegmentationMode {
  string,

  @doc("No segmentation applied")
  None: "None",

  @doc("Automatic Mode")
  Automatic: "Automatic",
}

@doc("Analysis run type")
union AnalysisRunType {
  string,

  @doc("Single run")
  OneTime: "OneTime",

  @doc("Continuous run")
  Continuous: "Continuous",
}

@doc("Set label record")
model SetLabelRecord {
  @doc("IP address of the workload")
  ipAddress: string;

  @doc("MAC address of the workload")
  macAddress: string;

  @doc("Labels as key-value pairs")
  @identifiers(#[])
  labels?: LabelPair[];
}

@doc("Represent a label as key-value pair")
model LabelPair {
  @doc("Label key")
  key: string;

  @doc("Label value")
  value: string;
}

@doc("The request model for the SetLabels API")
model SetLabelsRequest {
  @doc("List of labels that need to be updated")
  @identifiers(#[])
  labels: SetLabelRecord[];
}

@doc("The request model for the GetGraph API")
model GetGraphRequest {
  @doc("The start time of the graph")
  startTime: utcDateTime;

  @doc("The end time of the graph")
  endTime: utcDateTime;
}

@doc("The response model for the GetGraph API")
model GetGraphResponse {
  @doc("Graph representation")
  graph: Graph;
}

@doc("Graph representation model")
model Graph {
  @doc("List of vertices in the graph")
  vertices: Vertex[];

  @doc("List of edges connecting the vertices in the graph")
  @identifiers(#[])
  edges: Edge[];

  @doc("Total weights for all edges in the graph")
  totalTrafficWeights: TotalTrafficWeights;
}

@doc("Vertex model representing a node in the network")
model Vertex {
  @doc("Unique identifier for the vertex")
  id: string;

  @doc("IP address of the vertex")
  ipAddress: string;

  @doc("MAC address of the vertex")
  macAddress: string;

  @doc("Geographical location of the vertex")
  location: string;

  @doc("Azure Resource Manager ID of the vertex")
  armId?: string;

  @doc("Name of the vertex")
  name?: string;

  @doc("Labels associated with the vertex as key-value pairs")
  @identifiers(#[])
  labels: LabelPair[];
}

@doc("Edge model representing a connection between two vertices")
model Edge {
  @doc("Source vertex ID")
  source: string;

  @doc("Target vertex ID")
  target: string;

  @doc("Timestamp of the edge in milliseconds since epoch")
  hourT: int64;

  @doc("Traffic weights associated with the edge")
  trafficWeights: TrafficWeights;
}

@doc("Total traffic weights for all edges in the graph")
model TotalTrafficWeights {
  @doc("Total incoming packets")
  totalInPackets: float32;

  @doc("Total incoming bytes")
  totalInBytes: float32;

  @doc("Total incoming connections")
  totalInConnections: float32;

  @doc("Total outgoing packets")
  totalOutPackets: float32;

  @doc("Total outgoing bytes")
  totalOutBytes: float32;

  @doc("Total outgoing connections")
  totalOutConnections: float32;
}

@doc("TrafficWeights model")
model TrafficWeights {
  @doc("Incoming packet weight as a percentage")
  inPacketWeight: float32;

  @doc("Incoming byte weight as a percentage")
  inByteWeight: float32;

  @doc("Incoming connection weight as a percentage")
  inConnectionWeight: float32;

  @doc("Outgoing packet weight as a percentage")
  outPacketWeight: float32;

  @doc("Outgoing byte weight as a percentage")
  outByteWeight: float32;

  @doc("Outgoing connection weight as a percentage")
  outConnectionWeight: float32;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface SegmentationManagers {
  get is ArmResourceRead<SegmentationManager>;
  createOrReplace is ArmResourceCreateOrReplaceSync<SegmentationManager>;
  update is ArmResourcePatchSync<
    SegmentationManager,
    SegmentationManagerProperties
  >;
  delete is ArmResourceDeleteSync<SegmentationManager>;
  @list
  listByResourceGroup is ArmResourceListByParent<SegmentationManager>;
  @list
  listBySubscription is ArmListBySubscription<SegmentationManager>;

  setLabels is ArmResourceActionNoContentSync<
    SegmentationManager,
    SetLabelsRequest
  >;

  getGraph is ArmResourceActionSync<
    SegmentationManager,
    GetGraphRequest,
    GetGraphResponse
  >;
}
