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
 * capability family; every kind shares the same `properties` schema (see
 * VirtualNetworkApplianceCapabilityProperties). One capability of a given kind may exist per appliance.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This resource must nest under VirtualNetworkAppliance via @parentResource; VirtualNetworkAppliance extends Common.Resource, which is declared with Azure.ResourceManager.Legacy.customAzureResource (see Common/main.tsp), so this resource must carry the same Legacy resource-manager feature tag as its parent for @parentResource to resolve correctly."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "The 3 capability kinds share a fixed envelope (id, name, type, kind) and differ only in the kind literal value; TypeSpec's @discriminator polymorphism for OpenAPI 2.0 allOf/discriminator generation requires the kind subtypes to extend the discriminated base type. Composition with spread (`...`) cannot produce the allOf-based discriminated schema this wire format requires."
@added(Versions.v2026_03_01)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetworkAppliance)
@parentResource(VirtualNetworkAppliance)
@discriminator("kind")
model VirtualNetworkApplianceCapability extends Azure.ResourceManager.ProxyResource<VirtualNetworkApplianceCapabilityProperties> {
  @visibility(Lifecycle.Read)
  @path
  @key("capabilityName")
  @segment("capabilities")
  @pattern("^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$")
  name: string;

  /**
   * The kind of capability. This top-level discriminator selects the capability family.
   */
  kind: VirtualNetworkApplianceCapabilityKind;
}

/**
 * The Private Link Gateway FastPath capability. Private Link fast-path programming on the appliance's gateway;
 * supported on a dual-stack appliance.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This repo's tspconfig.yaml routes emitted schemas to per-feature output files (output-splitting: legacy-feature-files) keyed on Azure.ResourceManager.Legacy.feature; without this decorator on the subtype itself, its schema is emitted into the shared common.json file instead of virtualNetworkAppliance.json, which was verified empirically by removing the decorator and recompiling."
#suppress "@azure-tools/typespec-azure-core/casing-style" "The model name intentionally mirrors the wire-level x-ms-discriminator-value 'PLGatewayFastpath', which is the deployed Network Resource Provider's `kind` string; renaming the TypeSpec model to a differently-cased name would desynchronize the model name from the discriminator value it represents and confuse code generation for consumers that map model name to kind."
@added(Versions.v2026_03_01)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetworkAppliance)
model PLGatewayFastpathCapability extends VirtualNetworkApplianceCapability {
  /**
   * The Private Link Gateway FastPath capability kind.
   */
  kind: "PLGatewayFastpath";
}

/**
 * The Private Link Gateway (slow-path) capability. Private Link programming offloaded to the appliance's gateway;
 * IPv6 on a dual-stack appliance.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This repo's tspconfig.yaml routes emitted schemas to per-feature output files (output-splitting: legacy-feature-files) keyed on Azure.ResourceManager.Legacy.feature; without this decorator on the subtype itself, its schema would be emitted into the shared common.json file instead of virtualNetworkAppliance.json."
#suppress "@azure-tools/typespec-azure-core/casing-style" "The model name intentionally mirrors the wire-level x-ms-discriminator-value 'PLGateway', which is the deployed Network Resource Provider's `kind` string; renaming the TypeSpec model to a differently-cased name would desynchronize the model name from the discriminator value it represents and confuse code generation for consumers that map model name to kind."
@added(Versions.v2026_03_01)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetworkAppliance)
model PLGatewayCapability extends VirtualNetworkApplianceCapability {
  /**
   * The Private Link Gateway (slow-path) capability kind.
   */
  kind: "PLGateway";
}

/**
 * The Private Link IP-forwarders (NVA) capability. Private Link programming offloaded to the appliance NVA;
 * IPv6 on a dual-stack appliance.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This repo's tspconfig.yaml routes emitted schemas to per-feature output files (output-splitting: legacy-feature-files) keyed on Azure.ResourceManager.Legacy.feature; without this decorator on the subtype itself, its schema would be emitted into the shared common.json file instead of virtualNetworkAppliance.json."
#suppress "@azure-tools/typespec-azure-core/casing-style" "The model name intentionally mirrors the wire-level x-ms-discriminator-value 'PLIPForwarders', which is the deployed Network Resource Provider's `kind` string; renaming the TypeSpec model to a differently-cased name would desynchronize the model name from the discriminator value it represents and confuse code generation for consumers that map model name to kind."
@added(Versions.v2026_03_01)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetworkAppliance)
model PLIPForwardersCapability extends VirtualNetworkApplianceCapability {
  /**
   * The Private Link IP-forwarders (NVA) capability kind.
   */
  kind: "PLIPForwarders";
}

/**
 * The kinds of virtual network appliance capability. The value is the top-level `kind` discriminator.
 */
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
 * Properties common to every virtual network appliance capability, independent of kind.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Must carry the same Legacy resource-manager feature tag as VirtualNetworkApplianceCapability, the resource this model is the properties bag for, so both emit into the same feature-scoped output file."
@added(Versions.v2026_03_01)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetworkAppliance)
model VirtualNetworkApplianceCapabilityProperties {
  /**
   * The Azure resource ID of the owning virtual network. System-derived and read-only.
   */
  @visibility(Lifecycle.Read)
  linkedResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks";
    }
  ]>;

  /**
   * The provisioning state of the capability resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The IP version the capability applies to. Private Link Gateway FastPath (`PLGatewayFastpath`)
   * only accepts `DualStack`; Private Link Gateway (`PLGateway`) and Private Link IP-forwarders
   * (`PLIPForwarders`) only accept `IPv6`. The service validates the value against the resource's
   * `kind` when the capability is created or updated.
   */
  // Not modeled as separate per-kind properties schemas: OpenAPI 2.0 (no oneOf) cannot express a
  // narrowed properties type per discriminated subtype without overriding the inherited model-valued
  // `properties` field.
  ipVersion?: VirtualNetworkApplianceCapabilityIpVersion;
}

/**
 * The IP versions a virtual network appliance capability can apply to. See `ipVersion` on
 * VirtualNetworkApplianceCapabilityProperties for the per-`kind` constraint.
 */
@added(Versions.v2026_03_01)
union VirtualNetworkApplianceCapabilityIpVersion {
  string,

  /**
   * IPv6.
   */
  IPv6: "IPv6",

  /**
   * Dual stack (both IPv4 and IPv6).
   */
  DualStack: "DualStack",
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "These operations target VirtualNetworkApplianceCapability, a Legacy custom resource (required because its parent VirtualNetworkAppliance is a Legacy custom Azure resource); Azure.ResourceManager.Legacy.feature is the mechanism this repo's shared library provides for adding armResourceOperations against Legacy custom resources, and is required here for the operations to compile against the legacy parent/child resource tree."
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
