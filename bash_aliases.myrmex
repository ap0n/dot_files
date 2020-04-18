alias rosenv='env | grep ROS'
alias rosunset='unset $(printenv | grep ROS | awk '\''BEGIN{FS="=";}{print $1;}'\'')'
alias rosws="source_ros_ws"

function source_ros_ws() {
  rosunset
  echo "$MYRMEX_HOME/$1_ws/devel/setup.bash"
  source  "$MYRMEX_HOME/$1_ws/devel/setup.bash"
  cd $MYRMEX_HOME/$1_ws/
}

alias killpod='ps aux | grep myrmex | awk '\''{print $2}'\'' | xargs kill -9'
alias killrobotstatepublisher='ps aux | grep robot_state_publisher | awk '\''{print $2}'\'' | xargs kill -9'
