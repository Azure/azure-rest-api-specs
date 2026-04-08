import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./action.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@removed(Microsoft.Chaos.Versions.v2025_01_01)
@armResourceOperations
interface Actions {
  /**
   * Get an Action resource for a given location.
   */
  get is ArmResourceRead<
    Action,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get a list of Action resources for a given location.
   */
  list is ArmResourceListByParent<
    Action,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    },
    Response = ActionListResult
  >;
}

@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@removed(Microsoft.Chaos.Versions.v2025_01_01)
@armResourceOperations
interface ActionVersions {
  /**
   * Get an Action Version resource for a given location and action.
   */
  get is ArmResourceRead<
    ActionVersion,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get a list of Action Version resources for a given location and action.
   */
  list is ArmResourceListByParent<
    ActionVersion,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    },
    Response = ActionVersionListResult
  >;
}

@@doc(Action.name, "String that represents an Action resource name.");
@@doc(Action.properties, "The properties of the action resource.");
@@doc(ActionVersion.name, "String that represents an Action Version resource name.");
@@doc(
  ActionVersion.properties,
  "The properties of the action version resource."
);
