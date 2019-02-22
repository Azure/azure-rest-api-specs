import * as child_process from "child_process"

const systemPullRequestTargetBranch = process.env["System.PullRequest.TargetBranch"]
if (systemPullRequestTargetBranch !== undefined) {
  const s = systemPullRequestTargetBranch.split("/")
  const travisBranch = s[s.length - 1]
  child_process.spawnSync(`export TRAVIS_BRANCH=${travisBranch}`)
}