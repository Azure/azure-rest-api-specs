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
model Gateway is Azure.ResourceManager.TrackedResource<GatewayProperties> {
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
  operatorApiConnections?: Azure.Core.armResourceIdentifier<[
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

  /**
   * Details about the Application that would use the Operator's Network APIs.
   */
  @TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
  @visibility("read", "create", "update")
  configuredApplication?: ApplicationProperties;
}

/**
 * Details about the Application that would use the Operator's Network APIs.
 */
model ApplicationProperties {
  /**
   * Name of the application. Example: Contoso App.
   */
  name?: string;

  /**
   * Description of the application.
   */
  applicationDescription?: string;

  /**
   * The category that describes the application.
   */
  applicationType?: string;

  /**
   * Legal name of the organization owning the application.
   */
  legalName?: string;

  /**
   * A description of the organization owning the application.
   */
  organizationDescription?: string;

  /**
   * Unique Tax Number for the user's organization in the country/region the APC Gateway is being purchased.
   */
  taxNumber?: string;

  /**
   * Email address of the Privacy contact or Data Protection officer of the organization.
   */
  privacyContactEmailAddress?: string;
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
   * Update Gateway tags.
   */
  update is ArmTagsPatchSync<Gateway>;

  /**
   * Delete a Gateway.
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
