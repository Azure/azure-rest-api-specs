import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;

/**
 * An NSX segment resource.
 */
@parentResource(NetworkSite)
model NsxSegment
  is Azure.ResourceManager.ProxyResource<NsxSegmentProperties, false> {
  ...ResourceNameParameter<
    Resource = NsxSegment,
    KeyName = "segmentName",
    SegmentName = "nsxSegments",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of an NSX segment.
 */
model NsxSegmentProperties is AzureResourceProperties {
  /** ARM resource ID of the associated NSX Manager. */
  nsxManagerRef?: Azure.Core.armResourceIdentifier;

  /** ARM resource ID of the parent gateway. */
  parentGateway?: Azure.Core.armResourceIdentifier;

  /** The segment type. */
  segmentType?: SegmentType;

  /** VLAN identifiers for this segment. */
  vlanIds?: string[];

  /** The subnet definitions. */
  @identifiers(#[])
  subnets?: Subnet[];

  /** Whether this segment is system-owned. */
  systemOwned?: boolean;

  /** The administrative state of the segment. */
  adminState?: AdminState;

  /** ARM resource IDs of virtual machines connected to this segment. */
  associatedVirtualMachines?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OffAzure/vmwareSites/machines";
    }
  ]>[];
}

@armResourceOperations
interface NsxSegments {
  /**
   * Gets the NsxSegment resource.
   */
  get is ArmResourceRead<NsxSegment>;

  /**
   * Creates or updates the NsxSegment resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NsxSegment>;

  /**
   * Patches the NsxSegment resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<NsxSegment, NsxSegmentPatchProperties>;

  /**
   * Deletes the NsxSegment resource.
   */
  delete is ArmResourceDeleteSync<NsxSegment>;

  /**
   * Lists NsxSegment resources within a network site.
   */
  listByNetworkSite is ArmResourceListByParent<
    NsxSegment,
    Response = ArmResponse<NsxSegmentList>
  >;
}

model NsxSegmentList is Azure.Core.Page<NsxSegment>;

@@maxLength(NsxSegment.name, 63);
@@minLength(NsxSegment.name, 3);
@@doc(NsxSegment.name, "The name of the segment.");
