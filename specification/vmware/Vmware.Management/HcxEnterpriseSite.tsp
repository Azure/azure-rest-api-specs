import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * An HCX Enterprise Site resource
 */
@parentResource(PrivateCloud)
model HcxEnterpriseSite
  is Azure.ResourceManager.ProxyResource<HcxEnterpriseSiteProperties> {
  ...ResourceNameParameter<
    Resource = HcxEnterpriseSite,
    KeyName = "hcxEnterpriseSiteName",
    SegmentName = "hcxEnterpriseSites",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface HcxEnterpriseSites {
  /**
   * Get a HcxEnterpriseSite
   */
  get is ArmResourceRead<HcxEnterpriseSite>;

  /**
   * Create a HcxEnterpriseSite
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<HcxEnterpriseSite>;

  /**
   * Delete a HcxEnterpriseSite
   */
  delete is ArmResourceDeleteSync<HcxEnterpriseSite>;

  /**
   * List HcxEnterpriseSite resources by PrivateCloud
   */
  list is ArmResourceListByParent<
    HcxEnterpriseSite,
    Response = ArmResponse<HcxEnterpriseSiteList>
  >;
}

@@doc(HcxEnterpriseSite.name, "Name of the HCX Enterprise Site");
@@doc(HcxEnterpriseSite.properties,
  "The resource-specific properties for this resource."
);
