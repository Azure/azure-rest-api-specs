import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VmwareSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * A vcenter resource belonging to a site resource.
 */
@parentResource(VmwareSite)
model Vcenter is Azure.ResourceManager.ProxyResource<VcenterProperties> {
  ...ResourceNameParameter<
    Resource = Vcenter,
    KeyName = "vcenterName",
    SegmentName = "vcenters"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface Vcenters {
  /**
   * Get a Vcenter
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("VcenterController")
  @operationId("VcenterController_Get")
  get is ArmResourceRead<Vcenter>;

  /**
   * Create a Vcenter
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("VcenterController")
  @operationId("VcenterController_Create")
  create is ArmResourceCreateOrReplaceAsync<
    Vcenter,
    LroHeaders = ArmLroLocationHeader<FinalResult = Vcenter> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a Vcenter
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("VcenterController")
  @operationId("VcenterController_Delete")
  delete is ArmResourceDeleteSync<Vcenter>;

  /**
   * List Vcenter resources by VmwareSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("VcenterController")
  @operationId("VcenterController_ListByVmwareSite")
  listByVmwareSite is ArmResourceListByParent<
    Vcenter,
    Parameters = {
      /**
       * filter query
       */
      @query("filter")
      filter?: string;
    }
  >;
}

@@doc(Vcenter.name, " VCenters name");
@@doc(Vcenter.properties,
  "The resource-specific properties for this resource."
);
