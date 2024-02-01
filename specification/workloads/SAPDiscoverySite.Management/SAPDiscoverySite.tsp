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

namespace Microsoft.Workloads;
/**
 * Define the SAP Migration discovery site resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SAPDiscoverySiteProperties)
#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is a product."
model SAPDiscoverySite extends TrackedResourceBase {
  /**
   * The name of the discovery site resource for SAP Migration.
   */
  @pattern("^[A-Za-z][\\w-]*[A-Za-z0-9]$")
  @path
  @key("sapDiscoverySiteName")
  @segment("sapDiscoverySites")
  @visibility("read")
  name: string;

  /**
   * The extended location definition.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * The SAP Migration discovery site resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SAPDiscoverySiteProperties;
}

@armResourceOperations
#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is a product."
interface SAPDiscoverySites {
  /**
   * Gets a SAP Migration discovery site resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  get is ArmResourceRead<SAPDiscoverySite>;

  /**
   * Creates a discovery site for SAP Migration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  create is ArmResourceCreateOrReplaceAsync<
    SAPDiscoverySite,
    BaseParameters<SAPDiscoverySite>,
    ArmLroLocationHeader
  >;

  /**
   * Updates a SAP Migration discovery site resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    SAPDiscoverySite,
    UpdateSAPDiscoverySiteRequest,
    BaseParameters<SAPDiscoverySite>,
    ArmLroLocationHeader
  >;

  /**
   * Deletes a SAP Migration discovery site resource and its child resources, that is the associated SAP Instances and Server Instances.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  delete is ArmResourceDeleteAsync<
    SAPDiscoverySite,
    BaseParameters<SAPDiscoverySite>,
    ArmLroLocationHeader
  >;

  /**
   * Gets all SAP Migration discovery site resources in a Resource Group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  listByResourceGroup is ArmResourceListByParent<SAPDiscoverySite>;

  /**
   * Gets all SAP Migration discovery site resources in a Subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  listBySubscription is ArmListBySubscription<SAPDiscoverySite>;

  /**
   * Import a SAP Migration discovery site resource and it's child resources, that is the SAP instances and Server instances.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  importEntities is ArmResourceActionAsync<
    SAPDiscoverySite,
    void,
    OperationStatusResult,
    BaseParameters<SAPDiscoverySite>,
    ArmLroLocationHeader
  >;
}

@@projectedName(SAPDiscoverySites.create::parameters.resource, "json", "body");
@@extension(SAPDiscoverySites.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(SAPDiscoverySites.create::parameters.resource,
  "SAP Migration discovery site resource request body."
);
@@projectedName(SAPDiscoverySites.update::parameters.properties,
  "json",
  "body"
);
@@extension(SAPDiscoverySites.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(SAPDiscoverySites.update::parameters.properties,
  "Request body to update a SAP Migration discovery site resource."
);
