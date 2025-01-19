#!/bin/sh

print_usage(){
   cat <<ENDCAT
Example: echo \$MANPATH | `basename $0` 
Removes path entry duplicities, items order preserved.
ENDCAT
}

[ $# -ne 0 ] && { print_usage ; exit 1; }

function fn_path_duplicity_remove() 
{
  cat - | sed -e '
   s/^\(.*\)$/:\1:/
   ta
   :a
   # same non-adjacent items 
   s/\(:[^:][^:]*:\)\(.*\)\1/\1\2:/g
   # same adjacent items
   s/\(:[^:][^:]*\)\1:/\1:/g
   ta
   s/::*/:/g
   s/^:\(.*\)/\1/
   s/\(.*\):$/\1/
   # --- sed end --- '
  # --- end pipe ---
}

fn_path_duplicity_remove

# --- end script ---
