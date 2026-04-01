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
 * The application source, what it affects, e.g. Assessments
 */
union ApplicationSourceResourceType {
  string,

  /**
   * The source of the application is assessments
   */
  Assessments: "Assessments",
}

/**
 * The application Condition's Operator, for example Contains for id or In for list of possible IDs, see examples
 */
union ApplicationConditionOperator {
  string,

  /**
   * Checks that the string value of the data defined in Property contains the given value
   */
  Contains: "Contains",

  /**
   * Checks that the string value of the data defined in Property equals the given value
   */
  Equals: "Equals",

  /**
   * Checks that the string value of the data defined in Property equals any of the given values (exact fit)
   */
  In: "In",
}

/**
 * Page of a security applications list
 */
model ApplicationsList {
  /**
   * Collection of applications in this page
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: Application[];

  /**
   * The URI to fetch the next page
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}

/**
 * Describes properties of an application
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApplicationProperties {
  /**
   * display name of the application
   */
  displayName?: string;

  /**
   * description of the application
   */
  description?: string;

  /**
   * The application source, what it affects, e.g. Assessments
   */
  sourceResourceType: ApplicationSourceResourceType;

  /**
   * The application conditionSets - see examples
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  conditionSets: ApplicationCondition[][];
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
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
@error
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  details?: CloudErrorBody[];

  /**
   * The error additional info.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
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
 * Application's condition
 */
model ApplicationCondition {
  /**
   * The application Condition's Property, e.g. ID, see examples
   */
  property?: string;

  /**
   * The application Condition's Value like IDs that contain some string, see examples
   */
  value?: string;

  /**
   * The application Condition's Operator, for example Contains for id or In for list of possible IDs, see examples
   */
  operator?: ApplicationConditionOperator;
}
