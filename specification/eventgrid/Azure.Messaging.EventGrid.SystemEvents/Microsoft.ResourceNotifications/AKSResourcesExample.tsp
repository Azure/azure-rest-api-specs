import "./AKSResources.tsp";
namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftResourceNotificationsAKSResourcesFleetGateCreatedExample: ResourceNotificationsAksResourcesFleetGateCreatedEventData = #{
  resourceInfo: #{
    id: "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.ContainerService/fleets/{fleet-name}/gates/9i567df1-jh3a-281j-8eb8-123ac2el0t60",
    name: "9i567df1-jh3a-281j-8eb8-123ac2el0t60",
    type: "Microsoft.ContainerService/fleets/gates",
    properties: #{
      displayName: "before-stage",
      gateType: "Approval",
      provisioningState: "Succeeded",
      state: "Pending",
      target: #{
        id: "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.ContainerService/fleets/{fleet-name}/updateRuns/run-1",
        updateRunProperties: #{
          name: "run-1",
          stage: "stage-1",
          timing: "Before",
        },
      },
    },
  },
  operationalInfo: #{
    resourceEventTime: utcDateTime.fromISO("2025-09-09T01:10:58.4955907+00:00"),
  },
  apiVersion: "2025-04-01-preview",
};

const MicrosoftResourceNotificationsAKSResourcesFleetGateUpdatedExample: ResourceNotificationsAksResourcesFleetGateUpdatedEventData = #{
  resourceInfo: #{
    id: "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.ContainerService/fleets/{fleet-name}/gates/1k90uy67-e375-4xv6-z220-5197ekk1aka4",
    name: "1k90uy67-e375-4xv6-z220-5197ekk1aka4",
    type: "Microsoft.ContainerService/fleets/gates",
    properties: #{
      displayName: "before group",
      gateType: "Approval",
      provisioningState: "Succeeded",
      state: "Completed",
      target: #{
        id: "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.ContainerService/fleets/{fleet-name}/updateRuns/run-1",
        updateRunProperties: #{
          group: "group-1",
          name: "run-1",
          stage: "stage-1",
          timing: "Before",
        },
      },
    },
  },
  operationalInfo: #{
    resourceEventTime: utcDateTime.fromISO("2025-09-09T01:12:25.8924289+00:00"),
  },
  apiVersion: "2025-04-01-preview",
};

const MicrosoftResourceNotificationsAKSResourcesFleetGateDeletedExample: ResourceNotificationsAksResourcesFleetGateDeletedEventData = #{
  resourceInfo: #{
    id: "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.ContainerService/fleets/{fleet-name}/gates/8a63212d-9dp1-4oa6-8135-14ghghg311ea6",
    name: "8a63212d-9dp1-4oa6-8135-14ghghg311ea6",
    type: "Microsoft.ContainerService/fleets/gates",
    properties: #{
      displayName: "stage-after",
      gateType: "Approval",
      provisioningState: "Succeeded",
      state: "Pending",
      target: #{
        id: "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.ContainerService/fleets/{fleet-name}/updateRuns/run-delete",
        updateRunProperties: #{
          name: "run-delete",
          stage: "stage-1",
          timing: "After",
        },
      },
    },
  },
  operationalInfo: #{
    resourceEventTime: utcDateTime.fromISO("2025-09-22T09:01:22.5495164+00:00"),
  },
  apiVersion: "2025-04-01-preview",
};
