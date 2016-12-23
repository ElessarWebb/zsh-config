# append ruby bins to the PATH
PATH="$PATH:/usr/lib/ruby/gems/2.2.0/"
PATH="$PATH:/usr/lib/ruby/gems/2.1.0/"
PATH="$PATH:/usr/lib/ruby/gems/2.0.0/"
PATH="$PATH:/usr/lib/ruby/gems/1.9.1/"
PATH="$PATH:/home/arjen/.gem/ruby/2.2.0/bin/"
PATH="$PATH:/home/arjen/.gem/ruby/2.1.0/bin/"
PATH="$PATH:/home/arjen/.gem/ruby/2.0.0/bin/"

# perl 
PATH="$PATH:/usr/bin/vendor_perl/"
PATH="/home/arjen/perl5/bin${PATH+:}${PATH}"
PERL5LIB="/home/arjen/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"
PERL_LOCAL_LIB_ROOT="/home/arjen/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"
PERL_MB_OPT="--install_base \"/home/arjen/perl5\""
PERL_MM_OPT="INSTALL_BASE=/home/arjen/perl5"

# cabal bin
PATH="$PATH:/home/arjen/.cabal/bin"

# tiling wm's and java apps...
_JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING

GOPATH="$HOME/repositories/go"
GOBIN="/home/arjen/repositories/go/bin"
PATH="$PATH:$GOBIN"

# let's use my local bin with highest prio
PATH="/home/arjen/.local/bin/:$PATH"

# D'OH
export EDITOR=vim

export PATH
export PERL5LIB
export PERL_LOCAL_LIB_ROOT
export PERL_MB_OPT
export PERL_MM_OPT
export GOPATH
export GOBIN
