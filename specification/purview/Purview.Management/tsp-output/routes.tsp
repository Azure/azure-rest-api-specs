import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.Purview;

interface DefaultAccountsOperations {
  @summary("Gets the default account information set for the scope.")
  @doc("Get the default account for the scope.")
  @route("/providers/Microsoft.Purview/getDefaultAccount")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The tenant ID.")
      @query("scopeTenantId")
      scopeTenantId: string;

      @doc("The scope for the default account.")
      @query("scopeType")
      scopeType: ScopeType;

      @doc("The Id of the scope object, for example if the scope is \"Subscription\" then it is the ID of that subscription.")
      @query("scope")
      scope?: string;
    },
    DefaultAccountPayload
  >;

  @summary("Sets the default account for the scope.")
  @doc("Sets the default account for the scope.")
  @route("/providers/Microsoft.Purview/setDefaultAccount")
  @post
  Set is Azure.Core.Foundations.Operation<
    DefaultAccountPayload,
    DefaultAccountPayload
  >;

  @summary("Removes the default account from the scope.")
  @doc("Removes the default account from the scope.")
  @route("/providers/Microsoft.Purview/removeDefaultAccount")
  @post
  Remove is Azure.Core.Foundations.Operation<
    {
      @doc("The tenant ID.")
      @query("scopeTenantId")
      scopeTenantId: string;

      @doc("The scope for the default account.")
      @query("scopeType")
      scopeType: ScopeType;

      @doc("The Id of the scope object, for example if the scope is \"Subscription\" then it is the ID of that subscription.")
      @query("scope")
      scope?: string;
    },
    void
  >;
}
