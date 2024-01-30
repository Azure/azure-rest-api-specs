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

namespace Microsoft.ProgrammableConnectivity;
/**
 * A Programmable Connectivity Gateway resource
 */
model Gateway is TrackedResource<GatewayProperties> {
  /**
   * Azure Programmable Connectivity Gateway Name
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("gatewayName")
  @segment("gateways")
  @visibility("read")
  name: string;
}

/**
 * Gateway resource properties
 */
model GatewayProperties {
  /**
   * List of Operator API Connections selected by the user
   */
  @visibility("read")
  operatorApiConnections?: ResourceIdentifier<[
    {
      type: "Microsoft.ProgrammableConnectivity/operatorApiConnections";
    }
  ]>[];

  /**
   * Base URL of the Gateway resource. This is the URL that the users would use to make Open API Gateway requests to the Operators via Azure.
   */
  @visibility("read")
  gatewayBaseUrl?: string;

  /**
   * The status of the last operation on the Gateway resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Properties for update operations of the Gateway.
 */
model GatewayUpdate {
  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * Gateway resource properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: GatewayProperties;
}

@armResourceOperations
interface Gateways {
  /**
   * Get a Gateway resource by name.
   */
  get is ArmResourceRead<Gateway>;

  /**
   * Create or update an APC Gateway.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Gateway>;

  /**
   * Delete a Gateway
   */
  delete is ArmResourceDeleteWithoutOkAsync<Gateway>;

  /**
   * List Gateway resources by resource group.
   */
  //#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  //@operationId("Gateways_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Gateway>;

  /**
   * List Gateway resources by subscription ID.
   */
  listBySubscription is ArmListBySubscription<Gateway>;
}
/*
@@projectedName(Gateways.createOrUpdate::parameters.resource, "json", "body");
@@extension(Gateways.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(Gateways.createOrUpdate::parameters.resource,
  "Gateway resource create parameters."
);
@@projectedName(Gateways.update::parameters.properties, "json", "body");
@@extension(Gateways.update::parameters.properties, "x-ms-client-name", "body");
@@doc(Gateways.update::parameters.properties,
  "Updatable properties for a Gateway resource."
);*/
