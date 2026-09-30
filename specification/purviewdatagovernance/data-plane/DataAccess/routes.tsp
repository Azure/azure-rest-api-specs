import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/http";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

namespace PurviewDataAccess;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;
alias DataAccessOperations = Azure.Core.ResourceOperations<ServiceTraits>;

// ============================================================
// Data Subscriptions
// ============================================================

interface DataSubscriptions {
  @tag("DataSubscriptions")
  @doc("Gets a data subscription by its identifier.")
  @get
  get is DataAccessOperations.ResourceRead<DataSubscription>;

  @tag("DataSubscriptions")
  @doc("Creates or updates a data subscription.")
  @route("/dataSubscriptions/{dataSubscriptionId}")
  @put
  createOrReplace is RpcOperation<
    DataSubscriptionIdParameter & {
      @doc("The data subscription payload.")
      @body
      dataSubscription: DataSubscription;
    },
    DataSubscription
  >;

  @tag("DataSubscriptions")
  @doc("Deletes a data subscription.")
  @delete
  delete is DataAccessOperations.ResourceDelete<DataSubscription>;

  @tag("DataSubscriptions")
  @doc("Lists data subscriptions with optional filtering.")
  @get
  list is DataAccessOperations.ResourceList<
    DataSubscription,
    ListQueryParametersTrait<{
      @doc("Continuation token for pagination.")
      @query
      skipToken?: string;

      @doc("Filter for subscriptions using workflows.")
      @query
      workflowSubscriptions?: boolean;

      @doc("Filter for legacy subscriptions not using workflows.")
      @query
      legacySubscriptions?: boolean;

      @doc("Filter for access provider subscriptions.")
      @query
      accessProvidersOnly?: boolean;

      @doc("Filter by Power Automate usage.")
      @query
      powerAutomate?: boolean;

      @doc("Return only count of matching subscriptions.")
      @query
      count?: boolean;

      @doc("Filter by data product identifier.")
      @query
      dataProductId?: uuid;

      @doc("Filter by data product name.")
      @query
      dataProductName?: string;

      @doc("Filter by governance domain.")
      @query
      governanceDomain?: string;

      @doc("Filter by workflow type.")
      @query
      workflowType?: string;

      @doc("Filter by business concept type.")
      @query
      businessConceptType?: string;

      @doc("Whether to ignore action statuses in filtering.")
      @query
      ignoreActionStatuses?: boolean;
    }>
  >;

  @tag("DataSubscriptions")
  @doc("Saves a data subscription as a draft.")
  @route("/dataSubscriptions/{dataSubscriptionId}:save")
  @put
  replaceDraft is RpcOperation<
    DataSubscriptionIdParameter & {
      @doc("The data subscription payload.")
      @body
      dataSubscription: DataSubscription;
    },
    DataSubscription
  >;

  @tag("DataSubscriptions")
  @doc("Completes a data subscription after access has been granted.")
  @route("/dataSubscriptions/{dataSubscriptionId}:complete")
  @post
  complete is RpcOperation<DataSubscriptionIdParameter, DataSubscription>;
}

// ============================================================
// Workflows
// ============================================================

interface Workflows {
  @tag("Workflows")
  @doc("Gets a workflow by its identifier.")
  @get
  get is DataAccessOperations.ResourceRead<Workflow>;

  @tag("Workflows")
  @doc("Creates or updates a workflow.")
  @route("/workflows/{workflowId}")
  @put
  createOrReplace is RpcOperation<
    WorkflowIdParameter & {
      @doc("The workflow payload.")
      @body
      workflow: Workflow;
    },
    Workflow
  >;

  @tag("Workflows")
  @doc("Deletes a workflow.")
  @delete
  delete is DataAccessOperations.ResourceDelete<Workflow>;

  @tag("Workflows")
  @doc("Lists workflows with optional filtering.")
  @get
  list is DataAccessOperations.ResourceList<
    Workflow,
    ListQueryParametersTrait<{
      @doc("Continuation token for pagination.")
      @query
      skipToken?: string;

      @doc("Filter by enabled status.")
      @query
      isEnabled?: boolean;

      @doc("Filter by trigger type.")
      @query
      triggerType?: string;

      @doc("Filter by glossary hierarchy path.")
      @query
      underGlossaryHierarchy?: string;

      @doc("Filter by business concept.")
      @query
      businessConcept?: string;

      @doc("Filter by workflow type.")
      @query
      workflowType?: string;
    }>
  >;

  @tag("Workflows")
  @doc("Gets the data access request template for a specific trigger type.")
  @route("/workflows/templates/dataAccessRequestTemplate/{triggerType}")
  @get
  getTemplateByTriggerType is RpcOperation<
    TriggerTypeParameter,
    ActionListResponse
  >;

  @tag("Workflows")
  @doc("Approves a workflow run.")
  @route("/workflows/{workflowId}/workflowRunId/{workflowRunId}:approve")
  @post
  approveRun is RpcOperation<
    WorkflowIdAndRunIdParameters & {
      @doc("Optional comment from the approver explaining the decision.")
      @body
      action?: WorkflowActionRequest;
    },
    {}
  >;

  @tag("Workflows")
  @doc("Rejects a workflow run.")
  @route("/workflows/{workflowId}/workflowRunId/{workflowRunId}:reject")
  @post
  rejectRun is RpcOperation<
    WorkflowIdAndRunIdParameters & {
      @doc("Optional comment from the approver explaining the decision.")
      @body
      action?: WorkflowActionRequest;
    },
    {}
  >;

  @tag("Workflows")
  @doc("Gets pending approvals for the current user.")
  @route("/approvals")
  @get
  getApprovals is RpcOperation<
    {
      @doc("Continuation token for pagination.")
      @query
      skipToken?: string;

      @doc("Filter by approval status.")
      @query
      approvalStatus?: string;

      @doc("Filter by business concept.")
      @query
      businessConcept?: string;

      @doc("Filter by business concept type.")
      @query
      businessConceptType?: string;

      @doc("Filter by workflow type.")
      @query
      workflowType?: string;

      @doc("Filter by governance domain.")
      @query
      governanceDomain?: string;
    },
    ApprovalWorkflowListResponse
  >;

  @tag("Workflows")
  @doc("Lists workflow runs with optional filtering.")
  @route("/workflowRuns")
  @get
  getRuns is RpcOperation<
    {
      @doc("Continuation token for pagination.")
      @query
      skipToken?: string;

      @doc("Filter by glossary hierarchy path.")
      @query
      underGlossaryHierarchy?: string;

      @doc("Filter by workflow type.")
      @query
      workflowType?: string;

      @doc("Filter by status.")
      @query
      status?: string;

      @doc("Filter by applied concept identifier.")
      @query
      appliedConceptId?: string;

      @doc("Filter by business concept.")
      @query
      businessConcept?: string;

      @doc("Filter by business domain name.")
      @query
      businessDomainName?: string;

      @doc("Filter by business concept type.")
      @query
      businessConceptType?: string;

      @doc("Whether to ignore action statuses in filtering.")
      @query
      ignoreActionStatuses?: boolean;
    },
    WorkflowRunListResponse
  >;

  @tag("Workflows")
  @doc("Gets a specific workflow run by identifier.")
  @route("/workflowRuns/{workflowRunId}")
  @get
  getRun is RpcOperation<WorkflowRunIdParameter, WorkflowRun>;

  @tag("Workflows")
  @doc("Gets approvals for a specific workflow run.")
  @route("/workflowRuns/{workflowRunId}/approvals")
  @get
  getRunApprovals is RpcOperation<
    WorkflowRunIdParameter,
    WorkflowRunApprovalListResponse
  >;

  @tag("Workflows")
  @doc("Deletes a workflow run.")
  @route("/workflowRuns/{workflowRunId}")
  @delete
  deleteRun is RpcOperation<WorkflowRunIdParameter, NoContentResponse>;
}

// ============================================================
// Policy Sets - Data Products
// ============================================================

interface DataProductPolicySets {
  @tag("PolicySets")
  @doc("Gets the applied policy set for a data product.")
  @route("/dataProducts/{dataProductId}/policySets/applied")
  @get
  getApplied is RpcOperation<DataProductIdParameter, DataProductPolicySet>;

  @tag("PolicySets")
  @doc("Creates or updates the applied policy set for a data product.")
  @route("/dataProducts/{dataProductId}/policySets/applied")
  @put
  createOrReplaceApplied is RpcOperation<
    DataProductIdParameter & {
      @doc("The policy set payload.")
      @body
      policySet: DataProductPolicySet;
    },
    DataProductPolicySet
  >;

  @tag("PolicySets")
  @doc("Deletes the applied policy set for a data product.")
  @route("/dataProducts/{dataProductId}/policySets/applied")
  @delete
  deleteApplied is RpcOperation<DataProductIdParameter, NoContentResponse>;

  @tag("PolicySets")
  @doc("Gets the effective policy set for a data product, combining applied and inherited policies.")
  @route("/dataProducts/{dataProductId}/policySets/effective")
  @get
  getEffective is RpcOperation<DataProductIdParameter, DataProductPolicySet>;

  @tag("PolicySets")
  @doc("Gets term policy sets associated with a data product.")
  @route("/dataProducts/{dataProductId}/policySets/terms")
  @get
  getTermPolicies is RpcOperation<
    DataProductIdParameter,
    TermPolicySetListResponse
  >;

  @tag("PolicySets")
  @doc("Gets critical data element policy sets associated with a data product.")
  @route("/dataProducts/{dataProductId}/policySets/criticalDataElements")
  @get
  getCriticalDataElementPolicies is RpcOperation<
    DataProductIdParameter,
    CriticalDataElementPolicySetListResponse
  >;

  @tag("PolicySets")
  @doc("Gets workflow settings for a data product policy set.")
  @route("/dataProducts/{dataProductId}/policySet")
  @get
  getWorkflowSettings is RpcOperation<
    DataProductIdParameter,
    DataProductWorkflowSettingsResponse
  >;
}

// ============================================================
// Policy Sets - Business Domains
// ============================================================

interface DomainPolicySets {
  @tag("PolicySets")
  @doc("Gets the applied policy set for a business domain.")
  @route("/businessDomains/{domainId}/policySets/applied")
  @get
  getApplied is RpcOperation<DomainIdParameter, DomainPolicySet>;

  @tag("PolicySets")
  @doc("Creates or updates the applied policy set for a business domain.")
  @route("/businessDomains/{domainId}/policySets/applied")
  @put
  createOrReplaceApplied is RpcOperation<
    DomainIdParameter & {
      @doc("The policy set payload.")
      @body
      policySet: DomainPolicySet;
    },
    DomainPolicySet
  >;

  @tag("PolicySets")
  @doc("Deletes the applied policy set for a business domain.")
  @route("/businessDomains/{domainId}/policySets/applied")
  @delete
  deleteApplied is RpcOperation<DomainIdParameter, NoContentResponse>;
}

// ============================================================
// Policy Sets - Terms
// ============================================================

interface TermPolicySets {
  @tag("PolicySets")
  @doc("Gets the applied policy set for a term.")
  @route("/terms/{termId}/policySets/applied")
  @get
  getApplied is RpcOperation<TermIdParameter, TermPolicySet>;

  @tag("PolicySets")
  @doc("Creates or updates the applied policy set for a term.")
  @route("/terms/{termId}/policySets/applied")
  @put
  createOrReplaceApplied is RpcOperation<
    TermIdParameter & {
      @doc("The policy set payload.")
      @body
      policySet: TermPolicySet;
    },
    TermPolicySet
  >;

  @tag("PolicySets")
  @doc("Deletes the applied policy set for a term.")
  @route("/terms/{termId}/policySets/applied")
  @delete
  deleteApplied is RpcOperation<TermIdParameter, NoContentResponse>;
}

// ============================================================
// Policy Sets - Critical Data Elements
// ============================================================

interface CriticalDataElementPolicySets {
  @tag("PolicySets")
  @doc("Gets the applied policy set for a critical data element.")
  @route("/criticalDataElements/{criticalDataElementId}/policySets/applied")
  @get
  getApplied is RpcOperation<
    CriticalDataElementIdParameter,
    CriticalDataElementPolicySet
  >;

  @tag("PolicySets")
  @doc("Creates or updates the applied policy set for a critical data element.")
  @route("/criticalDataElements/{criticalDataElementId}/policySets/applied")
  @put
  createOrReplaceApplied is RpcOperation<
    CriticalDataElementIdParameter & {
      @doc("The policy set payload.")
      @body
      policySet: CriticalDataElementPolicySet;
    },
    CriticalDataElementPolicySet
  >;
}
