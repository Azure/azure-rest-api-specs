import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;

/**
 * PrivateAccesses tracked resource.
 */
model PrivateAccess
  is Azure.ResourceManager.TrackedResource<PrivateAccessProperties, false> {
  ...ResourceNameParameter<
    Resource = PrivateAccess,
    KeyName = "privateAccessName",
    SegmentName = "privateAccesses",
    NamePattern = "^[^<>%&:?#/\\\\]+$"
  >;
}

/**
 * Describes a private access update.
 */
model PrivateAccessPatch {
  /**
   * The tags of the private access resource.
   */
  ...Azure.ResourceManager.Foundations.TagsUpdateModel<PrivateAccess>;
}

/**
 * The properties of a private access resource
 */
model PrivateAccessProperties {
  /**
   * Most recent provisioning state for the given privateAccess resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * A readonly collection of private endpoint connection. Currently only one endpoint connection is supported.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Public Network Access Control for PrivateAccess resource.
   */
  publicNetworkAccess?: PublicNetworkAccessOption;
}

/**
 * Public Network Access Control for PrivateAccess resource.
 */
union PublicNetworkAccessOption {
  string,

  /**
   * Enabled access.
   */
  Enabled: "Enabled",

  /**
   * Disabled access.
   */
  Disabled: "Disabled",
}

/**
 * Model that represents a list of private access resources and a link for pagination.
 */
model PrivateAccessListResult is Azure.Core.Page<PrivateAccess>;
