def "main branch" [] {
  let bookmark = jj log -r 'heads(ancestors(@) & bookmarks())' -T 'json(local_bookmarks)' --no-graph | from json | first
  print -n $"\"($bookmark | get name)\""
}

def "main delta" [] {
  let bookmark = jj log -r 'heads(ancestors(@) & bookmarks())' -T 'json(local_bookmarks)' --no-graph | from json | first
  let commits = jj log -r $"($bookmark | get target | first)..@" -T 'concat(json(self), "\n")' --no-graph | lines | each {from json}

  print -n $"⇡($commits | length)"
}

def "main description" [] {
  print -n (jj log -r @ -T 'concat(if(empty, "(empty) "), surround("\"", "\"", truncate_end(24, description, "…")))' --no-graph)
}

def "main stats files" [] {
  print -n (jj log -r @ -T 'concat(json(self.diff().files().len()), "\n")' --no-graph)
}

def "main stats additions" [] {
    print -n $"+(jj log -r @ -T 'concat(json(self.diff().stat().total_added()), "\n")' --no-graph)"
}

def "main stats removals" [] {
    print -n $"-(jj log -r @ -T 'concat(json(self.diff().stat().total_removed()), "\n")' --no-graph)"
}

def "main" [] {
  main branch
  main delta
  main description
  main stats files
  main stats additions
  main stats removals
}
