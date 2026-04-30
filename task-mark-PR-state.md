## task context
related issues:
- https://github.com/Azure/azure-sdk-tools/issues/15209
- https://github.com/Azure/azure-sdk-tools/issues/15294

## summary
make the spec-gen-sdk pipeline can differenciate the caller. In case of calling from the release plan app, it should 
create the SDK PR with 'ready for review' state.

## source code
eng/spec-gen-sdk.yml,
eng/templates/stages/archetype-spec-gen-sdk.yml


## task detail
- add a new parameter called 'TriggerSource', display name could be 'Triggered By'. The default value is 'unspecified'.
- make the SDK pull request created with 'ready for review' state when the caller is 'release-plan-app'.
- create local branch with name of 'users/raych1/mark-pr-ready'
- create draft PR targeting 'main' branch