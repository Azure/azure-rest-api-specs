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

/** Properties of an AI Gateway. */
@added(Versions.v2026_09_01_preview)
model AiGatewayProperties {
  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;

  /** Frontend configuration of the AI Gateway. */
  @visibility(Lifecycle.Read)
  frontend?: AiGatewayFrontend;

  /** Backend networking configuration. Can only be set when the AI Gateway is created. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  backend?: AiGatewayBackend;
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

/** Parameters for updating an AI Gateway. */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "The SKU cannot be changed after the AI Gateway is created."
@added(Versions.v2026_09_01_preview)
model AiGatewayUpdateParameters {
  ...Azure.ResourceManager.Foundations.TagsUpdateModel<AiGatewayResource>;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}
