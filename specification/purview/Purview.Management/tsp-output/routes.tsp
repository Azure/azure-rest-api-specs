import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Purview;

interface DefaultAccountsOperations {
  /**
   * Get the default account for the scope.
   */
  @summary("Gets the default account information set for the scope.")
  @route("/providers/Microsoft.Purview/getDefaultAccount")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The tenant ID.
       */
      @query("scopeTenantId")
      scopeTenantId: string;

      /**
       * The scope for the default account.
       */
      @query("scopeType")
      scopeType: ScopeType;

      /**
       * The Id of the scope object, for example if the scope is "Subscription" then it is the ID of that subscription.
       */
      @query("scope")
      scope?: string;
    },
    DefaultAccountPayload
  >;

  /**
   * Sets the default account for the scope.
   */
  @summary("Sets the default account for the scope.")
  @route("/providers/Microsoft.Purview/setDefaultAccount")
  @post
  set is Azure.Core.Foundations.Operation<
    DefaultAccountPayload,
    DefaultAccountPayload
  >;

  /**
   * Removes the default account from the scope.
   */
  @summary("Removes the default account from the scope.")
  @route("/providers/Microsoft.Purview/removeDefaultAccount")
  @post
  remove is Azure.Core.Foundations.Operation<
    {
      /**
       * The tenant ID.
       */
      @query("scopeTenantId")
      scopeTenantId: string;

      /**
       * The scope for the default account.
       */
      @query("scopeType")
      scopeType: ScopeType;

      /**
       * The Id of the scope object, for example if the scope is "Subscription" then it is the ID of that subscription.
       */
      @query("scope")
      scope?: string;
    },
    void
  >;
}
