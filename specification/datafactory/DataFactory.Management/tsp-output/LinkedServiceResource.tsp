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
/**
 * Linked service resource type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Factory)
@includeInapplicableMetadataInPayload(false)
model LinkedServiceResource extends SubResource {
  /**
   * The linked service name.
   */
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @path
  @key("linkedServiceName")
  @segment("linkedservices")
  @visibility("read")
  name: string;

  /**
   * Properties of linked service.
   */
  @extension("x-ms-client-flatten", true)
  properties: LinkedService;
}

@armResourceOperations
interface LinkedServiceResources {
  /**
   * Gets a linked service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LinkedServices_Get")
  get is ArmResourceRead<
    LinkedServiceResource,
    {
      ...BaseParameters<LinkedServiceResource>;

      /**
       * ETag of the linked service entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Creates or updates a linked service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LinkedServices_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    LinkedServiceResource,
    {
      ...BaseParameters<LinkedServiceResource>;

      /**
       * ETag of the linkedService entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Deletes a linked service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LinkedServices_Delete")
  delete is ArmResourceDeleteSync<LinkedServiceResource>;

  /**
   * Lists linked services.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
