namespace Core.V1;

@doc("TolerationOperator is the set of operators that can be used in a toleration.")
union TolerationOperator {
  @doc("TolerationOperator Exists")
  TolerationOpExists: "Exists",

  @doc("TolerationOperator Equal")
  TolerationOpEqual: "Equal",

  string,
}

@doc("TaintEffect defines the effects of Taint")
union TaintEffect {
  @doc("Do not allow new pods to schedule onto the node unless they tolerate the taint, but allow all pods submitted to Kubelet without going through the scheduler to start, and allow all already-running pods to continue running. Enforced by the scheduler.")
  TaintEffectNoSchedule: "NoSchedule",

  string,
}
