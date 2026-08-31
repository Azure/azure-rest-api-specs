import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./VirtualNetworkAppliance.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Microsoft.Network;

/**
 * A capability enabled on a virtual network appliance. The top-level `kind` discriminator selects the
 * capability family and its `properties` schema. One capability of a given kind may exist per appliance.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Consistent with the parent VirtualNetworkAppliance resource."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "provisioningState is carried on each kind-specific properties bag, not on the discriminated base."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Discriminated resource: kind-specific subtypes extend the base, mirroring BaseAdminRule."
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Consistent with the parent VirtualNetworkAppliance and BaseAdminRule resources."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Child resource extends the shared ChildResource base, consistent with BaseAdminRule and the other Network child resources."
@added(Versions.v2026_03_01)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetworkAppliance)
@parentResource(VirtualNetworkAppliance)
@discriminator("kind")
@Http.Private.includeInapplicableMetadataInPayload(false)
model VirtualNetworkApplianceCapability extends ChildResource {
  @visibility(Lifecycle.Read)
  @path
  @key("capabilityName")
  @segment("capabilities")
  @pattern("^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$")
  name: string;

  /**
   * The system metadata related to this resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: Azure.ResourceManager.Foundations.SystemData;

  /**
   * The kind of capability. This top-level discriminator selects the capability's `properties` schema.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "kind is the resource-level discriminator, mirroring BaseAdminRule."
  kind: VirtualNetworkApplianceCapabilityKind;
}

/**
 * The Private Link Gateway FastPath capability. Private Link fast-path programming on the appliance's gateway;
 * supported on a dual-stack appliance.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Consistent with the parent VirtualNetworkAppliance resource."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Extends the shared ChildResource base like the other Network child resources."
#suppress "@azure-tools/typespec-azure-core/casing-style" "Model name mirrors the wire-level capability kind value 'PLGatewayFastpath' (the NRP contract discriminator value)."
@added(Versions.v2026_03_01)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetworkAppliance)
model PLGatewayFastpathCapability extends VirtualNetworkApplianceCapability {
  /**
   * The Private Link capability properties.
   */
  properties?: PrivateLinkCapabilityProperties;

  /**
   * The Private Link Gateway FastPath capability kind.
   */
  kind: "PLGatewayFastpath";
}

/**
 * The Private Link Gateway (slow-path) capability. Private Link programming offloaded to the appliance's gateway;
 * IPv6 on a dual-stack appliance.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Consistent with the parent VirtualNetworkAppliance resource."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Extends the shared ChildResource base like the other Network child resources."
#suppress "@azure-tools/typespec-azure-core/casing-style" "Model name mirrors the wire-level capability kind value 'PLGateway' (the NRP contract discriminator value)."
@added(Versions.v2026_03_01)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetworkAppliance)
model PLGatewayCapability extends VirtualNetworkApplianceCapability {
  /**
   * The Private Link capability properties.
   */
  properties?: PrivateLinkCapabilityProperties;

  /**
   * The Private Link Gateway (slow-path) capability kind.
   */
  kind: "PLGateway";
}

/**
 * The Private Link IP-forwarders (NVA) capability. Private Link programming offloaded to the appliance NVA;
 * IPv6 on a dual-stack appliance.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Consistent with the parent VirtualNetworkAppliance resource."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Extends the shared ChildResource base like the other Network child resources."
#suppress "@azure-tools/typespec-azure-core/casing-style" "Model name mirrors the wire-level capability kind value 'PLIPForwarders' (the NRP contract discriminator value)."
@added(Versions.v2026_03_01)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetworkAppliance)
model PLIPForwardersCapability extends VirtualNetworkApplianceCapability {
  /**
   * The Private Link capability properties.
   */
  properties?: PrivateLinkCapabilityProperties;

  /**
   * The Private Link IP-forwarders (NVA) capability kind.
   */
  kind: "PLIPForwarders";
}

/**
 * The kinds of virtual network appliance capability. The value is the top-level `kind` discriminator.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Members are documented individually below."
@added(Versions.v2026_03_01)
union VirtualNetworkApplianceCapabilityKind {
  string,

  /**
   * Private Link Gateway FastPath.
   */
  PLGatewayFastpath: "PLGatewayFastpath",

  /**
   * Private Link Gateway (slow-path).
   */
  PLGateway: "PLGateway",

  /**
   * Private Link IP-forwarders (NVA).
   */
  PLIPForwarders: "PLIPForwarders",
}

/**
 * Properties common to a Private Link virtual network appliance capability.
 */
@added(Versions.v2026_03_01)
model PrivateLinkCapabilityProperties {
  /**
   * The IP version the Private Link capability applies to. FastPath supports DualStack; the gateway
   * (slow-path) and IP-forwarders kinds support IPv6.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Consistent with existing Azure Network naming convention using 'IP' for IP-related properties."
  ipVersion?: VirtualNetworkApplianceCapabilityIpVersion;

  /**
   * The ARM resource id of the owning virtual network. System-derived and read-only.
   */
  @visibility(Lifecycle.Read)
  linkedResourceId?: string;

  /**
   * The provisioning state of the capability resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The IP version a virtual network appliance capability applies to.
 */
@added(Versions.v2026_03_01)
union VirtualNetworkApplianceCapabilityIpVersion {
  string,

  /**
   * IPv4.
   */
  IPv4: "IPv4",

  /**
   * IPv6.
   */
  IPv6: "IPv6",

  /**
   * Dual stack (both IPv4 and IPv6).
   */
  DualStack: "DualStack",
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Consistent with the parent VirtualNetworkAppliance resource."
@added(Versions.v2026_03_01)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetworkAppliance)
@armResourceOperations
interface VirtualNetworkApplianceCapabilities {
  /**
   * Gets the specified capability of a virtual network appliance.
   */
  get is ArmResourceRead<VirtualNetworkApplianceCapability, Error = CloudError>;

  /**
   * Creates or updates a capability on a virtual network appliance.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualNetworkApplianceCapability,
    Error = CloudError
  >;

  /**
   * Deletes the specified capability of a virtual network appliance.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetworkApplianceCapability,
    Error = CloudError
  >;

  /**
   * Gets all capabilities of a virtual network appliance.
   */
  list is ArmResourceListByParent<
    VirtualNetworkApplianceCapability,
    Error = CloudError
  >;
}

@@doc(
  VirtualNetworkApplianceCapability.name,
  "The name of the virtual network appliance capability."
);
@@doc(
  VirtualNetworkApplianceCapability.kind,
  "The kind of capability (the top-level discriminator)."
);
@@doc(
  VirtualNetworkApplianceCapabilities.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update virtual network appliance capability operation."
);
@@clientName(
  VirtualNetworkApplianceCapabilities.createOrUpdate::parameters.resource,
  "parameters"
);
