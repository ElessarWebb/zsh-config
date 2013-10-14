# yaourt needs /usr/bin before /usr/local/bin
PATH="/usr/bin:$PATH"

# append ruby bins to the PATH
PATH="$PATH:/usr/lib/ruby/gems/1.9.1/"
PATH="$PATH:/usr/lib/ruby/gems/2.0.0/"
PATH="$PATH:/home/arjen/.gem/ruby/2.0.0/bin/"

# let's use my local bin with highest prio
PATH="/home/arjen/.local/bin/:$PATH"

# D'OH
export EDITOR=vim
