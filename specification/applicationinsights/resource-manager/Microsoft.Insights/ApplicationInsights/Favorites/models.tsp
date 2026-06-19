import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Favorites;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union FavoriteSourceType {
  string,

  /**
   * retention
   */
  retention: "retention",

  /**
   * notebook
   */
  notebook: "notebook",

  /**
   * sessions
   */
  sessions: "sessions",

  /**
   * events
   */
  events: "events",

  /**
   * userflows
   */
  userflows: "userflows",

  /**
   * funnel
   */
  funnel: "funnel",

  /**
   * impact
   */
  impact: "impact",

  /**
   * segmentation
   */
  segmentation: "segmentation",
}

/**
 * Enum indicating if this favorite definition is owned by a specific user or is shared between all users with access to the Application Insights component.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum FavoriteType {
  /**
   * shared
   */
  shared,

  /**
   * user
   */
  user,
}

/**
 * Properties that define a favorite that is associated to an Application Insights component.
 */
model ApplicationInsightsComponentFavorite {
  /**
   * The user-defined name of the favorite.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Name?: string;

  /**
   * Configuration of this particular favorite, which are driven by the Azure portal UX. Configuration data is a string containing valid JSON
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Config?: string;

  /**
   * This instance's version of the data model. This can change as new features are added that can be marked favorite. Current examples include MetricsExplorer (ME) and Search.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Version?: string;

  /**
   * Internally assigned unique id of the favorite definition.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  FavoriteId?: string;

  /**
   * Enum indicating if this favorite definition is owned by a specific user or is shared between all users with access to the Application Insights component.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FavoriteType?: FavoriteType;

  /**
   * The source of the favorite definition.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SourceType?: string;

  /**
   * Date and time in UTC of the last modification that was made to this favorite definition.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  TimeModified?: string;

  /**
   * A list of 0 or more tags that are associated with this favorite definition
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Tags?: string[];

  /**
   * Favorite category, as defined by the user at creation time.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Category?: string;

  /**
   * Flag denoting wether or not this favorite was generated from a template.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IsGeneratedFromTemplate?: boolean;

  /**
   * Unique user id of the specific user that owns this favorite.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  UserId?: string;
}
