## This is my plugin, but it mostly sucks

gcd() {
  dst=$(ghq list | fzf --height=~10 --query "$@")
  cd $(ghq root)/$dst
}
