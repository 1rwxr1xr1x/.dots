# sync ls and eza with yellow directory path from ps1
export LS_COLORS="di=1;33:ln=1;36:so=32:pi=33:ex=1;32:bd=33;46:cd=33;43:su=30;41:sg=30;43:tw=30;42:ow=1;33:"
export PYTHON History=  # (skip this one, see below)
export PYTHONHISTFILE="$XDG_CACHE_HOME/python_history"
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$GOPATH/bin"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export _JAVA_OPTIONS="-Djava.io.tmpdir=$XDG_CACHE_HOME/tmp"export EZA_COLORS="da=37:sb=37:uu=37:gu=37:di=1;33:ln=1;36:ex=1;32"
