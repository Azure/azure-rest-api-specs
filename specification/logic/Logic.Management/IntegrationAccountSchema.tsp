import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
@doc("The integration account schema.")
@parentResource(IntegrationAccount)
model IntegrationAccountSchema
  is ProxyResource<
    IntegrationAccountSchemaProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = IntegrationAccountSchema,
    KeyName = "schemaName",
    SegmentName = "schemas",
    NamePattern = "[a-zA-Z0-9_.()-]{0,79}$"
  >;
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
    Parameters = {
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
    ArmResponse<WorkflowTriggerCallbackUrl>
  >;
}

@@doc(IntegrationAccountSchema.name, "The integration account schema name.");
@@doc(IntegrationAccountSchema.properties,
  "The integration account schema properties."
);
@@doc(IntegrationAccountSchemas.createOrUpdate::parameters.resource,
  "The integration account schema."
);
@@doc(IntegrationAccountSchemas.listContentCallbackUrl::parameters.body, "");
