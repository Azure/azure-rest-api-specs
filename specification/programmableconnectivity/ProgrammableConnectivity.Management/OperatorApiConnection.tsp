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
 * A Programmable Connectivity Operator API Connection resource
 */
model OperatorApiConnection
  is Azure.ResourceManager.TrackedResource<OperatorApiConnectionProperties> {
  /**
   * Azure Programmable Connectivity (APC) Operator API Connection Name.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("operatorApiConnectionName")
  @segment("operatorApiConnections")
  @visibility("read", "create")
  name: string;
}

/**
 * Operator API Connection resource properties that cannot be updated once a resource has been created.
 */
model OperatorApiConnectionProperties {
  /**
   * Reference to the Operator API Plan Resource ID.
   */
  @visibility("read", "create", "update")
  operatorApiPlanId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ProgrammableConnectivity/operatorApiPlans";
    }
  ]>;

  /**
   * Details about the SaaS offer purchased from the marketplace.
   */
  @visibility("read", "create", "update")
  saasProperties?: SaasProperties;

  /**
   * Details about the Application that would use the Operator's Network APIs.
   */
  @visibility("read", "create", "update")
  configuredApplication?: ApplicationProperties;

  /**
   * Application ID of the App Developer that is registered with the Operator in a specific country/region.
   */
  @visibility("read", "create", "update")
  appId?: string;

  /**
   * Reference to the APC Gateway resource ID.
   */
  @visibility("read", "create")
  gatewayId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ProgrammableConnectivity/gateways";
    }
  ]>;

  /**
   * Type of the account the user has with the Operator's Network API infrastructure. AzureManaged | UserManaged.
   */
  @visibility("read", "create")
  accountType: AccountType;

  /**
   * Application secret linked to the 'appId'. This should be stored securely and is not returned back when the resource information is read.
   */
  @visibility("create", "update")
  @secret
  appSecret?: string;

  /**
   * Name of the Operator in the linked Operator API Plan belongs to.
   */
  @visibility("read")
  operatorName?: string;

  /**
   * The Network API for the current operator in the country/region provided in the linked Operator API Plan.
   */
  @visibility("read")
  camaraApiName?: string;

  /**
   * The status of the last operation.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The status of the OperatorApiConnection resource.
   */
  @visibility("read")
  status?: Status;
}

/**
 * The Account Type of the Operator API Connections.
 */
union AccountType {
  /**
   * Managed by Azure on-behalf-of the user.
   */
  AzureManaged: "AzureManaged",

  /**
   * Managed by the User themselves on the Operator end.
   */
  UserManaged: "UserManaged",

  string,
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

/**
 * Details about the SaaS offer purchased from the marketplace.
 */
model SaasProperties {
  /**
   * Subscription ID of the SaaS offer purchased from the marketplace.
   */
  saasSubscriptionId?: string;

  /**
   * Resource ID of the SaaS offer purchased from the marketplace.
   */
  saasResourceId?: string;
}

/**
 * Description of the current status of the OperatorApiConnection resource.
 */
model Status {
  /**
   * Current state of the OperatorApiConnection resource.
   */
  state?: string;

  /**
   * Explanation of the current state of the OperatorApiConnection resource.
   */
  reason?: string;
}

@armResourceOperations
interface OperatorApiConnections {
  /**
   * Get an Operator API Connection.
   */
  get is ArmResourceRead<OperatorApiConnection>;

  /**
   * Create an Operator API Connection.
   */
  create is ArmResourceCreateOrReplaceAsync<OperatorApiConnection>;

  /**
   * Update an Operator API Connection.
   */
  update is ArmCustomPatchAsync<
    OperatorApiConnection,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      OperatorApiConnection,
      OperatorApiConnectionProperties
    >
  >;

  /**
   * Delete an Operator API Connection.
   */
  delete is ArmResourceDeleteWithoutOkAsync<OperatorApiConnection>;

  /**
   * List OperatorApiConnection resources by resource group.
   */
  listByResourceGroup is ArmResourceListByParent<OperatorApiConnection>;

  /**
   * List OperatorApiConnection resources by subscription ID.
   */
  listBySubscription is ArmListBySubscription<OperatorApiConnection>;
}
