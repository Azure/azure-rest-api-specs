import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * An HCX Enterprise Site resource
 */
@parentResource(PrivateCloud)
model HcxEnterpriseSite is ProxyResource<HcxEnterpriseSiteProperties> {
  /**
   * Name of the HCX Enterprise Site in the private cloud
   */
  @pattern("^[-\\w\\._]+$")
  @path
  @key("hcxEnterpriseSiteName")
  @segment("hcxEnterpriseSites")
  name: string;
}

@armResourceOperations
interface HcxEnterpriseSites {
  /**
   * Get an HCX on-premises key by name in a private cloud
   */
  get is ArmResourceRead<HcxEnterpriseSite>;

  /**
   * Create or update an activation key for on-premises HCX site
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<HcxEnterpriseSite>;

  /**
   * Delete HCX on-premises key in a private cloud
   */
  delete is ArmResourceDeleteSync<HcxEnterpriseSite>;

  /**
   * List HCX on-premises key in a private cloud
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("HcxEnterpriseSites_List")
  list is ArmResourceListByParent<HcxEnterpriseSite>;
}

@@projectedName(HcxEnterpriseSites.createOrUpdate::parameters.resource,
  "json",
  "hcxEnterpriseSite"
);
@@extension(HcxEnterpriseSites.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "hcxEnterpriseSite"
);
@@doc(HcxEnterpriseSites.createOrUpdate::parameters.resource,
  "The HCX Enterprise Site"
);
