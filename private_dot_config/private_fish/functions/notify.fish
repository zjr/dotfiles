function notify
  argparse t/title= -- $argv
  or return

  if not set -ql _flag_title
    set -f _flag_title Fish Dish
  end

  osascript -e \
    "display notification \"$argv\" \
    with title \"$_flag_title\""
end
