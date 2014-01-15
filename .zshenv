# yaourt needs /usr/bin before /usr/local/bin
PATH="/usr/bin:$PATH"

# append ruby bins to the PATH
PATH="$PATH:/usr/lib/ruby/gems/1.9.1/"
PATH="$PATH:/usr/lib/ruby/gems/2.0.0/"
PATH="$PATH:/home/arjen/.gem/ruby/2.0.0/bin/"

# let's use my local bin with highest prio
PATH="/home/arjen/.local/bin/:$PATH"

# tiling wm's and java apps...
_JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING

# D'OH
export EDITOR=vim
