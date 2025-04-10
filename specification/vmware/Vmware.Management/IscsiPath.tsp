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
 * An iSCSI path resource
 */
@singleton("default")
@parentResource(PrivateCloud)
model IscsiPath is Azure.ResourceManager.ProxyResource<IscsiPathProperties> {
  ...ResourceNameParameter<
    Resource = IscsiPath,
    KeyName = "iscsiPath",
    SegmentName = "iscsiPaths",
    NamePattern = ""
  >;
}

@armResourceOperations
interface IscsiPaths {
  /**
   * Get a IscsiPath
   */
  get is ArmResourceRead<IscsiPath>;

  /**
   * Create a IscsiPath
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<IscsiPath>;

  /**
   * Delete a IscsiPath
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    IscsiPath,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List IscsiPath resources by PrivateCloud
   */
  listByPrivateCloud is ArmResourceListByParent<IscsiPath>;
}

@@doc(IscsiPath.name, "");
@@doc(IscsiPath.properties,
  "The resource-specific properties for this resource."
);
