swww query > /dev/null
if [ $? -eq 0 ] ; then
    swww kill
fi
nohup swww-daemon --format xrgb &> /dev/null &disown
