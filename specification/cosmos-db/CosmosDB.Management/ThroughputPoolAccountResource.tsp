import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ThroughputPoolResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * An Azure Cosmos DB Throughputpool Account
 */
@parentResource(ThroughputPoolResource)
model ThroughputPoolAccountResource
  is Azure.ResourceManager.ProxyResource<ThroughputPoolAccountProperties> {
  ...ResourceNameParameter<
    Resource = ThroughputPoolAccountResource,
    KeyName = "throughputPoolAccountName",
    SegmentName = "throughputPoolAccounts",
    NamePattern = "^[a-z0-9]+(-[a-z0-9]+)*"
  >;
}

@armResourceOperations
interface ThroughputPoolAccountResources {
  /**
   * Retrieves the properties of an existing Azure Cosmos DB Throughput Pool
   */
  get is ArmResourceRead<ThroughputPoolAccountResource>;

  /**
   * Creates or updates an Azure Cosmos DB ThroughputPool account. The "Update" method is preferred when performing updates on an account.
   */
  create is ArmResourceCreateOrReplaceAsync<ThroughputPoolAccountResource>;

  /**
   * Removes an existing Azure Cosmos DB database account from a throughput pool.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ThroughputPoolAccountResource,
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the Azure Cosmos DB accounts available under the subscription.
   */
  list is ArmResourceListByParent<
    ThroughputPoolAccountResource,
    Response = ThroughputPoolAccountsListResult
  >;
}

@@maxLength(ThroughputPoolAccountResource.name, 50);
@@minLength(ThroughputPoolAccountResource.name, 3);
@@doc(ThroughputPoolAccountResource.name,
  "Cosmos DB global database account in a Throughput Pool"
);
@@doc(ThroughputPoolAccountResource.properties,
  "An Azure Cosmos DB Global Database Account which is part of a Throughputpool."
);
@@doc(ThroughputPoolAccountResources.create::parameters.resource,
  "The parameters to provide for the current ThroughputPoolAccount."
);
