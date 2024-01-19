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
@doc("The integration account schema.")
@parentResource(IntegrationAccount)
model IntegrationAccountSchema
  is TrackedResource<IntegrationAccountSchemaProperties> {
  @doc("The integration account schema name.")
  @path
  @key("schemaName")
  @segment("schemas")
  name: string;
}

@armResourceOperations
interface IntegrationAccountSchemas {
  @doc("Gets an integration account schema.")
  get is ArmResourceRead<IntegrationAccountSchema>;

  @doc("Creates or updates an integration account schema.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IntegrationAccountSchema>;

  @doc("Deletes an integration account schema.")
  delete is ArmResourceDeleteSync<IntegrationAccountSchema>;

  @doc("Gets a list of integration account schemas.")
  list is ArmResourceListByParent<
    IntegrationAccountSchema,
    {
      ...BaseParameters<IntegrationAccountSchema>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. Options for filters include: SchemaType.")
      @query("$filter")
      $filter?: string;
    }
  >;

  @doc("Get the content callback url.")
  listContentCallbackUrl is ArmResourceActionSync<
    IntegrationAccountSchema,
    GetCallbackUrlParameters,
    WorkflowTriggerCallbackUrl
  >;
}

@@projectedName(IntegrationAccountSchemas.createOrUpdate::parameters.resource,
  "json",
  "schema"
);
@@extension(IntegrationAccountSchemas.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "schema"
);
@@doc(IntegrationAccountSchemas.createOrUpdate::parameters.resource,
  "The integration account schema."
);
@@projectedName(IntegrationAccountSchemas.listContentCallbackUrl::parameters.body,
  "json",
  "listContentCallbackUrl"
);
@@extension(IntegrationAccountSchemas.listContentCallbackUrl::parameters.body,
  "x-ms-client-name",
  "listContentCallbackUrl"
);
@@doc(IntegrationAccountSchemas.listContentCallbackUrl::parameters.body, "");
