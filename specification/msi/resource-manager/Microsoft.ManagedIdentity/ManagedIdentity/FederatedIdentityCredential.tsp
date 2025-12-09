import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./Identity.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ManagedIdentity;
/**
 * Describes a federated identity credential.
 */
@parentResource(Identity)
model FederatedIdentityCredential
  is Azure.ResourceManager.ProxyResource<FederatedIdentityCredentialProperties> {
  ...ResourceNameParameter<
    Resource = FederatedIdentityCredential,
    KeyName = "federatedIdentityCredentialResourceName",
    SegmentName = "federatedIdentityCredentials",
    NamePattern = "^[a-zA-Z0-9]{1}[a-zA-Z0-9-_]{2,119}$"
  >;
}

@armResourceOperations
interface FederatedIdentityCredentials {
  /**
   * Gets the federated identity credential.
   */
  get is ArmResourceRead<FederatedIdentityCredential, Error = CloudError>;

  /**
   * Create or update a federated identity credential under the specified user assigned identity.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    FederatedIdentityCredential,
    Error = CloudError
  >;

  /**
   * Deletes the federated identity credential.
   */
  delete is ArmResourceDeleteSync<
    FederatedIdentityCredential,
    Error = CloudError
  >;

  /**
   * Lists all the federated identity credentials under the specified user assigned identity.
   */
  list is ArmResourceListByParent<
    FederatedIdentityCredential,
    Parameters = {
      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    },
    Response = FederatedIdentityCredentialsListResult,
    Error = CloudError
  >;
}

@@clientName(FederatedIdentityCredentials.createOrUpdate::parameters.resource,
  "parameters"
);

@@doc(FederatedIdentityCredential.name,
  "The name of the federated identity credential resource."
);
@@doc(FederatedIdentityCredential.properties,
  "The properties associated with the federated identity credential."
);
@@doc(FederatedIdentityCredentials.createOrUpdate::parameters.resource,
  "Parameters to create or update the federated identity credential."
);
