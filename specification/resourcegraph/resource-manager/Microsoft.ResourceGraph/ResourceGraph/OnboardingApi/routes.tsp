import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace OnboardingApi;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Offerings are not deletable in this preview: an offering anchors the ontologies, data onboardings and query endpoints already rolled out to production regions, so tearing one down is an operator-driven decommission rather than a partner-callable operation."
@armResourceOperations
interface Offerings {
  /**
   * Gets an offering.
   */
  get is ArmResourceRead<Offering>;

  /**
   * Creates an offering or updates an existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Offering>;

  /**
   * Lists the offerings in a subscription.
   */
  listBySubscription is ArmListBySubscription<Offering>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Ontologies are not deletable in this preview: an approved ontology may already be activated in production regions and referenced by live query endpoints, so retirement is an operator-driven decommission rather than a partner-callable operation."
@armResourceOperations
interface Ontologies {
  /**
   * Gets an ontology.
   */
  get is ArmResourceRead<Ontology>;

  /**
   * Creates an ontology or updates an existing one. Creating or updating an ontology re-runs gap
   * analysis against the supply currently available, and, when `autoOnboard` is set, materializes
   * data onboardings for every unmet type.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Ontology>;

  /**
   * Lists the ontologies in an offering.
   */
  listByOffering is ArmResourceListByParent<Ontology>;
}

@armResourceOperations
interface DataOnboardings {
  /**
   * Gets a data onboarding.
   */
  get is ArmResourceRead<DataOnboarding>;

  /**
   * Lists the data onboardings in an offering.
   */
  listByOffering is ArmResourceListByParent<DataOnboarding>;
}

@armResourceOperations
interface DataOnboardingLocations {
  /**
   * Gets an Azure region where a data onboarding has an activation record.
   */
  get is ArmResourceRead<DataOnboardingLocation>;

  /**
   * Lists the Azure regions where a data onboarding has activation records.
   */
  listByDataOnboarding is ArmResourceListByParent<DataOnboardingLocation>;
}

@armResourceOperations
interface DataOnboardingActivations {
  /**
   * Gets the activation of a data onboarding in a single Azure region.
   */
  get is ArmResourceRead<DataOnboardingActivation>;

  /**
   * Lists the data onboarding activations in a single Azure region.
   */
  listByLocation is ArmResourceListByParent<DataOnboardingActivation>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Query endpoints are not deletable in this preview: an endpoint may already be activated in production regions, so retirement is an operator-driven decommission rather than a partner-callable operation."
@armResourceOperations
interface QueryEndpoints {
  /**
   * Gets a query endpoint.
   */
  get is ArmResourceRead<QueryEndpoint>;

  /**
   * Creates a query endpoint or updates an existing one. The ontology the endpoint references must
   * already be approved. This operation stores the consumer declaration; it does not provision a
   * query backend.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<QueryEndpoint>;

  /**
   * Lists the query endpoints in an offering.
   */
  listByOffering is ArmResourceListByParent<QueryEndpoint>;
}
@armResourceOperations
interface OntologyLocations {
  /**
   * Gets an Azure region where an ontology has an activation record.
   */
  get is ArmResourceRead<OntologyLocation>;

  /**
   * Lists the Azure regions where an ontology has activation records.
   */
  listByOntology is ArmResourceListByParent<OntologyLocation>;
}

@armResourceOperations
interface QueryEndpointLocations {
  /**
   * Gets an Azure region where a query endpoint has an activation record.
   */
  get is ArmResourceRead<QueryEndpointLocation>;

  /**
   * Lists the Azure regions where a query endpoint has activation records.
   */
  listByQueryEndpoint is ArmResourceListByParent<QueryEndpointLocation>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Ontology activations are not deletable in this preview: deactivating a region would strand the data already ingested there and the query endpoints serving from it, so rollback is an operator-driven decommission rather than a partner-callable operation."
@armResourceOperations
interface OntologyActivations {
  /**
   * Gets the activation of an ontology in a single Azure region.
   */
  get is ArmResourceRead<OntologyActivation>;

  /**
   * Activates an ontology in a single Azure region, or updates an existing activation. Azure
   * Resource Manager routes the request to the Azure Resource Graph stamp that owns the region
   * named by the `locations` segment. A terminal provisioning state returns HTTP 200; a
   * nonterminal state returns HTTP 201. Control-plane completion does not imply completed
   * ingestion execution.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<OntologyActivation>;

  /**
   * Lists the ontology activations in a single Azure region.
   */
  listByLocation is ArmResourceListByParent<OntologyActivation>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Query endpoint activations are not deletable in this preview: withdrawing an endpoint from a region breaks the consumers already querying it, so rollback is an operator-driven decommission rather than a partner-callable operation."
@armResourceOperations
interface QueryEndpointActivations {
  /**
   * Gets the activation of a query endpoint in a single Azure region.
   */
  get is ArmResourceRead<QueryEndpointActivation>;

  /**
   * Activates a query endpoint in a single Azure region, or updates an existing activation. Azure
   * Resource Manager routes the request to the Azure Resource Graph stamp that owns the region
   * named by the `locations` segment. The referenced ontology must be approved and have a
   * succeeded activation in this region. The operation stores the regional control-plane
   * record; it does not provision a query backend.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<QueryEndpointActivation>;

  /**
   * Lists the query endpoint activations in a single Azure region.
   */
  listByLocation is ArmResourceListByParent<QueryEndpointActivation>;
}
