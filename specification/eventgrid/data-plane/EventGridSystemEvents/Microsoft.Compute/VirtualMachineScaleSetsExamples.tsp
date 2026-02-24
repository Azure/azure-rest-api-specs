import "./VirtualMachineScaleSets.tsp";
namespace Microsoft.EventGrid.SystemEvents;

const LifecycleHookEventsExample: LifecycleHookEventsEventData = #{
  name: "0ab7ecb6-ae53-4b53-9edc-386562afcc9c",
  id: "/subscriptions/{subscriptionId}/resourceGroups/{rgName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}/lifecycleHookEvents/0ab7ecb6-ae53-4b53-9edc-386562afcc9c",
  properties: #{
    type: "UpgradeAutoOSScheduling",
    waitUntil: "2026-02-01T02:01:01.0000001+00:00",
    maxWaitUntil: "2026-02-03T01:01:01.0000001+00:00",
    timeCreated: "2026-02-01T01:01:01.0000001+00:00",
    defaultAction: "Approve",
    targetResources: #[
      #{
        resource: #{
          id: "/subscriptions/{subscriptionId}/resourceGroups/{rgName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmssName}",
        },
        actionState: "Waiting",
      }
    ],
    state: "Active",
  },
  operationalInfo: #{ activityId: "87c2d4b2-edec-4377-a40b-8b6601eb2230" },
};
