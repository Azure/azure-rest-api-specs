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

namespace Microsoft.Confluent;
@doc("Organization resource.")
model OrganizationResource is TrackedResource<OrganizationResourceProperties> {
  @doc("Organization resource name")
  @path
  @key("organizationName")
  @segment("organizations")
  name: string;
}

@armResourceOperations
interface OrganizationResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the properties of a specific Organization resource.")
  @operationId("Organization_Get")
  get is ArmResourceRead<OrganizationResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create Organization resource")
  @operationId("Organization_Create")
  create is ArmResourceCreateOrUpdateAsync<
    OrganizationResource,
    BaseParameters<OrganizationResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update Organization resource")
  @operationId("Organization_Update")
  update is ArmCustomPatchSync<
    OrganizationResource,
    OrganizationResourceUpdate
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete Organization resource")
  @operationId("Organization_Delete")
  delete is ArmResourceDeleteAsync<
    OrganizationResource,
    BaseParameters<OrganizationResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all Organizations under the specified resource group.")
  @operationId("Organization_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<OrganizationResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all organizations under the specified subscription.")
  @operationId("Organization_ListBySubscription")
  listBySubscription is ArmListBySubscription<OrganizationResource>;
}

@@projectedName(OrganizationResources.create::parameters.resource,
  "json",
  "body"
);
@@extension(OrganizationResources.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(OrganizationResources.create::parameters.resource,
  "Organization resource model"
);
@@projectedName(OrganizationResources.update::parameters.properties,
  "json",
  "body"
);
@@extension(OrganizationResources.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(OrganizationResources.update::parameters.properties,
  "Updated Organization resource"
);
