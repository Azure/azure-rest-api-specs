import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
@doc("Linked service resource type.")
@parentResource(Factory)
model LinkedServiceResource is ProxyResource<LinkedService> {
  @doc("The linked service name.")
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @path
  @key("linkedServiceName")
  @segment("linkedservices")
  name: string;
}

@armResourceOperations
interface LinkedServiceResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a linked service.")
  @operationId("LinkedServices_Get")
  get is ArmResourceRead<
    LinkedServiceResource,
    {
      ...BaseParameters<LinkedServiceResource>;

      @doc("ETag of the linked service entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a linked service.")
  @operationId("LinkedServices_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    LinkedServiceResource,
    {
      ...BaseParameters<LinkedServiceResource>;

      @doc("ETag of the linkedService entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a linked service.")
  @operationId("LinkedServices_Delete")
  delete is ArmResourceDeleteSync<LinkedServiceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists linked services.")
  @operationId("LinkedServices_ListByFactory")
  listByFactory is ArmResourceListByParent<LinkedServiceResource>;
}

@@projectedName(LinkedServiceResources.createOrUpdate::parameters.resource,
  "json",
  "linkedService"
);
@@extension(LinkedServiceResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "linkedService"
);
@@doc(LinkedServiceResources.createOrUpdate::parameters.resource,
  "Linked service resource definition."
);
