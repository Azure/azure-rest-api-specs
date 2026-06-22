import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace AnalyticsItems;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ItemScopePath {
  string,

  /**
   * analyticsItems
   */
  analyticsItems: "analyticsItems",

  /**
   * myanalyticsItems
   */
  myanalyticsItems: "myanalyticsItems",
}

/**
 * Enum indicating if this item definition is owned by a specific user or is shared between all users with access to the Application Insights component.
 */
union ItemScope {
  string,

  /**
   * shared
   */
  shared: "shared",

  /**
   * user
   */
  user: "user",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ItemTypeParameter {
  string,

  /**
   * none
   */
  none: "none",

  /**
   * query
   */
  query: "query",

  /**
   * function
   */
  function: "function",

  /**
   * folder
   */
  folder: "folder",

  /**
   * recent
   */
  recent: "recent",
}

/**
 * Enum indicating the type of the Analytics item.
 */
union ItemType {
  string,

  /**
   * none
   */
  none: "none",

  /**
   * query
   */
  query: "query",

  /**
   * recent
   */
  recent: "recent",

  /**
   * function
   */
  function: "function",
}

/**
 * Properties that define an Analytics item that is associated to an Application Insights component.
 */
model ApplicationInsightsComponentAnalyticsItem {
  /**
   * Internally assigned unique id of the item definition.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Id?: string;

  /**
   * The user-defined name of the item.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Name?: string;

  /**
   * The content of this item
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Content?: string;

  /**
   * This instance's version of the data model. This can change as new features are added.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  Version?: string;

  /**
   * Enum indicating if this item definition is owned by a specific user or is shared between all users with access to the Application Insights component.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Scope?: ItemScope;

  /**
   * Enum indicating the type of the Analytics item.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Type?: ItemType;

  /**
   * Date and time in UTC when this item was created.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  TimeCreated?: string;

  /**
   * Date and time in UTC of the last modification that was made to this item.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  TimeModified?: string;

  /**
   * A set of properties that can be defined in the context of a specific item type. Each type may have its own properties.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Properties?: ApplicationInsightsComponentAnalyticsItemProperties;
}

/**
 * A set of properties that can be defined in the context of a specific item type. Each type may have its own properties.
 */
model ApplicationInsightsComponentAnalyticsItemProperties {
  /**
   * A function alias, used when the type of the item is Function
   */
  functionAlias?: string;
}
