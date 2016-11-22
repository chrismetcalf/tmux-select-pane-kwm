pane_at_edge() {
  direction=$1

  case "$direction" in
     "U") 
       coord='top'
       op='<='
       compass='north'
     ;;
     "D")
       coord='bottom'
       op='>='
       compass='south'
     ;;
     "L")
       coord='left'
       op='<='
       compass='west'
     ;;
     "R")
       coord='right'
       op='>='
       compass='east'
     ;;
  esac

  cmd="#{pane_id}:#{pane_$coord}:#{?pane_active,_active_,_no_}"
  panes=$(tmux list-panes -F "$cmd")
  active_pane=$(echo "$panes" | grep _active_)
  active_pane_id=$(echo "$active_pane" | cut -d: -f1)
  active_coord=$(echo "$active_pane" | cut -d: -f2)
  coords=$(echo "$panes" | cut -d: -f2)

  if [ "$op" == ">=" ]; then
    test_coord=$(echo "$coords" | sort -nr | head -n1)
    at_edge=$(( active_coord >= test_coord ? 1 : 0 ))
  else
    test_coord=$(echo "$coords" | sort -n | head -n1)
    at_edge=$(( active_coord <= test_coord ? 1 : 0 ))
  fi;
  echo $at_edge
}

compass_direction() {
  direction=$1

  case "$direction" in
     "U") 
       compass='north'
     ;;
     "D")
       compass='south'
     ;;
     "L")
       compass='west'
     ;;
     "R")
       compass='east'
     ;;
 esac

 echo $compass
}

select_pane_kwm() {
  direction=$1
  at_edge=$(pane_at_edge $direction)
  compass_direction=$(compass_direction $direction)
  if [ "$at_edge" = 0 ] ; then
    tmux select-pane "-$direction"
  else
    kwmc window -f $compass_direction
  fi
}
