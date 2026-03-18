import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Security;

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * The cloud that the standard is supported on.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum StandardSupportedClouds {
  /**
   * AWS
   */
  AWS,

  /**
   * GCP
   */
  GCP,
}

/**
 * Page of a Standard list
 */
model StandardList {
  /**
   * Collection of standards in this page
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: Standard[];

  /**
   * The URI to fetch the next page
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Describes properties of a standard.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StandardProperties {
  /**
   * display name of the standard, equivalent to the standardId
   */
  displayName?: string;

  /**
   * standard type (Custom or BuiltIn only currently)
   */
  @visibility(Lifecycle.Read)
  standardType?: string;

  /**
   * description of the standard
   */
  description?: string;

  /**
   * category of the standard provided
   */
  category?: string;

  /**
   * List of component objects containing component unique keys (such as assessment keys) to apply to standard scope.  Currently only supports assessment keys.
   */
  @identifiers(#[])
  components?: StandardComponentProperties[];

  /**
   * List of all standard supported clouds.
   */
  supportedClouds?: StandardSupportedClouds[];
}

/**
 * Describes properties of an component as related to the standard
 */
model StandardComponentProperties {
  /**
   * Component Key matching componentMetadata
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  key?: string;
}

/**
 * Describes an Azure tracked resource.
 */
model TrackedResource {
  ...Resource;
  ...AzureTrackedResourceLocation;
  ...Kind;
  ...ETag;
  ...Tags;
}

/**
 * Describes an Azure resource.
 */
model Resource {
  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Describes an Azure resource with location
 */
model AzureTrackedResourceLocation {
  /**
   * Location where the resource is stored
   */
  location?: string;
}

/**
 * Describes an Azure resource with kind
 */
model Kind {
  /**
   * Kind of the resource
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

/**
 * Entity tag is used for comparing two or more entities from the same requested resource.
 */
// #suppress applies to the next declaration
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ETag {
  /**
   * Entity tag is used for comparing two or more entities from the same requested resource.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

/**
 * A list of key value pairs that describe the resource.
 */
model Tags {
  /**
   * A list of key value pairs that describe the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * The error object.
   */
  error?: CloudErrorBody;
}

/**
 * The error detail.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model CloudErrorBody {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The error target.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * The error details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  details?: CloudErrorBody[];

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * The resource management error additional info.
 */
model ErrorAdditionalInfo {
  /**
   * The additional info type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The additional info.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  info?: unknown;
}

/**
 * Page of a standard assignment list
 */
model AssignmentList {
  /**
   * Collection of standardAssignments in this page
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: Assignment[];

  /**
   * The URI to fetch the next page
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Describes the properties of a standardAssignment
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AssignmentProperties {
  /**
   * display name of the standardAssignment
   */
  displayName?: string;

  /**
   * description of the standardAssignment
   */
  description?: string;

  /**
   * Standard item with key as applied to this standard assignment over the given scope
   */
  assignedStandard?: AssignedStandardItem;

  /**
   * Component item with key as applied to this standard assignment over the given scope
   */
  assignedComponent?: AssignedComponentItem;

  /**
   * Scope to which the standardAssignment applies - can be a subscription path or a resource group under that subscription
   */
  scope?: string;

  /**
   * expected effect of this assignment (Disable/Exempt/etc)
   */
  effect?: string;

  /**
   * Expiration date of this assignment as a full ISO date
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiresOn?: utcDateTime;

  /**
   * Additional data about the assignment
   */
  additionalData?: AssignmentPropertiesAdditionalData;

  /**
   * The assignment metadata. Metadata is an open ended object and is typically a collection of key value pairs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metadata?: unknown;
}

/**
 * describe the properties of a of a security standard object reference
 */
model AssignedStandardItem {
  /**
   * full resourceId of the Microsoft.Security/standard object
   */
  id?: string;
}

/**
 * describe the properties of a security assessment object reference (by key)
 */
model AssignedComponentItem {
  /**
   * unique key to a security assessment object
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  key?: string;
}

/**
 * Additional data about the assignment
 */
model AssignmentPropertiesAdditionalData {
  /**
   * Exemption category of this assignment
   */
  exemptionCategory?: string;
}
