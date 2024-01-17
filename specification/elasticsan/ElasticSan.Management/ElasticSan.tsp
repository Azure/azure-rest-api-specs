import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ResourceManager.Private;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ElasticSan;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("Response for ElasticSan request.")
@armResourceInternal(ElasticSanProperties)
@includeInapplicableMetadataInPayload(false)
model ElasticSan extends TrackedResourceBase {
  @doc("The name of the ElasticSan.")
  @maxLength(24)
  @minLength(3)
  @pattern("^[A-Za-z0-9]+((-|_)[a-z0-9A-Z]+)*$")
  @path
  @key("elasticSanName")
  @segment("elasticSans")
  name: string;

  @doc("Properties of ElasticSan.")
  @extension("x-ms-client-flatten", true)
  properties: ElasticSanProperties;
}

@armResourceOperations
interface ElasticSans {
  @doc("Get a ElasticSan.")
  get is ArmResourceRead<ElasticSan>;

  @doc("Create ElasticSan.")
  create is ArmResourceCreateOrUpdateAsync<
    ElasticSan,
    BaseParameters<ElasticSan>,
    ArmLroLocationHeader
  >;

  @doc("Update a Elastic San.")
  update is ArmCustomPatchAsync<
    ElasticSan,
    ElasticSanUpdate,
    BaseParameters<ElasticSan>,
    ArmLroLocationHeader
  >;

  @doc("Delete a Elastic San.")
  delete is ArmResourceDeleteAsync<
    ElasticSan,
    BaseParameters<ElasticSan>,
    ArmLroLocationHeader
  >;

  @doc("Gets a list of ElasticSan in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ElasticSan>;

  @doc("Gets a list of ElasticSans in a subscription")
  listBySubscription is ArmListBySubscription<ElasticSan>;
}

@@projectedName(ElasticSans.create::parameters.resource, "json", "parameters");
@@extension(ElasticSans.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ElasticSans.create::parameters.resource, "Elastic San object.");
@@projectedName(ElasticSans.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ElasticSans.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ElasticSans.update::parameters.properties, "Elastic San object.");
