import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.ApiManagement;

/** Resource identifier of a virtual network subnet. */
@added(Versions.v2026_09_01_preview)
scalar AiGatewaySubnetResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets",
    }
  ]>;

/** Subnet used by an AI Gateway. */
@added(Versions.v2026_09_01_preview)
model AiGatewaySubnet {
  /** Resource identifier of the subnet. The subnet must be delegated to Microsoft.App/environments and be in the same region as the AI Gateway. */
  id: AiGatewaySubnetResourceId;
}

/** Backend networking configuration of an AI Gateway. */
@added(Versions.v2026_09_01_preview)
model AiGatewayBackend {
  /** Subnet through which the AI Gateway reaches backends. */
  subnet?: AiGatewaySubnet;
}

/** Frontend configuration of an AI Gateway. */
@added(Versions.v2026_09_01_preview)
model AiGatewayFrontend {
  /** Default hostname used to invoke the AI Gateway. */
  @visibility(Lifecycle.Read)
  defaultHostname?: string;
}

/** Public network access state for an AI Gateway. */
@added(Versions.v2026_11_01)
union AiGatewayPublicNetworkAccess {
  string,

  /** Public network access is enabled. */
  Enabled: "Enabled",

  /** Public network access is disabled. */
  Disabled: "Disabled",
}

/** Properties of an AI Gateway. */
@added(Versions.v2026_09_01_preview)
model AiGatewayProperties {
  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;

  /** Frontend configuration of the AI Gateway. */
  @visibility(Lifecycle.Read)
  frontend?: AiGatewayFrontend;

  /** Backend networking configuration. */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  backend?: AiGatewayBackend;

  /** Whether public network access is allowed for the AI Gateway. */
  @added(Versions.v2026_11_01)
  publicNetworkAccess?: AiGatewayPublicNetworkAccess;

  /** Private endpoint connections associated with the AI Gateway. */
  @added(Versions.v2026_11_01)
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  privateEndpointConnections?: AiGatewayPrivateEndpointConnection[];
}

/** An AI Gateway resource. */
@added(Versions.v2026_09_01_preview)
model AiGatewayResource is Azure.ResourceManager.TrackedResource<
  AiGatewayProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = AiGatewayResource,
    KeyName = "aiGatewayName",
    SegmentName = "aigateways",
    NamePattern = "^[a-z0-9][a-z0-9-]{1,22}[a-z0-9]$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
  ...Azure.ResourceManager.ResourceSkuProperty;
  ...Azure.ResourceManager.EntityTagProperty;
}

/** A private endpoint connection of an AI Gateway. */
@added(Versions.v2026_11_01)
@parentResource(AiGatewayResource)
model AiGatewayPrivateEndpointConnection
  is Azure.ResourceManager.PrivateEndpointConnectionResource;

/** A private link resource of an AI Gateway. */
@added(Versions.v2026_11_01)
@parentResource(AiGatewayResource)
model AiGatewayPrivateLinkResource is Azure.ResourceManager.PrivateLink;

/** SKU fields to update on an AI Gateway. */
@added(Versions.v2026_09_01_preview)
model AiGatewaySkuUpdate
  is OptionalProperties<Azure.ResourceManager.CommonTypes.Sku>;

/** Properties for updating an AI Gateway. */
@added(Versions.v2026_11_01)
model AiGatewayUpdateProperties {
  /** Whether public network access is allowed for the AI Gateway. */
  publicNetworkAccess?: AiGatewayPublicNetworkAccess;

  /** Backend networking configuration. Omit subnet to keep the current subnet, or set it to null to remove it. */
  backend?: AiGatewayBackend;
}

/** Parameters for updating an AI Gateway. */
@added(Versions.v2026_09_01_preview)
model AiGatewayUpdateParameters {
  ...Azure.ResourceManager.Foundations.TagsUpdateModel<AiGatewayResource>;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /** The SKU (Stock Keeping Unit) assigned to this resource. */
  sku?: AiGatewaySkuUpdate;

  /** AI Gateway properties to update. */
  @added(Versions.v2026_11_01)
  properties?: AiGatewayUpdateProperties;
}
