import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureArcData;
/**
 * A failover group resource.
 */
@parentResource(SqlManagedInstance)
model FailoverGroupResource is Azure.ResourceManager.ProxyResource<
  FailoverGroupProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = FailoverGroupResource,
    KeyName = "failoverGroupName",
    SegmentName = "failoverGroups",
    NamePattern = ""
  >;
}

@armResourceOperations
interface FailoverGroupResources {
  /**
   * Retrieves a failover group resource
   */
  get is ArmResourceRead<FailoverGroupResource>;

  /**
   * Creates or replaces a failover group resource.
   */
  create is ArmResourceCreateOrReplaceAsync<FailoverGroupResource>;

  /**
   * Deletes a failover group resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    FailoverGroupResource,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * List the failover groups associated with the given sql managed instance.
   */
  @summary("List the failover groups associated with the given sql managed instance.")
  list is ArmResourceListByParent<
    FailoverGroupResource,
    Response = ArmResponse<FailoverGroupListResult>
  >;
}

@@doc(FailoverGroupResource.name, "The name of the Failover Group");
@@doc(FailoverGroupResource.properties, "null");
@@doc(FailoverGroupResources.create::parameters.resource, "desc");
