import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./OperationContract.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Policy Contract details.
 */
@parentResource(OperationContract)
model PolicyContract
  is Azure.ResourceManager.ProxyResource<PolicyContractProperties> {
  ...ResourceNameParameter<
    Resource = PolicyContract,
    KeyName = "policyId",
    SegmentName = "policies",
    NamePattern = "",
    Type = PolicyIdName
  >;
}

@armResourceOperations
interface PolicyContractOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("apis")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(256)
        apiId: string,

        /** Operation identifier within an API. Must be unique in the current API Management service instance. */
        @path
        @segment("operations")
        @key
        @minLength(1)
        @maxLength(80)
        operationId: string,
      },
      {
        /** The identifier of the Policy. */
        @path
        @segment("policies")
        @key
        policyId: PolicyIdName,
      }
    > {}

@armResourceOperations
interface PolicyContracts {
  /**
   * Get the policy configuration at the API Operation level.
   */
  get is PolicyContractOps.Read<
    PolicyContract,
    Parameters = {
      /**
       * Policy Export Format.
       */
      @query("format")
      format?: PolicyExportFormat = PolicyExportFormat.xml;
    },
    Response = ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the API operation policy specified by its identifier.
   */
  getEntityTag is PolicyContractOps.CheckExistence<
    PolicyContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates policy configuration for the API Operation level.
   */
  createOrUpdate is PolicyContractOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes the policy configuration at the Api Operation.
   */
  delete is PolicyContractOps.DeleteSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Get the list of policy configuration at the API Operation level.
   */
  listByOperation is PolicyContractOps.ListSinglePage<
    PolicyContract,
    Response = ArmResponse<PolicyCollection>
  >;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface GraphQLApiResolverPolicyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("apis")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(256)
        apiId: string,

        /** Resolver identifier within a GraphQL API. Must be unique in the current API Management service instance. */
        @path
        @segment("resolvers")
        @key
        @minLength(1)
        @maxLength(80)
        resolverId: string,
      },
      {
        /** The identifier of the Policy. */
        @path
        @segment("policies")
        @key
        policyId: PolicyIdName,
      }
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface GraphQLApiResolverPolicy {
  /**
   * Get the policy configuration at the GraphQL API Resolver level.
   */
  get is GraphQLApiResolverPolicyOps.Read<
    PolicyContract,
    Parameters = {
      /**
       * Policy Export Format.
       */
      @query("format")
      format?: PolicyExportFormat = PolicyExportFormat.xml;
    },
    Response = ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the GraphQL API resolver policy specified by its identifier.
   */
  getEntityTag is GraphQLApiResolverPolicyOps.CheckExistence<
    PolicyContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates policy configuration for the GraphQL API Resolver level.
   */
  createOrUpdate is GraphQLApiResolverPolicyOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes the policy configuration at the GraphQL Api Resolver.
   */
  delete is GraphQLApiResolverPolicyOps.DeleteSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Get the list of policy configuration at the GraphQL API Resolver level.
   */
  listByResolver is GraphQLApiResolverPolicyOps.List<
    PolicyContract,
    Response = ArmResponse<PolicyCollection>
  >;
}
@armResourceOperations
interface ApiPolicyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("apis")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(256)
        apiId: string,
      },
      {
        /** The identifier of the Policy. */
        @path
        @segment("policies")
        @key
        policyId: PolicyIdName,
      }
    > {}

@armResourceOperations
interface ApiPolicy {
  /**
   * Get the policy configuration at the API level.
   */
  get is ApiPolicyOps.Read<
    PolicyContract,
    Parameters = {
      /**
       * Policy Export Format.
       */
      @query("format")
      format?: PolicyExportFormat = PolicyExportFormat.xml;
    },
    Response = ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the API policy specified by its identifier.
   */
  getEntityTag is ApiPolicyOps.CheckExistence<
    PolicyContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates policy configuration for the API.
   */
  createOrUpdate is ApiPolicyOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes the policy configuration at the Api.
   */
  delete is ApiPolicyOps.DeleteSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Get the policy configuration at the API level.
   */
  listByApi is ApiPolicyOps.ListSinglePage<
    PolicyContract,
    Response = ArmResponse<PolicyCollection>
  >;
}
@armResourceOperations
interface PolicyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,
      },
      {
        /** The identifier of the Policy. */
        @path
        @segment("policies")
        @key
        policyId: PolicyIdName,
      }
    > {}

@armResourceOperations
interface Policy {
  /**
   * Get the Global policy definition of the Api Management service.
   */
  get is PolicyOps.Read<
    PolicyContract,
    Parameters = {
      /**
       * Policy Export Format.
       */
      @query("format")
      format?: PolicyExportFormat = PolicyExportFormat.xml;
    },
    Response = ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the Global policy definition in the Api Management service.
   */
  getEntityTag is PolicyOps.CheckExistence<
    PolicyContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates the global policy configuration of the Api Management service.
   */
  createOrUpdate is PolicyOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes the global policy configuration of the Api Management Service.
   */
  delete is PolicyOps.DeleteSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Lists all the Global Policy definitions of the Api Management service.
   */
  listByService is PolicyOps.List<
    PolicyContract,
    Response = ArmResponse<PolicyCollection>
  >;
}
@armResourceOperations
interface ProductPolicyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** Product identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("products")
        @key
        @minLength(1)
        @maxLength(256)
        productId: string,
      },
      {
        /** The identifier of the Policy. */
        @path
        @segment("policies")
        @key
        policyId: PolicyIdName,
      }
    > {}

@armResourceOperations
interface ProductPolicy {
  /**
   * Get the policy configuration at the Product level.
   */
  get is ProductPolicyOps.Read<
    PolicyContract,
    Parameters = {
      /**
       * Policy Export Format.
       */
      @query("format")
      format?: PolicyExportFormat = PolicyExportFormat.xml;
    },
    Response = ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Get the ETag of the policy configuration at the Product level.
   */
  getEntityTag is ProductPolicyOps.CheckExistence<
    PolicyContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates policy configuration for the Product.
   */
  createOrUpdate is ProductPolicyOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes the policy configuration at the Product.
   */
  delete is ProductPolicyOps.DeleteSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Get the policy configuration at the Product level.
   */
  listByProduct is ProductPolicyOps.List<
    PolicyContract,
    Response = ArmResponse<PolicyCollection>
  >;
}
@armResourceOperations
interface WorkspacePolicyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        workspaceId: string,
      },
      {
        /** The identifier of the Policy. */
        @path
        @segment("policies")
        @key
        policyId: PolicyIdName,
      }
    > {}

@armResourceOperations
interface WorkspacePolicy {
  /**
   * Get the policy configuration at the API level.
   */
  get is WorkspacePolicyOps.Read<
    PolicyContract,
    Parameters = {
      /**
       * Policy Export Format.
       */
      @query("format")
      format?: PolicyExportFormat = PolicyExportFormat.xml;
    },
    Response = ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the workspace policy specified by its identifier.
   */
  getEntityTag is WorkspacePolicyOps.CheckExistence<
    PolicyContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates policy configuration for the workspace.
   */
  createOrUpdate is WorkspacePolicyOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes the policy configuration at the workspace.
   */
  delete is WorkspacePolicyOps.DeleteSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Get the policy configuration at the workspace level.
   */
  listByApi is WorkspacePolicyOps.List<
    PolicyContract,
    Response = ArmResponse<PolicyCollection>
  >;
}
@armResourceOperations
interface WorkspaceApiOperationPolicyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        workspaceId: string,

        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("apis")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(256)
        apiId: string,

        /** Operation identifier within an API. Must be unique in the current API Management service instance. */
        @path
        @segment("operations")
        @key
        @minLength(1)
        @maxLength(80)
        operationId: string,
      },
      {
        /** The identifier of the Policy. */
        @path
        @segment("policies")
        @key
        policyId: PolicyIdName,
      }
    > {}

@armResourceOperations
interface WorkspaceApiOperationPolicy {
  /**
   * Get the policy configuration at the API Operation level.
   */
  get is WorkspaceApiOperationPolicyOps.Read<
    PolicyContract,
    Parameters = {
      /**
       * Policy Export Format.
       */
      @query("format")
      format?: PolicyExportFormat = PolicyExportFormat.xml;
    },
    Response = ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the API operation policy specified by its identifier.
   */
  getEntityTag is WorkspaceApiOperationPolicyOps.CheckExistence<
    PolicyContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates policy configuration for the API Operation level.
   */
  createOrUpdate is WorkspaceApiOperationPolicyOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmCreatedResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes the policy configuration at the Api Operation.
   */
  delete is WorkspaceApiOperationPolicyOps.DeleteSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Get the list of policy configuration at the API Operation level.
   */
  listByOperation is WorkspaceApiOperationPolicyOps.List<
    PolicyContract,
    Response = ArmResponse<PolicyCollection>
  >;
}
@armResourceOperations
interface WorkspaceApiPolicyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        workspaceId: string,

        /** API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number. */
        @path
        @segment("apis")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(256)
        apiId: string,
      },
      {
        /** The identifier of the Policy. */
        @path
        @segment("policies")
        @key
        policyId: PolicyIdName,
      }
    > {}

@armResourceOperations
interface WorkspaceApiPolicy {
  /**
   * Get the policy configuration at the API level.
   */
  get is WorkspaceApiPolicyOps.Read<
    PolicyContract,
    Parameters = {
      /**
       * Policy Export Format.
       */
      @query("format")
      format?: PolicyExportFormat = PolicyExportFormat.xml;
    },
    Response = ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the API policy specified by its identifier.
   */
  getEntityTag is WorkspaceApiPolicyOps.CheckExistence<
    PolicyContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates policy configuration for the API.
   */
  createOrUpdate is WorkspaceApiPolicyOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmCreatedResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes the policy configuration at the Api.
   */
  delete is WorkspaceApiPolicyOps.DeleteSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Get the policy configuration at the API level.
   */
  listByApi is WorkspaceApiPolicyOps.List<
    PolicyContract,
    Response = ArmResponse<PolicyCollection>
  >;
}
@armResourceOperations
interface WorkspaceProductPolicyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        workspaceId: string,

        /** Product identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("products")
        @key
        @minLength(1)
        @maxLength(256)
        productId: string,
      },
      {
        /** The identifier of the Policy. */
        @path
        @segment("policies")
        @key
        policyId: PolicyIdName,
      }
    > {}

@armResourceOperations
interface WorkspaceProductPolicy {
  /**
   * Get the policy configuration at the Product level.
   */
  get is WorkspaceProductPolicyOps.Read<
    PolicyContract,
    Parameters = {
      /**
       * Policy Export Format.
       */
      @query("format")
      format?: PolicyExportFormat = PolicyExportFormat.xml;
    },
    Response = ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Get the ETag of the policy configuration at the Product level.
   */
  getEntityTag is WorkspaceProductPolicyOps.CheckExistence<
    PolicyContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates policy configuration for the Product.
   */
  createOrUpdate is WorkspaceProductPolicyOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmCreatedResponse<PolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes the policy configuration at the Product.
   */
  delete is WorkspaceProductPolicyOps.DeleteSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Get the policy configuration at the Product level.
   */
  listByProduct is WorkspaceProductPolicyOps.ListSinglePage<
    PolicyContract,
    Response = ArmResponse<PolicyCollection>
  >;
}

@@doc(PolicyContract.name, "The identifier of the Policy.");
@@doc(PolicyContract.properties, "Properties of the Policy.");
@@doc(PolicyContracts.createOrUpdate::parameters.resource,
  "The policy contents to apply."
);
@@doc(GraphQLApiResolverPolicy.createOrUpdate::parameters.resource,
  "The policy contents to apply."
);
@@doc(ApiPolicy.createOrUpdate::parameters.resource,
  "The policy contents to apply."
);
@@doc(Policy.createOrUpdate::parameters.resource,
  "The policy contents to apply."
);
@@doc(ProductPolicy.createOrUpdate::parameters.resource,
  "The policy contents to apply."
);
@@doc(WorkspacePolicy.createOrUpdate::parameters.resource,
  "The policy contents to apply."
);
@@doc(WorkspaceApiOperationPolicy.createOrUpdate::parameters.resource,
  "The policy contents to apply."
);
@@doc(WorkspaceApiPolicy.createOrUpdate::parameters.resource,
  "The policy contents to apply."
);
@@doc(WorkspaceProductPolicy.createOrUpdate::parameters.resource,
  "The policy contents to apply."
);
