import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/**
 * Model that represents a Capability resource.
 */
@parentResource(Target)
model Capability is Azure.ResourceManager.ProxyResource<CapabilityProperties> {
  ...ResourceNameParameter<
    Resource = Capability,
    KeyName = "capabilityName",
    SegmentName = "capabilities",
    NamePattern = "^[a-zA-Z0-9\\-\\.]+-\\d\\.\\d$"
  >;
}

alias CapabilityParentResourceParameters = BaseParameters<Capability> &
  ParentResourceParameters;

/**
 * Model that represents the Capability properties model.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Unused property, avoids breaking changes in SDK."
model CapabilityProperties {
  /**
   * String of the Publisher that this Capability extends.
   */
  @visibility(Lifecycle.Read)
  publisher?: string;

  /**
   * String of the Target Type that this Capability extends.
   */
  @visibility(Lifecycle.Read)
  targetType?: string;

  /**
   * Localized string of the description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * URL to retrieve JSON schema of the Capability parameters.
   */
  @visibility(Lifecycle.Read)
  @maxLength(2048)
  parametersSchema?: string;

  /**
   * String of the URN for this Capability Type.
   */
  @visibility(Lifecycle.Read)
  @maxLength(2048)
  urn?: string;

  /**
   * Resource provisioning state. Not currently in use because resource is created synchronously.
   */
  @removed(Microsoft.Chaos.Versions.v2025_01_01)
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Model that represents a list of Capability resources and a link for pagination.
 */
model CapabilityListResult is Azure.Core.Page<Capability>;
