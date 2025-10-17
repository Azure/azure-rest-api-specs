// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DatabaseAccountsOperationGroup {
  /**
   * Checks that the Azure Cosmos DB account name already exists. A valid account name may contain only lowercase letters, numbers, and the '-' character, and must be between 3 and 50 characters.
   */
  @route("/providers/Microsoft.DocumentDB/databaseAccountNames/{accountName}")
  @head
  checkNameExists(
    ...ApiVersionParameter,

    /**
     * Cosmos DB database account name.
     */
    @maxLength(50)
    @minLength(3)
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    @path
    accountName: string,
  ): OkResponse | NotFoundResponse | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface RestorableDatabaseAccountsOperationGroup {
  /**
   * Lists all the restorable Azure Cosmos DB database accounts available under the subscription. This call requires 'Microsoft.DocumentDB/locations/restorableDatabaseAccounts/read' permission.
   */
  @autoRoute
  @get
  @action("restorableDatabaseAccounts")
  @list
  list is ArmProviderActionSync<
    Response = RestorableDatabaseAccountsListResult,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
}
