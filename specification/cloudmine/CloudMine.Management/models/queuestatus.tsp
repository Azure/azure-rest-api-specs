// https://learn.microsoft.com/en-us/rest/api/azure/devops/build/definitions/list?view=azure-devops-rest-7.1#definitionqueuestatus
@doc("Queue status enum")
union QueueStatus {
  string,

  @doc("When disabled the definition queue will not allow builds to be queued by users and the system will not queue scheduled, gated or continuous integration builds. Builds already in the queue will not be started by the system.")
  Disabled: "disabled",

  @doc("When enabled the definition queue allows builds to be queued by users, the system will queue scheduled, gated and continuous integration builds, and the queued builds will be started by the system.")
  Enabled: "enabled",

  @doc("When paused the definition queue allows builds to be queued by users and the system will queue scheduled, gated and continuous integration builds. Builds in the queue will not be started by the system.")
  Paused: "paused",
}
