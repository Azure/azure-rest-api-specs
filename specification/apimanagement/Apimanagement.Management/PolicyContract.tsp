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
        ...KeysOf<ResourceNameParameter<
          Resource = ApiManagementServiceResource,
          KeyName = "serviceName",
          SegmentName = "service",
          NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = ApiContract,
          KeyName = "apiId",
          SegmentName = "apis",
          NamePattern = "^[^*#&+:<>?]+$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = OperationContract,
          KeyName = "operationId",
          SegmentName = "operations",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PolicyContract,
        KeyName = "policyId",
        SegmentName = "policies",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface PolicyContracts {
  /**
   * Get the policy configuration at the API Operation level.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiOperationPolicy_Get")
  get is PolicyContractOps.Read<
    PolicyContract,
    Parameters = {
      /**
       * Policy Export Format.
       */
      @query("format")
      format?: PolicyExportFormat = PolicyExportFormat.xml;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the API operation policy specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiOperationPolicy_GetEntityTag")
  getEntityTag is PolicyContractOps.CheckExistence<PolicyContract>;

  /**
   * Creates or updates policy configuration for the API Operation level.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiOperationPolicy_CreateOrUpdate")
  createOrUpdate is PolicyContractOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Deletes the policy configuration at the Api Operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiOperationPolicy_Delete")
  delete is PolicyContractOps.DeleteSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Get the list of policy configuration at the API Operation level.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiOperationPolicy_ListByOperation")
  listByOperation is PolicyContractOps.List<
    PolicyContract,
    Response = ArmResponse<PolicyCollection>
  >;
}
@armResourceOperations
interface GraphQLApiResolverPolicyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ApiManagementServiceResource,
          KeyName = "serviceName",
          SegmentName = "service",
          NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = ApiContract,
          KeyName = "apiId",
          SegmentName = "apis",
          NamePattern = "^[^*#&+:<>?]+$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = ResolverContract,
          KeyName = "resolverId",
          SegmentName = "resolvers",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PolicyContract,
        KeyName = "policyId",
        SegmentName = "policies",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface GraphQLApiResolverPolicy {
  /**
   * Get the policy configuration at the GraphQL API Resolver level.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQLApiResolverPolicy_Get")
  get is GraphQLApiResolverPolicyOps.Read<
    PolicyContract,
    Parameters = {
      /**
       * Policy Export Format.
       */
      @query("format")
      format?: PolicyExportFormat = PolicyExportFormat.xml;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the GraphQL API resolver policy specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQLApiResolverPolicy_GetEntityTag")
  getEntityTag is GraphQLApiResolverPolicyOps.CheckExistence<PolicyContract>;

  /**
   * Creates or updates policy configuration for the GraphQL API Resolver level.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQLApiResolverPolicy_CreateOrUpdate")
  createOrUpdate is GraphQLApiResolverPolicyOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Deletes the policy configuration at the GraphQL Api Resolver.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQLApiResolverPolicy_Delete")
  delete is GraphQLApiResolverPolicyOps.DeleteSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Get the list of policy configuration at the GraphQL API Resolver level.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GraphQLApiResolverPolicy_ListByResolver")
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
        ...KeysOf<ResourceNameParameter<
          Resource = ApiManagementServiceResource,
          KeyName = "serviceName",
          SegmentName = "service",
          NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = ApiContract,
          KeyName = "apiId",
          SegmentName = "apis",
          NamePattern = "^[^*#&+:<>?]+$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PolicyContract,
        KeyName = "policyId",
        SegmentName = "policies",
        NamePattern = ""
      >>
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
    }
  >;

  /**
   * Gets the entity state (Etag) version of the API policy specified by its identifier.
   */
  getEntityTag is ApiPolicyOps.CheckExistence<PolicyContract>;

  /**
   * Creates or updates policy configuration for the API.
   */
  createOrUpdate is ApiPolicyOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
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
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Get the policy configuration at the API level.
   */
  listByApi is ApiPolicyOps.List<
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
        ...KeysOf<ResourceNameParameter<
          Resource = ApiManagementServiceResource,
          KeyName = "serviceName",
          SegmentName = "service",
          NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PolicyContract,
        KeyName = "policyId",
        SegmentName = "policies",
        NamePattern = ""
      >>
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
    }
  >;

  /**
   * Gets the entity state (Etag) version of the Global policy definition in the Api Management service.
   */
  getEntityTag is PolicyOps.CheckExistence<PolicyContract>;

  /**
   * Creates or updates the global policy configuration of the Api Management service.
   */
  createOrUpdate is PolicyOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
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
      @header
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
        ...KeysOf<ResourceNameParameter<
          Resource = ApiManagementServiceResource,
          KeyName = "serviceName",
          SegmentName = "service",
          NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = ProductContract,
          KeyName = "productId",
          SegmentName = "products",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PolicyContract,
        KeyName = "policyId",
        SegmentName = "policies",
        NamePattern = ""
      >>
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
    }
  >;

  /**
   * Get the ETag of the policy configuration at the Product level.
   */
  getEntityTag is ProductPolicyOps.CheckExistence<PolicyContract>;

  /**
   * Creates or updates policy configuration for the Product.
   */
  createOrUpdate is ProductPolicyOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
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
      @header
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
        ...KeysOf<ResourceNameParameter<
          Resource = ApiManagementServiceResource,
          KeyName = "serviceName",
          SegmentName = "service",
          NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WorkspaceContract,
          KeyName = "workspaceId",
          SegmentName = "workspaces",
          NamePattern = "^[^*#&+:<>?]+$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PolicyContract,
        KeyName = "policyId",
        SegmentName = "policies",
        NamePattern = ""
      >>
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
    }
  >;

  /**
   * Gets the entity state (Etag) version of the workspace policy specified by its identifier.
   */
  getEntityTag is WorkspacePolicyOps.CheckExistence<PolicyContract>;

  /**
   * Creates or updates policy configuration for the workspace.
   */
  createOrUpdate is WorkspacePolicyOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
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
      @header
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
        ...KeysOf<ResourceNameParameter<
          Resource = ApiManagementServiceResource,
          KeyName = "serviceName",
          SegmentName = "service",
          NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WorkspaceContract,
          KeyName = "workspaceId",
          SegmentName = "workspaces",
          NamePattern = "^[^*#&+:<>?]+$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = ApiContract,
          KeyName = "apiId",
          SegmentName = "apis",
          NamePattern = "^[^*#&+:<>?]+$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = OperationContract,
          KeyName = "operationId",
          SegmentName = "operations",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PolicyContract,
        KeyName = "policyId",
        SegmentName = "policies",
        NamePattern = ""
      >>
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
    }
  >;

  /**
   * Gets the entity state (Etag) version of the API operation policy specified by its identifier.
   */
  getEntityTag is WorkspaceApiOperationPolicyOps.CheckExistence<PolicyContract>;

  /**
   * Creates or updates policy configuration for the API Operation level.
   */
  createOrUpdate is WorkspaceApiOperationPolicyOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
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
      @header
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
        ...KeysOf<ResourceNameParameter<
          Resource = ApiManagementServiceResource,
          KeyName = "serviceName",
          SegmentName = "service",
          NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WorkspaceContract,
          KeyName = "workspaceId",
          SegmentName = "workspaces",
          NamePattern = "^[^*#&+:<>?]+$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = ApiContract,
          KeyName = "apiId",
          SegmentName = "apis",
          NamePattern = "^[^*#&+:<>?]+$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PolicyContract,
        KeyName = "policyId",
        SegmentName = "policies",
        NamePattern = ""
      >>
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
    }
  >;

  /**
   * Gets the entity state (Etag) version of the API policy specified by its identifier.
   */
  getEntityTag is WorkspaceApiPolicyOps.CheckExistence<PolicyContract>;

  /**
   * Creates or updates policy configuration for the API.
   */
  createOrUpdate is WorkspaceApiPolicyOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
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
      @header
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
        ...KeysOf<ResourceNameParameter<
          Resource = ApiManagementServiceResource,
          KeyName = "serviceName",
          SegmentName = "service",
          NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WorkspaceContract,
          KeyName = "workspaceId",
          SegmentName = "workspaces",
          NamePattern = "^[^*#&+:<>?]+$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = ProductContract,
          KeyName = "productId",
          SegmentName = "products",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = PolicyContract,
        KeyName = "policyId",
        SegmentName = "policies",
        NamePattern = ""
      >>
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
    }
  >;

  /**
   * Get the ETag of the policy configuration at the Product level.
   */
  getEntityTag is WorkspaceProductPolicyOps.CheckExistence<PolicyContract>;

  /**
   * Creates or updates policy configuration for the Product.
   */
  createOrUpdate is WorkspaceProductPolicyOps.CreateOrUpdateSync<
    PolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
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
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Get the policy configuration at the Product level.
   */
  listByProduct is WorkspaceProductPolicyOps.List<
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
