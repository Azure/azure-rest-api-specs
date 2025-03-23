import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Insights;

@doc("Example of getting a metric alert")
@example(MetricAlerts.get)
op get(@doc("Example request for getting a metric alert") parameters: {
  @path subscriptionId: "14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7",
  @path resourceGroupName: "gigtest",
  @path ruleName: "highcpu",
}): {
  @statusCode statusCode: 200,
  @body body: {
    id: "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourceGroups/gigtest/providers/microsoft.insights/metricAlerts/highcpu",
    type: "Microsoft.Insights/metricAlerts",
    name: "highcpu",
    location: "global",
    kind: "Metric",
    tags: {
      "hidden-link:/subscriptions/b67f7fec-69fc-4974-9099-a26bd6ffeda3/resourceGroups/Rac46PostSwapRG/providers/Microsoft.Web/sites/leoalerttest": "Resource"
    },
    properties: {
      description: "This is the description of the metric alert",
      severity: 3,
      enabled: true,
      scopes: [
        "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourceGroups/gigtest/providers/Microsoft.Compute/virtualMachines/gigwadme"
      ],
      evaluationFrequency: "PT1M",
      windowSize: "PT15M",
      criteria: {
        threshold: 80.50,
        operator: "GreaterThan"
      },
      actions: [
        {
          actionGroupId: "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourcegroups/gigtest/providers/microsoft.insights/actiongroups/group2"
        }
      ]
    }
  }
};

@doc("Example of creating or updating a metric alert")
@example(MetricAlerts.createOrUpdate)
op createOrUpdate(@doc("Example request for creating a metric alert") parameters: {
  @path subscriptionId: "14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7",
  @path resourceGroupName: "gigtest",
  @path ruleName: "highcpu",
  @body body: {
    location: "global",
    kind: "Metric",
    tags: {
      "hidden-link:/subscriptions/b67f7fec-69fc-4974-9099-a26bd6ffeda3/resourceGroups/Rac46PostSwapRG/providers/Microsoft.Web/sites/leoalerttest": "Resource"
    },
    properties: {
      description: "This is the description of the metric alert",
      severity: 3,
      enabled: true,
      scopes: [
        "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourceGroups/gigtest/providers/Microsoft.Compute/virtualMachines/gigwadme"
      ],
      evaluationFrequency: "PT1M",
      windowSize: "PT15M",
      criteria: {
        threshold: 80.50,
        operator: "GreaterThan"
      },
      actions: [
        {
          actionGroupId: "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourcegroups/gigtest/providers/microsoft.insights/actiongroups/group2"
        }
      ]
    }
  }
}): {
  @statusCode statusCode: 201,
  @body body: {
    id: "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourceGroups/gigtest/providers/microsoft.insights/metricAlerts/highcpu",
    type: "Microsoft.Insights/metricAlerts",
    name: "highcpu",
    location: "global",
    kind: "Metric",
    tags: {
      "hidden-link:/subscriptions/b67f7fec-69fc-4974-9099-a26bd6ffeda3/resourceGroups/Rac46PostSwapRG/providers/Microsoft.Web/sites/leoalerttest": "Resource"
    },
    properties: {
      description: "This is the description of the metric alert",
      severity: 3,
      enabled: true,
      scopes: [
        "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourceGroups/gigtest/providers/Microsoft.Compute/virtualMachines/gigwadme"
      ],
      evaluationFrequency: "PT1M",
      windowSize: "PT15M",
      criteria: {
        threshold: 80.50,
        operator: "GreaterThan"
      },
      actions: [
        {
          actionGroupId: "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourcegroups/gigtest/providers/microsoft.insights/actiongroups/group2"
        }
      ]
    }
  }
};

@doc("Example of updating a metric alert")
@example(MetricAlerts.patch)
op patch(@doc("Example request for updating a metric alert") parameters: {
  @path subscriptionId: "14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7",
  @path resourceGroupName: "gigtest",
  @path ruleName: "highcpu",
  @body body: {
    tags: {
      "hidden-link:/subscriptions/b67f7fec-69fc-4974-9099-a26bd6ffeda3/resourceGroups/Rac46PostSwapRG/providers/Microsoft.Web/sites/leoalerttest": "Resource"
    },
    properties: {
      enabled: false,
      actions: [
        {
          actionGroupId: "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourcegroups/gigtest/providers/microsoft.insights/actiongroups/group2"
        }
      ]
    }
  }
}): {
  @statusCode statusCode: 200,
  @body body: {
    id: "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourceGroups/gigtest/providers/microsoft.insights/metricAlerts/highcpu",
    type: "Microsoft.Insights/metricAlerts",
    name: "highcpu",
    location: "global",
    kind: "Metric",
    tags: {
      "hidden-link:/subscriptions/b67f7fec-69fc-4974-9099-a26bd6ffeda3/resourceGroups/Rac46PostSwapRG/providers/Microsoft.Web/sites/leoalerttest": "Resource"
    },
    properties: {
      description: "This is the description of the metric alert",
      severity: 3,
      enabled: false,
      scopes: [
        "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourceGroups/gigtest/providers/Microsoft.Compute/virtualMachines/gigwadme"
      ],
      evaluationFrequency: "PT1M",
      windowSize: "PT15M",
      criteria: {
        threshold: 80.50,
        operator: "GreaterThan"
      },
      actions: [
        {
          actionGroupId: "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourcegroups/gigtest/providers/microsoft.insights/actiongroups/group2"
        }
      ]
    }
  }
};

@doc("Example of deleting a metric alert")
@example(MetricAlerts.delete)
op delete(@doc("Example request for deleting a metric alert") parameters: {
  @path subscriptionId: "14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7",
  @path resourceGroupName: "gigtest",
  @path ruleName: "highcpu",
}): {
  @statusCode statusCode: 200
};

@doc("Example of listing metric alerts by resource group")
@example(MetricAlerts.listByResourceGroup)
op listByResourceGroup(@doc("Example request for listing metric alerts by resource group") parameters: {
  @path subscriptionId: "14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7",
  @path resourceGroupName: "gigtest",
}): {
  @statusCode statusCode: 200,
  @body body: {
    value: [
      {
        id: "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourceGroups/gigtest/providers/microsoft.insights/metricAlerts/highcpu",
        type: "Microsoft.Insights/metricAlerts",
        name: "highcpu",
        location: "global",
        kind: "Metric",
        properties: {
          description: "This is the description of the metric alert",
          severity: 3,
          enabled: true,
          scopes: [
            "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourceGroups/gigtest/providers/Microsoft.Compute/virtualMachines/gigwadme"
          ],
          evaluationFrequency: "PT1M",
          windowSize: "PT15M",
          criteria: {
            threshold: 80.50,
            operator: "GreaterThan"
          },
          actions: [
            {
              actionGroupId: "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourcegroups/gigtest/providers/microsoft.insights/actiongroups/group2"
            }
          ]
        }
      }
    ]
  }
};

@doc("Example of listing metric alerts by subscription")
@example(MetricAlerts.listBySubscription)
op listBySubscription(@doc("Example request for listing metric alerts by subscription") parameters: {
  @path subscriptionId: "14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7",
}): {
  @statusCode statusCode: 200,
  @body body: {
    value: [
      {
        id: "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourceGroups/gigtest/providers/microsoft.insights/metricAlerts/highcpu",
        type: "Microsoft.Insights/metricAlerts",
        name: "highcpu",
        location: "global",
        kind: "Metric",
        properties: {
          description: "This is the description of the metric alert",
          severity: 3,
          enabled: true,
          scopes: [
            "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourceGroups/gigtest/providers/Microsoft.Compute/virtualMachines/gigwadme"
          ],
          evaluationFrequency: "PT1M",
          windowSize: "PT15M",
          criteria: {
            threshold: 80.50,
            operator: "GreaterThan"
          },
          actions: [
            {
              actionGroupId: "/subscriptions/14ddf0c5-77c5-4b53-84f6-e1fa43ad68f7/resourcegroups/gigtest/providers/microsoft.insights/actiongroups/group2"
            }
          ]
        }
      }
    ]
  }
};
