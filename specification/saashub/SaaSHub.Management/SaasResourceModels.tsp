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
using Azure.Core;
using Azure.ResourceManager.Foundations;
using Microsoft.SaaSHub;

#suppress "@azure-tools/typespec-azure-core/casing-style" "SaaSHub is an existing onboarded RP"
@versioned(SaaSHubVersions)
namespace Microsoft.SaaSHub;

/**
 * The properties of a SaaSHub saas resource.
 */
model SaasResourceProperties {
  // Include all the base properties from SeatBasedResourceProperties
  ...SeatBasedResourceProperties;

  /**
   * The billing scope to use for purchasing the resource. Needs full billing scope to invoice section level like: providers/Microsoft.Billing/billingAccounts/{baId}/billingProfiles/{bfId}/invoiceSections/{isId}
   */
  billingScope?: string;

  /**
   * The billing subscription id linked to this resource, with full format like /providers/Microsoft.Billing/billingAccounts/1111:2222/billingSubscriptions/Id
   */
  @visibility(Lifecycle.Read)
  billingSubscriptionId?: string;

  /**
   * The original resource uri, if the new resource will be created by splitting part of the licenses from an existing resource
   */
  originalResourceUri?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SaaSHub/saasResources";
    }
  ]>;
}

/**
 * Request to check if the saas resource can be created
 */
model CanCreateSaasResourceRequest {
  /**
   * Resource name of the saas hub resource to be created.
   */
  name: string;

  /**
   * Resource type to be created, currently only supports SaaS resource type.
   */
  type: string;

  /**
   * The properties of the saas hub resource to be created.
   */
  properties: SaasResourceProperties;
}

/**
 * Request to merge multiple saas resource resources into one target saas resource resource
 */
model MergeSaasResourcesRequest {
  /**
   * List of source resources to be merged into target resource.
   */
  sourceResources?: MergeSourceSaasResource[];

  /**
   * Resource tokens for various authorization and context purposes (for merge target).
   */
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  resourceTokens?: ResourceToken[];
}

/**
 * Saas resource to be used in merge operation as source.
 */
model MergeSourceSaasResource {
  // Include all the base properties from MergeSourceSeatBasedResource
  ...MergeSourceSeatBasedResource;

  /**
   * Id of the saas resource
   */
  id?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SaaSHub/saasResources";
    }
  ]>;
}

/**
 * Validation result for canMerge operation.
 */
model CanMergeResult {
  /**
   * Whether the validation passed/failed.
   */
  @visibility(Lifecycle.Read)
  evaluateResult?: EvaluateResult;

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
  additionalInfo?: MergeSourceSaasResource[];
}
