import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./Identity.tsp";
import "./models.tsp";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedIdentity;

/**
 * Describes a flexible federated identity credential.
 */
@parentResource(Identity)
@added(Versions.v2025_01_31_preview)
model FlexibleFederatedIdentityCredential
  is Azure.ResourceManager.ProxyResource<FederatedIdentityCredentialProperties> {
  ...ResourceNameParameter<
    Resource = FlexibleFederatedIdentityCredential,
    KeyName = "federatedIdentityCredentialResourceName",
    SegmentName = "flexibleFederatedIdentityCredentials",
    NamePattern = "^[a-zA-Z0-9]{1}[a-zA-Z0-9-_]{2,119}$"
  >;
}

@armResourceOperations
@added(Versions.v2025_01_31_preview)
interface FlexibleFederatedIdentityCredentials {
  /**
   * Gets the flexible federated identity credential.
   */
  get is ArmResourceRead<
    FlexibleFederatedIdentityCredential,
    Error = CloudError
  >;

  /**
   * Create or update a flexible federated identity credential under the specified user assigned identity.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    FlexibleFederatedIdentityCredential,
    Error = CloudError
  >;

  /**
   * Deletes the flexible federated identity credential.
   */
  delete is ArmResourceDeleteSync<
    FlexibleFederatedIdentityCredential,
    Error = CloudError
  >;

  /**
   * Lists all the flexible federated identity credentials under the specified user assigned identity.
   */
  list is ArmResourceListByParent<
    FlexibleFederatedIdentityCredential,
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

@@clientName(FlexibleFederatedIdentityCredentials.createOrUpdate::parameters.resource,
  "parameters"
);

@@doc(FlexibleFederatedIdentityCredential.name,
  "The name of the flexible federated identity credential resource."
);
@@doc(FlexibleFederatedIdentityCredential.properties,
  "The properties associated with the flexible federated identity credential."
);
@@doc(FlexibleFederatedIdentityCredentials.createOrUpdate::parameters.resource,
  "Parameters to create or update the flexible federated identity credential."
);
