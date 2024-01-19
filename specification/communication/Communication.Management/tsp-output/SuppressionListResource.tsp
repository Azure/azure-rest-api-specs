import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DomainResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Communication;
@doc("A class representing a SuppressionList resource.")
@parentResource(DomainResource)
model SuppressionListResource is ProxyResource<SuppressionListProperties> {
  @doc("The name of the suppression list.")
  @maxLength(253)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]+$")
  @path
  @key("suppressionListName")
  @segment("suppressionLists")
  name: string;
}

@armResourceOperations
interface SuppressionListResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a SuppressionList resource.")
  @operationId("SuppressionLists_Get")
  get is ArmResourceRead<SuppressionListResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Add a new SuppressionList resource under the parent Domains resource or update an existing SuppressionList resource.")
  @operationId("SuppressionLists_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SuppressionListResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a SuppressionList.")
  @operationId("SuppressionLists_Delete")
  delete is ArmResourceDeleteSync<SuppressionListResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all suppression lists for a domains resource.")
  @operationId("SuppressionLists_ListByDomain")
  listByDomain is ArmResourceListByParent<SuppressionListResource>;
}

@@projectedName(SuppressionListResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SuppressionListResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SuppressionListResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
