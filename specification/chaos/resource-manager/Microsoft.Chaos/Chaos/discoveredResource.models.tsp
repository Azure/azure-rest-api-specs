import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./workspace.models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/**
 * Model that represents a discovered resource.
 */
@parentResource(Workspace)
model DiscoveredResource
  is Azure.ResourceManager.ProxyResource<DiscoveredResourceProperties> {
  ...ResourceNameParameter<
    Resource = DiscoveredResource,
    KeyName = "discoveredResourceName",
    SegmentName = "discoveredResources",
    NamePattern = "^[a-zA-Z0-9-]+$"
  >;
}

/**
 * Model that represents the properties of a discovered resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a read-only resource"
model DiscoveredResourceProperties {
  /**
   * The namespace of the discovered resource.
   */
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "namespace")
  resourceNamespace: string;

  /**
   * The name of the discovered resource.
   */
  @visibility(Lifecycle.Read)
  resourceName: string;

  /**
   * The resource type of the discovered resource.
   */
  @visibility(Lifecycle.Read)
  resourceType: string;

  /**
   * The fully qualified identifier of the discovered resource.
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedIdentifier: string;

  /**
   * The date and time when the resource was discovered.
   */
  @visibility(Lifecycle.Read)
  discoveredAt: utcDateTime;

  /**
   * The scope of the discovered resource.
   */
  @visibility(Lifecycle.Read)
  scope: string;

  /**
   * The Azure region the discovered resource is deployed to, in lowercase with no spaces. Absent when no single deployment region was captured, including global and multi-region resources.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  @visibility(Lifecycle.Read)
  location?: azureLocation;

  /**
   * The availability zones the discovered resource occupies. Values are logical zone identifiers, such as `["1", "2"]` for a zone-pinned resource, or the single value `zone-redundant` when redundancy is expressed as a flag or SKU rather than a zone list. Absent, and never empty, when no zone information was captured; a non-zone-aware resource and a zone-aware resource without an assigned zone are not distinguished.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  @visibility(Lifecycle.Read)
  zones?: string[];
}

/**
 * Model that represents a list of discovered resources and a link for pagination.
 */
model DiscoveredResourceListResult is Azure.Core.Page<DiscoveredResource>;
