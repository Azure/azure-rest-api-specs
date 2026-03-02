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
 * An NS group resource (NSX security group).
 */
@parentResource(NetworkSite)
model NsxNsGroup
  is Azure.ResourceManager.ProxyResource<NsxNsGroupProperties, false> {
  ...ResourceNameParameter<
    Resource = NsxNsGroup,
    KeyName = "groupName",
    SegmentName = "nsxNsGroups",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of an NS group.
 */
model NsxNsGroupProperties is AzureResourceProperties {
  /** ARM resource ID of the associated NSX Manager. */
  nsxManagerRef?: Azure.Core.armResourceIdentifier;

  /** The group membership expressions. */
  @identifiers(#[])
  expressions?: GroupExpression[];

  /** Effective virtual machine references resolved by the group. */
  @identifiers(#[])
  effectiveVirtualMachineRefs?: EffectiveVmRef[];

  /** Effective IP address members resolved by the group. */
  effectiveIpMembers?: string[];
}

@armResourceOperations
interface NsxNsGroups {
  /**
   * Gets the NsxNsGroup resource.
   */
  get is ArmResourceRead<NsxNsGroup>;

  /**
   * Creates or updates the NsxNsGroup resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NsxNsGroup>;

  /**
   * Patches the NsxNsGroup resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<NsxNsGroup, NsxNsGroupPatchProperties>;

  /**
   * Deletes the NsxNsGroup resource.
   */
  delete is ArmResourceDeleteSync<NsxNsGroup>;

  /**
   * Lists NsxNsGroup resources within a network site.
   */
  listByNetworkSite is ArmResourceListByParent<
    NsxNsGroup,
    Response = ArmResponse<NsxNsGroupList>
  >;
}

model NsxNsGroupList is Azure.Core.Page<NsxNsGroup>;

@@maxLength(NsxNsGroup.name, 63);
@@minLength(NsxNsGroup.name, 3);
@@doc(NsxNsGroup.name, "The name of the NS group.");
