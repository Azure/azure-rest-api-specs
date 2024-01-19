import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PeeringService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Peering;
@doc("The peering service prefix class.")
@parentResource(PeeringService)
model PeeringServicePrefix is ProxyResource<PeeringServicePrefixProperties> {
  @doc("The name of the prefix.")
  @path
  @key("prefixName")
  @segment("prefixes")
  name: string;
}

@armResourceOperations
interface PeeringServicePrefixes {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets an existing prefix with the specified name under the given subscription, resource group and peering service.")
  @operationId("Prefixes_Get")
  get is ArmResourceRead<
    PeeringServicePrefix,
    {
      ...BaseParameters<PeeringServicePrefix>;

      @doc("The properties to be expanded.")
      @query("$expand")
      $expand?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a new prefix with the specified name under the given subscription, resource group and peering service.")
  @operationId("Prefixes_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PeeringServicePrefix>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an existing prefix with the specified name under the given subscription, resource group and peering service.")
  @operationId("Prefixes_Delete")
  delete is ArmResourceDeleteSync<PeeringServicePrefix>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all prefixes under the given subscription, resource group and peering service.")
  @operationId("Prefixes_ListByPeeringService")
  listByPeeringService is ArmResourceListByParent<
    PeeringServicePrefix,
    {
      ...BaseParameters<PeeringServicePrefix>;

      @doc("The properties to be expanded.")
      @query("$expand")
      $expand?: string;
    }
  >;
}

@@projectedName(PeeringServicePrefixes.createOrUpdate::parameters.resource,
  "json",
  "peeringServicePrefix"
);
@@extension(PeeringServicePrefixes.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "peeringServicePrefix"
);
@@doc(PeeringServicePrefixes.createOrUpdate::parameters.resource,
  "The properties needed to create a prefix."
);
