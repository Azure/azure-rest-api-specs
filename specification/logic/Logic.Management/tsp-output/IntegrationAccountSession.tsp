import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
@doc("The integration account session.")
@parentResource(IntegrationAccount)
model IntegrationAccountSession
  is TrackedResource<IntegrationAccountSessionProperties> {
  @doc("The integration account session name.")
  @path
  @key("sessionName")
  @segment("sessions")
  name: string;
}

@armResourceOperations
interface IntegrationAccountSessions {
  @doc("Gets an integration account session.")
  get is ArmResourceRead<IntegrationAccountSession>;

  @doc("Creates or updates an integration account session.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IntegrationAccountSession>;

  @doc("Deletes an integration account session.")
  delete is ArmResourceDeleteSync<IntegrationAccountSession>;

  @doc("Gets a list of integration account sessions.")
  list is ArmResourceListByParent<
    IntegrationAccountSession,
    {
      ...BaseParameters<IntegrationAccountSession>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. Options for filters include: ChangedTime.")
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(IntegrationAccountSessions.createOrUpdate::parameters.resource,
  "json",
  "session"
);
@@extension(IntegrationAccountSessions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "session"
);
@@doc(IntegrationAccountSessions.createOrUpdate::parameters.resource,
  "The integration account session."
);
