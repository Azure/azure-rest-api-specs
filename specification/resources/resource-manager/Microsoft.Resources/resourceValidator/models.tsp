import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace ResourceValidationClient;

/** Request to validate resources */
model ResourceValidationRequest {
  /** The resource provider namespace of the resources being validated */
  provider: string;

  /** The type of the resources being validated */
  type: string;

  /** The optional location for the resources being validated */
  location?: string;

  /** The scope of the resources being validated */
  scope: string;

  // TODO: I can use name as the identifier, but then I will have to declare it.
  /** The list of resources to validate. Each resource in the list must have the same namespace, type, and location.
   * The namespace and type on each resource must match the corresponding values in the top-level request.
   * The location on each resource must match the top-level location in the request if specified.
   */
  @identifiers(#[])
  resources: ResourceValidationRequestResource[];

  /** The type of resource validation to perform */
  validationType?: ResourceValidationType;

  /** If true, the validation will be performed without checking RBAC write permissions. */
  performPreflightWithoutRbacWriteCheck?: boolean;
}

/** The type of resource validation */
union ResourceValidationType {
  string,

  /** Perform all available validation checks on the resources. */
  ArmFull: "ArmFull",

  /** Validate properties of the resource without verifying Azure Policy, RBAC, or involving the resource providers. */
  ArmPartial: "ArmPartial",
}

/** The body of the resource to validate. In most cases, this should be the exact same resource body as on an ARM resource PUT request plus the apiVersion property. */
model ResourceValidationRequestResource {
  /** The API version to use with this resource. */
  apiVersion: string;

  /** Set this to true if this resource is meant to be provisioned only if it does not exist. */
  onlyIfNotExists?: boolean;

  ...Record<unknown>;
}

/** Details about the results of the validation */
model ResourceValidationResponseProperties {
  /** List of ARM resource IDs corresponding to the resources that were successfully validated */
  validatedResources: string[];
}

/** Resource validator successful response */
model ResourceValidationResponse {
  /** Details about the results of the validation */
  properties: ResourceValidationResponseProperties;
}
