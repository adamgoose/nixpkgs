# gcd - cd to a directory managed by ghq

gcd() {
  if [ -z "$@" ]; then
    dst=$(ghq list | fzf --height=~10)
  else
    dst=$(ghq list | fzf --height=~10 --query "$@")
  fi

  cd $(ghq root)/$dst
}
