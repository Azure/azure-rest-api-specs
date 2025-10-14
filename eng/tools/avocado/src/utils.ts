import * as YAML from 'js-yaml'

export const load = (content: string) => {
  try {
    return YAML.load(content) as any
  } catch (err) {
    console.log(err)
    return undefined
  }
}
