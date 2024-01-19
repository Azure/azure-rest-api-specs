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
@doc("An attestation resource.")
model Attestation is ExtensionResource<AttestationProperties> {
  @doc("The name of the attestation.")
  @path
  @key("attestationName")
  @segment("attestations")
  name: string;
}

@armResourceOperations
interface Attestations {
  @doc("Gets an existing attestation at resource scope.")
  getAtResource is ArmResourceRead<Attestation>;

  @doc("Creates or updates an attestation at resource scope.")
  createOrUpdateAtResource is ArmResourceCreateOrUpdateAsync<Attestation>;

  @doc("Deletes an existing attestation at individual resource scope.")
  deleteAtResource is ArmResourceDeleteSync<Attestation>;

  @doc("Gets all attestations for a resource.")
  listForResource is ArmResourceListByParent<
    Attestation,
    {
      ...BaseParameters<Attestation>;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("OData filter expression.")
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
