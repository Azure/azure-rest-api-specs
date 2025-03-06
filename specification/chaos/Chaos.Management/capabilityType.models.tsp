import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/**
 * Model that represents a Capability Type resource.
 */
@parentResource(TargetType)
model CapabilityType
  is Azure.ResourceManager.ProxyResource<CapabilityTypeProperties> {
  ...ResourceNameParameter<
    Resource = CapabilityType,
    KeyName = "capabilityTypeName",
    SegmentName = "capabilityTypes",
    NamePattern = "^[a-zA-Z0-9\\-\\.]+-\\d\\.\\d$"
  >;
}

/**
 * Model that represents the Capability Type properties model.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only metadata resource."
model CapabilityTypeProperties {
  /**
   * String of the Publisher that this Capability Type extends.
   */
  @visibility(Lifecycle.Read)
  publisher?: string;

  /**
   * String of the Target Type that this Capability Type extends.
   */
  @visibility(Lifecycle.Read)
  targetType?: string;

  /**
   * Localized string of the display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Localized string of the description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * URL to retrieve JSON schema of the Capability Type parameters.
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
   * String of the kind of this Capability Type.
   */
  @visibility(Lifecycle.Read)
  kind?: string;

  /**
   * Control plane actions necessary to execute capability type.
   */
  @visibility(Lifecycle.Read)
  azureRbacActions?: string[];

  /**
   * Data plane actions necessary to execute capability type.
   */
  @visibility(Lifecycle.Read)
  azureRbacDataActions?: string[];

  /**
   * Required Azure Role Definition Ids to execute capability type.
   */
  @visibility(Lifecycle.Read)
  @added(Microsoft.Chaos.Versions.v2025_01_01)
  requiredAzureRoleDefinitionIds?: string[];

  /**
   * Runtime properties of this Capability Type.
   */
  @visibility(Lifecycle.Read)
  runtimeProperties?: CapabilityTypePropertiesRuntimeProperties;
}

/**
 * Runtime properties of this Capability Type.
 */
model CapabilityTypePropertiesRuntimeProperties {
  /**
   * String of the kind of the resource's action type (continuous or discrete).
   */
  @visibility(Lifecycle.Read)
  kind?: string;
}

/**
 * Model that represents a list of Capability Type resources and a link for pagination.
 */
model CapabilityTypeListResult is Azure.Core.Page<CapabilityType>;
