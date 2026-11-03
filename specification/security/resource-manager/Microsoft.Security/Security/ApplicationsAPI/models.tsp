import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Common;

namespace ApplicationsAPI;

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
  conditionSets: unknown[];
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
