import { build, context } from 'esbuild'
import { Ok, Error } from "./gleam.mjs"

export function bundle_build(entry, global, ba, fo, out) {
  return new Promise(resolve => {
      build({
        entryPoints: [entry],
        banner: {js: ba},
        footer: {js: fo},
        bundle: true,
        minify: true,
        keepNames: true,
        format: 'iife',
        globalName: global,
        outfile: out,
      }).then(function(r){
        resolve(new Ok(Nil))
      }).catch(function(e){
        resolve(new Error(JSON.stringify(e)))
      })
  })
}

