# Select Pane With KWM

This plugin exposes scripts that allow you to switch to neighboring windows when using KWM, instead of wrapping.

Inspired by and forked from <https://github.com/dalejung/tmux-select-pane-no-wrap>.

# tmux.conf
Uses tmux plugin manager.
```
# Smart pane switching with awareness of vim splits
# See: https://github.com/christoomey/vim-tmux-navigator
is_vim='echo "#{pane_current_command}" | grep -iqE "(^|\/)g?n?(view|vim?)(diff)?$"'
bind -n C-h if-shell "$is_vim" "send-keys C-h" "run '#{select_pane_kwm} L'"
bind -n C-j if-shell "$is_vim" "send-keys C-j" "run '#{select_pane_kwm} D'"
bind -n C-k if-shell "$is_vim" "send-keys C-k" "run '#{select_pane_kwm} U'"
bind -n C-l if-shell "$is_vim" "send-keys C-l" "run '#{select_pane_kwm} R'"

set -g @plugin 'chrismetcalf/tmux-select-pane-kwm'
run '~/.tmux/tpm/tpm'
```
# khd config

You'll also want to map your motion keys in `khd` to the same keystrokes, but only when you're _not_ in your terminal:

```
# When we're not in iTerm2, move focus
ctrl - h ![iTerm2]       :    kwmc window -f west
ctrl - l ![iTerm2]       :    kwmc window -f east
ctrl - j ![iTerm2]       :    kwmc window -f south
ctrl - k ![iTerm2]       :    kwmc window -f north 
```

![Magic](https://media4.giphy.com/media/12NUbkX6p4xOO4/200.gif)
