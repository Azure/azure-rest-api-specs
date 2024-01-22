import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.PolicyInsights;
/**
 * An attestation resource.
 */
model Attestation is ExtensionResource<AttestationProperties> {
  /**
   * The name of the attestation.
   */
  @path
  @key("attestationName")
  @segment("attestations")
  name: string;
}

@armResourceOperations
interface Attestations {
  /**
   * Gets an existing attestation at resource scope.
   */
  getAtResource is ArmResourceRead<Attestation>;

  /**
   * Creates or updates an attestation at resource scope.
   */
  createOrUpdateAtResource is ArmResourceCreateOrReplaceAsync<Attestation>;

  /**
   * Deletes an existing attestation at individual resource scope.
   */
  deleteAtResource is ArmResourceDeleteSync<Attestation>;

  /**
   * Gets all attestations for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Attestations_ListForResource")
  listForResource is ArmResourceListByParent<
    Attestation,
    {
      ...BaseParameters<Attestation>;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;
    }
  >;
}

@@projectedName(Attestations.createOrUpdateAtResource::parameters.resource,
  "json",
  "parameters"
);
@@extension(Attestations.createOrUpdateAtResource::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Attestations.createOrUpdateAtResource::parameters.resource,
  "The attestation parameters."
);
