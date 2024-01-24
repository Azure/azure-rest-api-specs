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

namespace Microsoft.ManagedNetworkFabric;
/**
 * The IP Prefix resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(IpPrefixProperties)
@includeInapplicableMetadataInPayload(false)
model IpPrefix extends TrackedResourceBase {
  /**
   * Name of the IP Prefix.
   */
  @path
  @key("ipPrefixName")
  @segment("ipPrefixes")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: IpPrefixProperties;
}

@armResourceOperations
interface IpPrefixes {
  /**
   * Implements IP Prefix GET method.
   */
  get is ArmResourceRead<IpPrefix>;

  /**
   * Implements IP Prefix PUT method.
   */
  create is ArmResourceCreateOrReplaceAsync<
    IpPrefix,
    BaseParameters<IpPrefix>,
    ArmAsyncOperationHeader
  >;

  /**
   * API to update certain properties of the IP Prefix resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    IpPrefix,
    IpPrefixPatch,
    BaseParameters<IpPrefix>,
    ArmLroLocationHeader
  >;

  /**
   * Implements IP Prefix DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    IpPrefix,
    BaseParameters<IpPrefix>,
    ArmLroLocationHeader
  >;

  /**
   * Implements IpPrefixes list by resource group GET method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IpPrefixes_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<IpPrefix>;

  /**
   * Implements IpPrefixes list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<IpPrefix>;
}

@@projectedName(IpPrefixes.create::parameters.resource, "json", "body");
@@extension(IpPrefixes.create::parameters.resource, "x-ms-client-name", "body");
@@doc(IpPrefixes.create::parameters.resource, "Request payload.");
@@projectedName(IpPrefixes.update::parameters.properties, "json", "body");
@@extension(IpPrefixes.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(IpPrefixes.update::parameters.properties,
  "IP Prefix properties to update."
);
