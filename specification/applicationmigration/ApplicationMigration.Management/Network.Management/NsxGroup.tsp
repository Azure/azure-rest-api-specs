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
model NsxGroup
  is Azure.ResourceManager.ProxyResource<NsxGroupProperties, false> {
  ...ResourceNameParameter<
    Resource = NsxGroup,
    KeyName = "groupName",
    SegmentName = "nsGroups",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of an NS group.
 */
model NsxGroupProperties is AzureResourceProperties {
  /** The group membership expressions. */
  @identifiers(#[])
  expressions?: GroupExpression[];

  /** Effective virtual machine references resolved by the group. */
  @identifiers(#[])
  effectiveVirtualMachineRefs?: EffectiveVmRef[];

  /** Effective IP address members resolved by the group. */
  effectiveIpMembers?: string[];

  /** Original NSX resource metadata. */
  nsxOriginal?: NsxOriginal;
}

@armResourceOperations
interface NsxGroups {
  /**
   * Gets the NsxGroup resource.
   */
  get is ArmResourceRead<NsxGroup>;

  /**
   * Creates or updates the NsxGroup resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NsxGroup>;

  /**
   * Patches the NsxGroup resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<NsxGroup, NsxGroupPatchProperties>;

  /**
   * Deletes the NsxGroup resource.
   */
  delete is ArmResourceDeleteSync<NsxGroup>;

  /**
   * Lists NsxGroup resources within a network site.
   */
  listByNetworkSite is ArmResourceListByParent<
    NsxGroup,
    Response = ArmResponse<NsxGroupList>
  >;
}

model NsxGroupList is Azure.Core.Page<NsxGroup>;

@@maxLength(NsxGroup.name, 63);
@@minLength(NsxGroup.name, 3);
@@doc(NsxGroup.name, "The name of the NS group.");
