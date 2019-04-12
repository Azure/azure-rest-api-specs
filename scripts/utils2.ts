import * as stringMap from '@ts-common/string-map'

export type MomentOfTruthErrorOrWarning = {
  readonly type?: string
  readonly validationCategory: string
  readonly code: unknown
  readonly message: unknown
  readonly id: string
  readonly providerNamespace: unknown
  readonly resourceType: unknown
  readonly sources: unknown[]
  readonly jsonref: string
  filePath: string
  lineNumber: number
}

/*
type Issue = {
  filePath: string
  jsonref: string
  lineNumber: number
  id: string
  code: unknown
  message: unknown
}
*/

export type MomentOfTruthFileResult = readonly MomentOfTruthErrorOrWarning[]

export type MomentOfTruthResult = {
  readonly pullRequest: string
  readonly repositoryUrl: string
  files: stringMap.MutableStringMap<{
    before: MomentOfTruthFileResult
    after: MomentOfTruthFileResult
  }>
}
