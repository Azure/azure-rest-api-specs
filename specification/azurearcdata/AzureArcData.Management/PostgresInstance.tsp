import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureArcData;
/**
 * A Postgres Instance.
 */
model PostgresInstance
  is Azure.ResourceManager.TrackedResource<PostgresInstanceProperties, false> {
  ...ResourceNameParameter<
    Resource = PostgresInstance,
    KeyName = "postgresInstanceName",
    SegmentName = "postgresInstances",
    NamePattern = ""
  >;

  /**
   * The extendedLocation of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /**
   * Resource sku.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: PostgresInstanceSku;
}

@armResourceOperations
interface PostgresInstances {
  /**
   * Retrieves a postgres Instance resource
   */
  get is ArmResourceRead<PostgresInstance>;

  /**
   * Creates or replaces a postgres Instance resource
   */
  create is ArmResourceCreateOrReplaceAsync<PostgresInstance>;

  /**
   * Updates a postgres Instance resource
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    PostgresInstance,
    PatchModel = PostgresInstanceUpdate
  >;

  /**
   * Deletes a postgres Instance resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PostgresInstance,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Get a postgres Instances list by Resource group name.
   */
  @summary("List postgres Instance resources in the resource group")
  listByResourceGroup is ArmResourceListByParent<
    PostgresInstance,
    Response = ArmResponse<PostgresInstanceListResult>
  >;

  /**
   * List postgres Instance resources in the subscription
   */
  @summary("List postgres Instance resources in the subscription")
  list is ArmListBySubscription<
    PostgresInstance,
    Response = ArmResponse<PostgresInstanceListResult>
  >;
}

@@doc(PostgresInstance.name, "Name of Postgres Instance");
@@doc(PostgresInstance.properties, "null");
@@doc(PostgresInstances.create::parameters.resource, "The postgres instance");
@@doc(
  PostgresInstances.update::parameters.properties,
  "The Postgres Instance."
);
