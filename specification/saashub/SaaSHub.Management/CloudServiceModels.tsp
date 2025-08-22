import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./SharedModels.tsp";
import "./versions.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;

namespace Microsoft.SaaSHub;

/**
 * The properties of a SaaSHub cloud service.
 */
model CloudServiceProperties {
  // Include all the base properties from SeatBasedResourceProperties
  ...SeatBasedResourceProperties;

  /**
   * The original resource uri, if the new resource will be created by splitting part of the licenses from an existing resource
   */
  originalResourceUri?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SaaSHub/cloudServices";
    }
  ]>;
}

/**
 * Template for creating update models for ARM TrackedResource-based resources.
 * This provides a pattern for update operations that excludes required/read-only fields
 * from TrackedResource while including only updateable fields.
 *
 * NOTE: This must be manually kept in sync with Azure.ResourceManager.TrackedResource
 * when new updateable fields are added to TrackedResource (which is rare).
 *
 * TrackedResource contains: id, name, type, location, tags, systemData
 * For updates, only 'tags' is typically updateable (location is set at creation).
 */
model TrackedResourceUpdateFields {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags are conventionally represented as a dictionary"
  tags?: Record<string>;
}

/**
 * A SaaSHub cloud service update model for patch and canUpdate operations.
 *
 * This model uses composition to include:
 * 1. CloudServiceProperties (resource-specific properties)
 * 2. TrackedResourceUpdateFields (updateable fields from TrackedResource)
 *
 * This ensures both PATCH and canUpdate operations use identical request bodies
 * without requiring the 'location' field.
 */
model CloudServiceUpdate {
  /**
   * The properties of a SaaSHub cloud service.
   */
  properties?: CloudServiceProperties;

  /**
   * Updateable fields from TrackedResource.
   * NOTE: This composition pattern is the recommended approach for ARM resources
   * that extend TrackedResource when a custom update model is needed.
   */
  ...TrackedResourceUpdateFields;
}

/**
 * Request to check if the cloud service can be created
 */
model CanCreateCloudServiceRequest {
  /**
   * Resource name of the saas hub resource to be created.
   */
  name: string;

  /**
   * Resource type to be created, currently only supports CloudService resource type.
   */
  type: string;

  /**
   * The properties of the saas hub resource to be created.
   */
  properties: CloudServiceProperties;
}

/**
 * Cloud service to be used in merge operation as source.
 */
model MergeSourceCloudService {
  // Include all the base properties from MergeSourceSeatBasedResource
  ...MergeSourceSeatBasedResource;

  /**
   * Id of the cloud service
   */
  id?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SaaSHub/cloudServices";
    }
  ]>;
}

/**
 * Request to merge multiple cloud service resources into one target cloud service resource
 */
model MergeCloudServiceRequest {
  /**
   * List of source resources to be merged into target resource.
   */
  sourceResources: MergeSourceCloudService[];

  /**
   * Resource tokens for various authorization and context purposes (for merge target).
   */
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  resourceTokens?: ResourceToken[];
}

/**
 * Validation result for canMerge operation on cloud service.
 */
model CloudServiceCanMergeResult {
  /**
   * Whether the validation passed/failed.
   */
  @visibility(Lifecycle.Read)
  evaluateResult: EvaluateResult;

  /**
   * ReasonCode for why the request payload failed validation. Null when validation passed.
   */
  @visibility(Lifecycle.Read)
  reasonCode?: string;

  /**
   * Detailed reason for why the request payload failed validation. Null when validation passed.
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * Additional information for failed validation.
   */
  @visibility(Lifecycle.Read)
  additionalInfo?: MergeSourceCloudService[];
}
