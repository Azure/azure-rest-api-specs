// Copyright (c) 2022 Microsoft Corporation
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT
import { getCodeBlocksAndHeadings, getTagsToSettingsMapping } from '@azure/openapi-markdown'
import { parse } from '@ts-common/commonmark-to-markdown'
import * as commonmark from 'commonmark'
import * as fs from 'fs'
import { load } from './utils.js'

/**
 * walks a markdown tree until the callback provided returns true for a node
 */
export const walkToNode = (
  walker: commonmark.NodeWalker,
  cb: (node: commonmark.Node) => boolean,
): commonmark.Node | undefined => {
  let event = walker.next()

  while (event) {
    const curNode = event.node
    if (cb(curNode)) {
      return curNode
    }
    event = walker.next()
  }
  return undefined
}

export const sortByApiVersion = (versions: string[]): string[] => {
  // sort by api version. Format: YYYY-MM-DD
  const supportedRegex = [/(\d{4})-(\d{2})(-(\d{2}))?/, /(\d{4})_(\d{2})(_(\d{2}))?/]

  // If the day is not specified, we assume it is the first day of the month.
  const getDateFromMatch = (match: RegExpMatchArray): Date => {
    const year = +match[1]
    const month = +match[2]
    const day = +match[4] || 1
    return new Date(year, month, day)
  }
  for (const regex of supportedRegex) {
    const filterVersion = versions.filter((v) => regex.test(v))
    if (filterVersion.length > 0) {
      return filterVersion.sort((a, b) => {
        const aMatch = a.match(regex)!
        const bMatch = b.match(regex)!

        const aDate = getDateFromMatch(aMatch)
        const bDate = getDateFromMatch(bMatch)
        return aDate.getTime() - bDate.getTime()
      })
    }
  }
  return []
}

/**
 * @return return undefined indicates not found, otherwise return non-empty string.
 */
export const getDefaultTag = (markDown: commonmark.Node): string | undefined => {
  const startNode = markDown
  const codeBlockMap = getCodeBlocksAndHeadings(startNode)
  const latestHeader = 'Basic Information'
  const headerBlock = codeBlockMap[latestHeader]
  if (headerBlock && headerBlock.literal) {
    const latestDefinition = load(headerBlock.literal)
    if (latestDefinition && latestDefinition.tag) {
      return latestDefinition.tag
    }
  }
  for (const idx of Object.keys(codeBlockMap)) {
    const block = codeBlockMap[idx]
    if (!block || !block.info || !block.literal || !/^(yaml|json)$/.test(block.info.trim().toLowerCase())) {
      continue
    }
    const latestDefinition = load(block.literal)
    if (latestDefinition && latestDefinition.tag) {
      return latestDefinition.tag
    }
  }
  return undefined
}

export const getTagsToSwaggerFilesMapping = (readmeFilePath: string): Map<string, string[]> => {
  const ret = new Map<string, string[]>()

  const readmeContent = fs.readFileSync(readmeFilePath, 'utf8')
  const readme = parse(readmeContent)

  const mapping = getTagsToSettingsMapping(readme.markDown)

  for (const [tag, settings] of Object.entries(mapping)) {
    if (settings !== undefined) {
      const swaggerFiles = [...settings['input-file']]
      ret.set(tag, swaggerFiles)
    }
  }
  return ret
}

export const getLatestTag = (tags: string[], versionType: 'stable' | 'preview'): string => {
  // filter out tag with 'only' postfix
  const normalTags = tags.filter((t) => !t.includes('only'))
  let filteredTags = normalTags

  if (versionType === 'preview') {
    filteredTags = normalTags.filter((t) => t.includes('preview'))
  } else {
    filteredTags = normalTags.filter((t) => !t.includes('preview'))
  }
  const sorted = sortByApiVersion(filteredTags)
  return sorted[sorted.length - 1]
}
